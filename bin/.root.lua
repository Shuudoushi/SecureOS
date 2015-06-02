local kill = true
local superauth = require("superauth")
local event = require("event")
local shell = require("shell")
local term = require("term")
local io = require("io")
local timer_id = event.timer(...)

local function root()
 hn = io.open("/tmp/.hostname.dat", "r")
  texthn = hn:read()
   hn:close()

 local dir = shell.getWorkingDirectory()
 local userHome = "/usr/home/" .. texthn .. "/"

if dir ~= userHome and dir <= userHome then
 print("This action requires root access.")
  os.sleep(1.5)
   term.clear()
   term.setCursor(1,1)
  superauth()
 end
if superauth() == kill then
 event.cancel(timer_id)
 end
end

event.timer(1, root, math.huge)

timer_id = event.timer(...)