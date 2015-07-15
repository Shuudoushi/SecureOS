local fs = require("filesystem")
local shell = require("shell")
local event = require("event")

if fs.isAutorunEnabled() == true then
  fs.setAutorunEnabled(false)
end

fs.remove("/tmp/.root")
shell.setWorkingDirectory("/")
shell.execute("/boot/99_login.lua")
