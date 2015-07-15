local keyboard = require("keyboard")
local computer = require("computer")
local event = require("event")
local shell = require("shell")
local auth = require("auth")
local term = require("term")

local running = true

local args = {...}
local path = shell.resolve(...)

--[[if not args == "su" then
  path = shell.resolve(...)
end]]

local function check() -- Prevents "ctrl+alt+c" and "ctrl+c".
  if keyboard.isControlDown() then
    io.stderr:write("( ͡° ͜ʖ ͡°)")
    os.sleep(0.1)
    computer.shutdown(true)
 end
end
event.listen("key_down", check)

local function suAuth()

  hn = io.open("/tmp/.hostname.dat", "r") -- Reads the hostname file.
   texthn = hn:read()
    hn:close()

--[[  k = io.open("/tmp/.key", "r") -- Depreciated
   textk = k:read()
    k:close()

    event.cancel(tonumber(textk))]]

--[[  shell.setWorkingDirectory("/home/" .. texthn .. "/")
  term.clear()
  term.setCursor(1,1)
  print(_OSVERSION .. " " .. os.date("%F %X"))
  print("Root Login")
  term.write("User: ")
    username = term.read()
    username = string.gsub(username, "\n", "")
    username = string.lower(username)
  term.write("\n")]]
  term.write("Password: ")
    password = term.read(nil, nil, nil, "")
    password = string.gsub(password, "\n", "")

  login, super = auth.validate(texthn, password)

  if login and super then
    auth.userLog(username, "root pass")
    local r = io.open("/tmp/.root", "w")
      r:write("true")
       r:close()
    print("Logged in as Root.")
      os.sleep(1)
    --[[term.clear()
    term.setCursor(1,1)
      os.setenv("PS1", "root" .. "@" .. texthn .. "$ ")
      shell.setWorkingDirectory("/")]]
      username, password = "" -- This is just a "bandaid fix" till I find a better way of doing it.
      event.ignore("key_down", check)
      os.sleep(0.1)
      shell.execute(path)
      shell.execute("rm /tmp/.root")
    running = false
  else
    auth.userLog(username, "root fail")
    io.stderr:write("Login failed.")
      --shell.setWorkingDirectory("/home/" .. texthn .. "/")
      --shell.execute("/root/.root.lua")
      event.ignore("key_down", check)
    running = false
 end
end

while running do
  suAuth()
end
