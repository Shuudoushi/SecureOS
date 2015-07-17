local keyboard = require("keyboard")
local computer = require("computer")
local event = require("event")
local shell = require("shell")
local auth = require("auth")
local term = require("term")

local args = {...}

local function suAuth()
  hn = io.open("/tmp/.hostname.dat", "r") -- Reads the hostname file.
   texthn = hn:read()
    hn:close()

  term.write("Password: ")
    password = term.read(nil, nil, nil, "")
    password = string.gsub(password, "\n", "")

  login, super = auth.validate(texthn, password)

  if login and super then
    auth.userLog(username, "root pass")
    local r = io.open("/tmp/.root", "w")
      r:write("true")
       r:close()
      username, password = "" -- This is just a "bandaid fix" till I find a better way of doing it.
      os.sleep(0.1)
      shell.execute(path)
      shell.execute("rm /tmp/.root")
  else
    auth.userLog(username, "root fail")
    io.stderr:write("Login failed.")
    username, password = "" -- This is just a "bandaid fix" till I find a better way of doing it.
  end
end

local function suAuthPerm()
  hn = io.open("/tmp/.hostname.dat", "r") -- Reads the hostname file.
   texthn = hn:read()
    hn:close()

  term.write("Password: ")
    password = term.read(nil, nil, nil, "")
    password = string.gsub(password, "\n", "")

  login, super = auth.validate(texthn, password)

  if login and super then
    auth.userLog(username, "root pass")
    local r = io.open("/tmp/.root", "w")
      r:write("true")
       r:close()
      username, password = "" -- This is just a "bandaid fix" till I find a better way of doing it.
      os.sleep(0.1)
      os.setenv("PS1", "root@" .. texthn .. "# ") -- Sets the user environment.
      shell.setWorkingDirectory("/root")
      os.setenv("HOME", "/root")
      os.setenv("USER", "/root")
  else
    auth.userLog(username, "root fail")
    io.stderr:write("Login failed.")
    username, password = "" -- This is just a "bandaid fix" till I find a better way of doing it.
  end
end

if #args == 1 then
  path = shell.getAlias(args[1])
  suAuth()
elseif #args == 1 and args[1] == "su" then
  suAuthPerm()
else
  io.stderr:write("error") -- Too lazy to properly do this bit atm...
end
