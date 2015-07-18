local shell = require("shell")
local term = require("term")

local function root()
  local root = false
  if require("filesystem").exists("/tmp/.root") then
    local r = io.open("/tmp/.root", "r")
     root = r:read()
      r:close()
  end
  return root
end

local root = root()

if not root then
  io.stderr:write("not authorized")
  return
end

local hn = io.open("/tmp/.hostname.dat", "r") -- Reads the hostname file.
 texthn = hn:read()
  hn:close()

  os.setenv("PS1", "root@" .. texthn .. "$ ") -- Sets the user environment.
  shell.setWorkingDirectory("/root")
  os.setenv("HOME", "/root")
  os.setenv("USER", "/root")
