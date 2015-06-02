local keyboard = require("keyboard")
local event = require("event")
local shell = require("shell")
local term = require("term")
local io = require("io")

local function check() -- Prevents "ctrl+alt+c".
 if keyboard.isControlDown() and keyboard.isAltDown() then
  computer.shutdown(true)
 end
end
event.listen("key_down", check)

return function()

  hn = io.open("/tmp/.hostname.dat", "r") -- Reads the hostname file.
   texthn = hn:read()
    hn:close()

  us = io.open("/.usernames.dat", "r") -- Reads the root user file.
   textus = us:read()
    us:close()

  ps = io.open("/.passwords.dat", "r") -- Reads the root password file
   textps = ps:read()
    ps:close()

   shell.setWorkingDirectory("/usr/home/" .. texthn .. "/")
   term.clear()
   term.setCursor(1,1)
    term.write("User: ")
     username = term.read()
     username = string.gsub(username, "\n", "")
   term.setCursor(1,2)
    term.write("Password: ")
     password = term.read(nil, nil, nil, "")
     password = string.gsub(password, "\n", "")
  if username == textus and password == textps then
   term.clear()
   term.setCursor(1,1)
   print("Logged in as Root.")
    os.sleep(1)
   term.clear()
   term.setCursor(1,1)
    os.setenv("PS1", "root" .. "@" .. texthn .. "$ ")
    shell.setWorkingDirectory("/")
   return true
  else
   print("Login failed.")
    shell.setWorkingDirectory("/usr/home/" .. texthn .. "/")
   return false
 end
end