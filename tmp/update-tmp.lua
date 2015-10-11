local fs = require("filesystem")
local shell = require("shell")

if not fs.exists("/tmp/update-tmp.cfg") then
  u = io.open("/etc/update.cfg", "r")
     textu = u:read()
      u:close()
else
  u = io.open("/tmp/update-tmp.cfg", "r")
   textu = u:read()
    u:close()
end

if not require("filesystem").exists("/sbin") then
  require("filesystem").makeDirectory("/sbin")
end

shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/sbin/update.lua /sbin/update.lua \n")
os.remove("/tmp/depreciated.dat")
os.sleep(1.5)
