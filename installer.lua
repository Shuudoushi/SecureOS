local computer = require("computer")
local fs = require("filesystem")
local kb = require("keyboard")
local event = require("event")
local shell = require("shell")
local sha = require("sha256")
local term = require("term")
local io = require("io")

local running = true

local function greeting()
term.clear()
term.setCursor(1,1)
	print("Welcome to the OpenOS_Plus installer!")
	print("This installer will help guide you through setting up and installing OpenOS_Plus.")
	print("Press any key to continue.")
local event = event.pull("key_down")
	if event then
		term.clear()
		term.setCursor(1,1)
	end
end

local function downLoad()
	term.write("Please wait while the files are downloaded and installed.")
	term.setCursor(1,2)
shell.execute("wget https://raw.githubusercontent.com/Shuudoushi/OpenOS_Plus/master/autorun.lua")
	os.sleep(1)
	term.setCursor(1,4)
shell.execute("wget https://raw.githubusercontent.com/Shuudoushi/OpenOS_Plus/master/lib/superauth.lua /lib/superauth.lua")
	os.sleep(1)
	term.setCursor(1,6)
shell.execute("wget https://raw.githubusercontent.com/Shuudoushi/OpenOS_Plus/master/bin/logout.lua /bin/logout.lua")
	os.sleep(1)
	term.setCursor(1,8)
shell.execute("wget https://raw.githubusercontent.com/Shuudoushi/OpenOS_Plus/master/bin/usage.lua /bin/usage.lua")
	os.sleep(1)
	term.setCursor(1,10)
shell.execute("wget https://raw.githubusercontent.com/Shuudoushi/OpenOS_Plus/master/bin/.root.lua /bin/.root.lua")
	os.sleep(1)
	term.setCursor(1,12)
shell.execute("wget https://raw.githubusercontent.com/Shuudoushi/OpenOS_Plus/master/bin/update.lua /bin/update.lua")
	os.sleep(1)
	term.setCursor(1,14)
end

local function userInfo()
	term.clear()
	term.setCursor(1,1)
	term.write("Please enter a username and password. Usernames must be lowercase.")
	term.setCursor(1,2)
	term.write("Username: ")
		username = term.read()
		username = string.gsub(username, "\n", "")
		username = string.lower(username)
	term.setCursor(1,3)
	term.write("Password: ")
		password = term.read(nil, nil, nil, "")
		password = string.gsub(password, "\n", "")
		password = sha.sha256(password)

	u = io.open("/.userName.dat", "w")
		u:write(username .. ":" .. password)
			u:close()

	u = io.open("/.usernames.dat", "w")
		u:write(username .. ":" .. password)
			u:close()
			
	if not fs.exists("/usr/home/" .. username .. "/") then
		fs.makeDirectory("/usr/home/" .. username .. "/")
	end

	term.clear()
	term.setCursor(1,1)
	term.write("Would you like to restart now? [Y/n]")
	term.setCursor(1,2)
		input = term.read()
		input = string.gsub(input, "\n", "")
			if input == "y" or "yes" or "Y" or "Yes" then
				computer.shutdown(true)
			end

			if input == "n" or "no" or "N" or "No" then
				term.clear()
				term.setCursor(1,1)
				running = false
			end
end

while running do
	greeting()
	downLoad()
	userInfo()
end