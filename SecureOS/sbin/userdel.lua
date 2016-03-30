local computer = require("computer")
local fs = require("filesystem")
local shell = require("shell")
local term = require("term")
local auth = require("auth")

if not require("auth").isRoot() then
  io.stderr:write("not authorized")
  return 1
end

local args = shell.parse(...)

if #args ~= 0 then
  username = string.lower(args[1])
  auth.rmUser(username)
  auth.userLog(os.getenv("USER"), "removed " .. username)

--[[  if computer.users(username) == true then
    computer.removeUser(username)
  end]]

  if fs.exists("/home/" .. username .. "/") then
    fs.remove("/home/" .. username .. "/")
  end
  print(username.. " removed")
  username = ""
elseif #args == 0 then
  term.clear()
  term.setCursor(1,1)
  term.write("Please enter a username to delete from the system.")
  term.setCursor(1,2)
  term.write("Username: ")
    username = string.lower(io.read())

  auth.rmUser(username)
  auth.userLog(os.getenv("USER"), "removed " .. username)

--[[  if computer.users(username) == true then
    computer.removeUser(username)
  end]]

  if fs.exists("/home/" .. username .. "/") then
      fs.remove("/home/" .. username .. "/")
  end

  username = ""

else
  return 1
end
