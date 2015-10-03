local computer = require("computer")
local fs = require("filesystem")
local shell = require("shell")
local term = require("term")
local auth = require("auth")

if not require("auth").isRoot() then
  io.stderr:write("not authorized")
  return
end

local args = shell.parse(...)

if #args ~= 0 then
  username = args[1]
  username = string.lower(username)
  auth.rmUser(username)
  auth.userLog(username, "removed")
  if fs.exists("/home/" .. username .. "/") then
    fs.remove("/home/" .. username .. "/")
  end
  print(username.. " removed")
  computer.removeUser(username)
  username = ""
elseif #args == 0 then
  term.clear()
  term.setCursor(1,1)
  term.write("Please enter a username to delete from the system.")
  term.setCursor(1,2)
  term.write("Username: ")
    username = term.read()
    username = string.gsub(username, "\n", "")
    username = string.lower(username)

  auth.rmUser(username)
  auth.userLog(username, "removed")

  if fs.exists("/home/" .. username .. "/") then
      fs.remove("/home/" .. username .. "/")
  end

  computer.removeUser(username)
  username = ""

else
  return
end
