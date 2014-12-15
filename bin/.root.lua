local term = require("term")
local shell = require("shell")
local io = require("io")

hn = io.open("/tmp/.hostname.dat", "r")
 texthn = hn:read()
  hn:close()

local dir = shell.getWorkingDirectory()
local userHome = "/usr/home/" .. texthn .. "/"

while true do
  if dir ~= userHome and dir <= userHome then
   print("This action requires root access.")
    os.sleep(1.5)
     term.clear()
     term.setCursor(1,1)
   shell.execute("/bin/.superauth.lua")
  break
 end
  os.sleep(0.1)
end
