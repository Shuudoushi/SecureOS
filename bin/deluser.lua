local fs = require("filesystem")
local term = require("term")
local auth = require("auth")

term.clear()
term.setCursor(1,1)
term.write("Please enter a username to delete from the system.")
term.setCursor(1,2)
term.write("Username: ")
	username = term.read()
	username = string.gsub(username, "\n", "")
	username = string.lower(username)

auth.rmUser(username)

if fs.exists("/home/" .. username .. "/") then
	fs.remove("/home/" .. username .. "/")
end