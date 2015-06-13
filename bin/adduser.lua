local fs = require("filesystem")
local term = require("term")
local auth = require("auth")

term.clear()
term.setCursor(1,1)
term.write("Please enter a username and password to add to the system. Usernames must be lowercase.")
term.setCursor(1,2)
term.write("Username: ")
	username = term.read()
	username = string.gsub(username, "\n", "")
	username = string.lower(username)
term.setCursor(1,3)
term.write("Password: ")
	password = term.read(nil, nil, nil, "")
	password = string.gsub(password, "\n", "")
term.setCursor(1,4)
term.write("Root rights (Y/n): ")
	su = term.read()
	su = string.gsub(su, "\n", "")
	su = string.lower(su)

if su == "y" then
	su = true
elseif su == "n" then
	su = false
end

auth.addUser(username, password, su)

if not fs.exists("/usr/home/" .. username .. "/") then
	fs.makeDirectory("/usr/home/" .. username .. "/")
end