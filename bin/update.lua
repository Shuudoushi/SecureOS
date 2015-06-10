local computer = require("computer")
local shell = require("shell")
local term = require("term")

term.clear()
term.setCursor(1,1)
print("OpenOS_Plus will now update.")
	os.sleep(1)
	term.setCursor(1,2)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/OpenOS_Plus/master/autorun.lua")
	os.sleep(1)
	term.setCursor(1,4)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/OpenOS_Plus/master/root/sudo.lua /root/sudo.lua")
	os.sleep(1)
	term.setCursor(1,6)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/OpenOS_Plus/master/bin/logout.lua /bin/logout.lua")
	os.sleep(1)
	term.setCursor(1,8)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/OpenOS_Plus/master/bin/usage.lua /bin/usage.lua")
	os.sleep(1)
	term.setCursor(1,10)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/OpenOS_Plus/master/root/.root.lua /root/.root.lua")
	os.sleep(1)
	term.setCursor(1,12)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/OpenOS_Plus/master/bin/update.lua /bin/update.lua")
	os.sleep(1)
	term.setCursor(1,14)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/OpenOS_Plus/master/lib/sha256.lua /lib/sha256.lua")
	os.sleep(1)
	term.setCursor(1,16)
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/OpenOS_Plus/master/lib/auth.lua /lib/auth.lua")
	os.sleep(1)
	term.setCursor(1,18)
term.clear()
term.setCursor(1,1)
print("Update complete. System restarting now.")
	os.sleep(2.5)
	computer.shutdown(true)