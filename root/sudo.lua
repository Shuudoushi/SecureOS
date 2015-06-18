local keyboard = require("keyboard")
local computer = require("computer")
local event = require("event")
local shell = require("shell")
local auth = require("auth")
local term = require("term")

local running = true

local function check() -- Prevents "ctrl+alt+c" and "ctrl+c".
 if keyboard.isControlDown() then
  print("( ͡° ͜ʖ ͡°)")
  os.sleep(0.1)
  computer.shutdown(true)
 end
end
event.listen("key_down", check)

local function suAuth()

  hn = io.open("/tmp/.hostname.dat", "r") -- Reads the hostname file.
   texthn = hn:read()
    hn:close()

  k = io.open("/tmp/.key", "r")
   textk = k:read()
    k:close()

    event.cancel(tonumber(textk))

   shell.setWorkingDirectory("/usr/home/" .. texthn .. "/")
   term.clear()
   term.setCursor(1,1)
   print("SecureOS 0.5 " .. os.date("%F %T"))
    term.write("User: ")
     username = term.read()
     username = string.gsub(username, "\n", "")
     username = string.lower(username)
   term.setCursor(1,3)
    term.write("Password: ")
     password = term.read(nil, nil, nil, "")
     password = string.gsub(password, "\n", "")

  login, super = auth.validate(username, password)

  if login and super then
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