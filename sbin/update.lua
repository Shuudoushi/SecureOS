local component = require("component")
local computer = require("computer")
local fs = require("filesystem")
local shell = require("shell")
local term = require("term")

if not require("auth").isRoot() then
  io.stderr:write("not authorized")
  return
end

local args, options = shell.parse(...)

if not component.isAvailable("internet") then
  io.stderr:write("No internet card found.")
  return
end

local function update(args, options)

  if #args == 0 then
    u = io.open("/etc/update.cfg", "r")
      textu = u:read()
        u:close()
  end

  if #args == 1 then
    textu = args[1]
    if textu ~= "dev" and textu ~= "release" then
      io.stderr:write("Not a vaild repo tree.")
      return
    end
  end

  if options.a then
    uw = io.open("/etc/update.cfg", "w")
      uw:write(tostring(args[1]))
        uw:close()
  end

  if not fs.exists("/sbin") then
    fs.makeDirectory("/sbin")
  end

  local function myversions()
    local env = {}
    local config = loadfile("/.version", nil, env)
    if config then
      pcall(config)
    end
    return env.myversions
  end

  local function onlineVersions()
    shell.execute("wget -fq https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/.version /tmp/versions.dat")
    local env = {}
    local config = loadfile("/tmp/versions.dat", nil, env)
    if config then
      pcall(config)
    end
    return env.myversions
  end

  local myversions = myversions()
  local onlineVersions = onlineVersions()

term.clear()
term.setCursor(1,1)
print("SecureOS will now update from " .. textu .. ".")
  os.sleep(1)
  print("Checking for depreciated packages.")
  shell.execute("wget -fq https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/tmp/depreciated.dat /tmp/depreciated.dat")

  local function depreciated()
    local env = {}
    local config = loadfile("/tmp/depreciated.dat", nil, env)
    if config then
      pcall(config)
    end
    return env.depreciated
  end

  local depreciated = depreciated()

  if depreciated then
    for i = 1, #depreciated do
      local files = os.remove(shell.resolve(depreciated[i]))
      if files ~= nil then
        print("Removed " .. depreciated[i] .. ": a depreciated package")
      end
    end
    print("Finished")
  end

  if myversions then
    for k,_ in pairs(myversions) do
      k = updatePackage

      print("Checking "..updatePackage.." for updates.")
      if myversions[updatePackage] < onlineVersions[updatePackage] then
        function downloadupdatePackage()
          shell.execute("wget -fq https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/tmp/"..updatePackage..".dat /tmp/"..updatePackage..".dat")
          local env = {}
          local config = loadfile("/tmp/"..updatePackage..".dat", nil, env)
          if config then
            pcall(config)
          end
          return env.updatePackage
        end

        local downloadupdatePackage = downloadupdatePackage()

        if downloadupdatePackage then
          for i = 1, #downloadupdatePackage do
            shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. downloadupdatePackage[i])
          end
          print("Package "..updatePackage.." up-to-date")
        end

      else
        print("Package "..updatePackage.." up-to-date")
      end
    end
  end

shell.execute("mv -f /tmp/versions.dat /.version")
os.remove("/tmp/bin.dat")
os.remove("/tmp/boot.dat")
os.remove("/tmp/etc.dat")
os.remove("/tmp/lib.dat")
os.remove("/tmp/root.dat")
os.remove("/tmp/sbin.dat")
os.remove("/tmp/system.dat")
os.remove("/tmp/usr.dat")
os.remove("/tmp/depreciated.dat")
require("auth").userLog(os.getenv("USER"), "update")
term.clear()
term.setCursor(1,1)
print("Update complete. System restarting now.")
  os.sleep(2.5)
  os.remove("/tmp/.root")
  computer.shutdown(true)
end

update(args, options)
