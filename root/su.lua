local shell = require("shell")
local term = require("term")

local hn = io.open("/tmp/.hostname.dat", "r") -- Reads the hostname file.
 texthn = hn:read()
  hn:close()

  os.setenv("PS1", "root@" .. texthn .. "$ ") -- Sets the user environment.
  shell.setWorkingDirectory("/root")
  os.setenv("HOME", "/root")
  os.setenv("USER", "/root")
