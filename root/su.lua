local shell = require("shell")
local term = require("term")

if not require("auth").isRoot() then
  io.stderr:write("not authorized")
  return
end

local hn = io.open("/tmp/.hostname.dat", "r") -- Reads the hostname file.
 texthn = hn:read()
  hn:close()

  if os.getenv("HOSTNAME") == nil then -- Sets the user environment.
    os.setenv("PS1", "root@" .. texthn .. "$ ")
  else
    os.setenv("PS1", "root@" .. os.getenv("HOSTNAME") .. "$ ")
  end
  shell.setWorkingDirectory("/root")
  os.setenv("HOME", "/root")
  os.setenv("USER", "root")
