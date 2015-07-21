local shell = require("shell")
local auth = require("auth")
local term = require("term")

local args = {...}

if #args ~= 0 then
  path = shell.getAlias(args[1])
else
  io.stderr:write("error") -- Too lazy to properly do this bit atm...
end

local hn = io.open("/tmp/.hostname.dat", "r") -- Reads the hostname file.
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
    shell.execute(path, args[2], ...)
    if not args[1] == "su" then
      os.remove("/tmp/.root")
    end
else
  auth.userLog(username, "root fail")
  io.stderr:write("Login failed.")
  username, password = "" -- This is just a "bandaid fix" till I find a better way of doing it.
end
