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
local v = io.open("/.verion", "w")
v:write("myversions = { bin = "tostring(0)", boot = "tostring(0)", etc = "tostring(0)", lib = "tostring(0)", root = "tostring(0)", sbin = "tostring(0)", system = "tostring(0)", usr = "tostring(0)" }")
v:close()
print("The updater has changed, please run it again after reboot")
os.remove("/tmp/depreciated.dat")
os.sleep(1.5)
