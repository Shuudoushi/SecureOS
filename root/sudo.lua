local keyboard = require("keyboard")
local event = require("event")
local shell = require("shell")
local sha = require("sha256")
local term = require("term")

local running = true

local function check() -- Prevents "ctrl+alt+c".
 if keyboard.isControlDown() and keyboard.isAltDown() then
  computer.shutdown(true)
 end
end
event.listen("key_down", check)

local function suAuth()

  hn = io.open("/tmp/.hostname.dat", "r") -- Reads the hostname file.
   texthn = hn:read()
    hn:close()

  us = io.open("/.userName.dat", "r") -- Reads the root user file.
   textus = us:read()
    us:close()

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
     password = sha.sha256(password)

  _username, _password = textus:match("([^:]+):([^:]+)")

  if username == _username and password == _password then
   print("Logged in as Root.")
    os.sleep(1)
   term.clear()
   term.setCursor(1,1)
    os.setenv("PS1", "root" .. "@" .. texthn .. "$ ")
    shell.setWorkingDirectory("/")
    event.ignore("key_down", check)
   running = false
  else
   print("Login failed.")
    shell.setWorkingDirectory("/usr/home/" .. texthn .. "/")
    shell.execute("/root/.root.lua")
    event.ignore("key_down", check)
   running = false
 end
end

while running do
  suAuth()
end