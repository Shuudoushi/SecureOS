local fs = require("filesystem")
local shell = require("shell")
local event = require("event")

if fs.isAutorunEnabled() == true then
  fs.setAutorunEnabled(false)
end

require("auth").userLog("logout")
fs.remove("/tmp/.root")
shell.setWorkingDirectory("/")
shell.execute("/boot/z_login.lua")
