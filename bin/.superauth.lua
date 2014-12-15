local term = require("term")
local shell = require("shell")
local io = require("io")
local process = require("process")
local event = require("event")
local keyboard = require("keyboard")

hn = io.open("/tmp/.hostname.dat", "r")
 texthn = hn:read()
  hn:close()

us = io.open("/usernames.dat", "r")
 textus = us:read()
  us:close()

ps = io.open("/passwords.dat", "r")
 textps = ps:read()
  ps:close()

function check()
 if keyboard.isControlDown() and keyboard.isAltDown() then
  computer.shutdown(true)
 end
end
event.listen("key_down", check)

while true do
  print("User: ")
   username = term.read()
   username = string.gsub(username, "\n", "")
  print("Password: ")
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
  break
 else
  print("Login failed.")
   shell.setWorkingDirectory("/usr/home/" .. texthn .. "/")
    process.load("/bin/.root.lua")
  break
 end
end
