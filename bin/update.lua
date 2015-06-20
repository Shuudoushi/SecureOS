local computer = require("computer")
local shell = require("shell")
local term = require("term")

local args, options = shell.parse(...)

local function update(args, options)

	if #args == 0 then
		u = io.open("/etc/update.cfg", "r")
		 textu = u:read()
		  u:close()
	end

	if #args == 1 then
		textu = args[1]
	end

	if options.a then
		uw = io.open("/etc/update.cfg", "w")
		 io.write(tostring(args[1]))
		  uw:close()
	end

term.clear()
term.setCursor(1,1)
print("SecureOS will now update.")
	os.sleep(1)
	term.setCursor(1,2)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/boot/99_login.lua /boot/99_login.lua \n")
	os.sleep(1)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/root/sudo.lua /root/sudo.lua \n")
	os.sleep(1)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/root/.root.lua /root/.root.lua \n")
	os.sleep(1)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/bin/logout.lua /bin/logout.lua \n")
	os.sleep(1)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/bin/usage.lua /bin/usage.lua \n")
	os.sleep(1)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/bin/update.lua /bin/update.lua \n")
	os.sleep(1)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/bin/adduser.lua /bin/adduser.lua \n")
	os.sleep(1)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/bin/deluser.lua /bin/deluser.lua \n")
	os.sleep(1)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/bin/uninstall.lua /bin/uninstall.lua \n")
	os.sleep(1)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/lib/sha256.lua /lib/sha256.lua \n")
	os.sleep(1)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/lib/auth.lua /lib/auth.lua \n")
	os.sleep(1)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/init.lua /init.lua \n")
	os.sleep(1)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/.osprop /.osprop \n")
	os.sleep(1)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/etc/motd /etc/motd \n")
	os.sleep(1)
term.clear()
term.setCursor(1,1)
print("Update complete. System restarting now.")
	os.sleep(2.5)
	computer.shutdown(true)
end

update(args, options)