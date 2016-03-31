local computer = require("computer")
local fs = require("filesystem")
local shell = require("shell")
local term = require("term")
local auth = require("auth")

if not require("auth").isRoot() then
  io.stderr:write("not authorized")
  return 1
end

local args, options = shell.parse(...)

local function dirTree(username)
  if not fs.exists("/home/" .. username .. "/") then
    fs.makeDirectory("/home/" .. username .. "/")
    fs.makeDirectory("/home/" .. username .. "/bin/")
    fs.makeDirectory("/home/" .. username .. "/lib/")
    fs.makeDirectory("/home/" .. username .. "/var/")
    os.execute("cp /home/.shrc /home/" .. username .. "/.shrc")
  end
end

if #args >= 2 then
  username = args[1]
  password = args[2]

  if args[3] == "true" then
    su = true
  elseif args[3] == "false" then
    su = false
  elseif args[3] == nil then
    su = false
  else io.stderr:write("Invalid.")
    return
  end
--[[
  if options.r then
    computer.addUser(args[1])
  end]]

  auth.addUser(args[1], args[2], su)
  dirTree(username)
  auth.userLog(os.getenv("USER"), "added " .. username)
  print(username .. " added")
  username, password, su = ""
  return
else
  term.clear()
  term.setCursor(1,1)
  term.write("Please enter a username and password to add to the system.")
  term.setCursor(1,2)
  term.write("Username: ")
    username = string.lower(io.read())
  term.setCursor(1,3)
  term.write("Password: ")
    password = string.gsub(term.read({pwchar=""}), "\n", "")
  term.setCursor(1,4)
  term.write("Root rights (Y/n): ")
    su = string.lower(io.read())
  term.setCursor(1,5)
--[[  term.write("System user (Y/n)")
    system = term.read()
    system = string.gsub(system, "\n", "")]]

  if su == "y" or su == "yes" then
    su = true
  elseif su == "n" or su == "no" then
    su = false
  elseif su == nil then
    su = false
  else io.stderr:write("Invalid.")
    return 1
  end

--[[  if system == "y" or system == "yes" then
    system = true
  elseif system == "n" or system == "no" then
    system = false
  elseif system == nil then
    system = false
  else io.stderr:write("Invaild.")
    return
  end

  if system == true then
    computer.addUser(username)
  end]]

  dirTree(username)
  auth.addUser(username, password, su)
  auth.userLog(os.getenv("USER"), "added " .. username)
  username, password, su = ""
end
