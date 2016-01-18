local fs = require("filesystem")
local shell = require("shell")

local recycle = "/tmp/trash"

if not fs.exists(recycle) then
  fs.makeDirectory(recycle)
end

local args, options = shell.parse(...)
if #args == 0 then
  io.write("Usage: rm [-vf] <filename1> [<filename2> [...]]\n")
  io.write(" -v: verbose output\n")
  io.write(" -n: no-preserve")
  return
end

for i = 1, #args do
  local path = shell.resolve(args[i])
  if not fs.rename(path, recycle .. "/" .. fs.name(path)) then
    --io.stderr:write(path .. ": no such file, or permission denied\n") Yeah... It errors anyway...
  end
  if options.v then
    io.write("removed '" .. path .. "'\n")
  end
  if options.n or options["no-preserve"] then
    if not os.remove(path) then
      io.stderr:write(path .. ": no such file, or permission denied\n")
    end
  end
end
