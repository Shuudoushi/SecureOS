local shell = require("shell")
local term = require("term")

local hn = io.open("/tmp/.hostname.dat", "r") -- Reads the hostname file.
 texthn = hn:read()
  hn:close()

  local r = io.open("/tmp/.root", "w")
    r:write("true")
     r:close()
    username, password = "" -- This is just a "bandaid fix" till I find a better way of doing it.
    os.sleep(0.1)
    os.setenv("PS1", "root@" .. texthn .. "# ") -- Sets the user environment.
    shell.setWorkingDirectory("/root")
    os.setenv("HOME", "/root")
    os.setenv("USER", "/root")
