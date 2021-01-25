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

  local function dirs()
    local env = {}
    local config = loadfile("/tmp/dirs.dat", nil, env)
    if config then
      pcall(config)
    end
    return env.dirs
  end

  local dirs = dirs()

  if dirs then
    for i = 1, #dirs do
      local files = fs.makeDirectory(shell.resolve(dirs[i]))
      if files ~= nil then
        print("Made missing directory: " .. dirs[i])
      end
    end
    print("Finished\n")
  end

shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/sbin/update.lua /sbin/update.lua \n")
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/sbin/login.lua /sbin/login.lua \n")
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/init.lua /init.lua \n")
shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/boot/kernel/SecureOS /boot/kernel/SecureOS \n")
local v = io.open("/.version", "w")
v:write("myversions = { bin = '0', boot = '0', etc = '0', lib = '0', root = '0', sbin = '0', system = '0', usr = '0' }")
v:close()
print("The updater has changed, please run it again after reboot")
if not require("event").pull() == "key_down" then os.sleep(30) end
os.remove("/tmp/depreciated.dat")
os.sleep(1.5)
