local component = require("component")
local computer = require("computer")
local fs = require("filesystem")
local shell = require("shell")
local term = require("term")

if not require("auth").isRoot() then
  io.stderr:write("not authorized")
  return 1
end

local args, options = shell.parse(...)

if not component.isAvailable("internet") then
  io.stderr:write("No internet card found.")
  return 1
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
      return 1
    end
  end

  if options.a then
    uw = io.open("/etc/update.cfg", "w")
      uw:write(tostring(args[1]))
        uw:close()
  end

  if not fs.exists("/tmp/.hold") then
    hd = io.open("/tmp/.hold", "w")
      hd:write(os.date())
        hd:close()
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
    shell.execute("wget -fq https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/SecureOS/.version /tmp/versions.dat")
    local env = {}
    local config = loadfile("/tmp/versions.dat", nil, env)
    if config then
      pcall(config)
    end
    return env.myversions
  end

--[[  if options.f or options.force then
    myversions = 0
  else
    myversions = myversions()
  end]]

  local myversions = myversions()
  local onlineVersions = onlineVersions()

term.clear()
term.setCursor(1,1)
print("SecureOS will now update from " .. textu .. ".\n")
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
    print("Finished\n")
  end

  print("Checking for missing directories.")
  shell.execute("wget -fq https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/tmp/dirs.dat /tmp/dirs.dat")

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
        print("Created missing directory: " .. dirs[i])
      end
    end
    print("Finished\n")
  end

  print("Checking for missing system files.")
  shell.execute("wget -fq https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/tmp/sf.dat /tmp/sf.dat")

  local function sf()
    local env = {}
    local config = loadfile("/tmp/sf.dat", nil, env)
    if config then
      pcall(config)
    end
    return env.sf
  end

  local sf = sf()

  if sf then
    for i = 1, #sf do
      local files = shell.resolve(sf[i])
      if files ~= nil then
        shell.execute("wget -q https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/SecureOS" .. sf[i] .. " " .. sf[i])
        print("Created missing system file: " .. sf[i])
      end
    end
    print("Finished\n")
  end

  print("Checking bin for updates.") -- I know, I know... But it'll work till I fix the 'compact' code...
  if myversions["bin"] < onlineVersions["bin"] then
    function downloadBin()
      shell.execute("wget -fq https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/tmp/bin.dat /tmp/bin.dat")
      local env = {}
      local config = loadfile("/tmp/bin.dat", nil, env)
      if config then
        pcall(config)
      end
      return env.bin
    end

    local downloadBin = downloadBin()

    if downloadBin then
      for i = 1, #downloadBin do
        shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/SecureOS" .. downloadBin[i])
      end
      print("Package Bin up-to-date\n")
    end

  else
    print("Package Bin up-to-date\n")
  end

  print("Checking boot for updates.")
  if myversions["boot"] < onlineVersions["boot"] then
    function downloadBoot()
      shell.execute("wget -fq https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/tmp/boot.dat /tmp/boot.dat")
      local env = {}
      local config = loadfile("/tmp/boot.dat", nil, env)
      if config then
        pcall(config)
      end
      return env.boot
    end

    local downloadBoot = downloadBoot()

    if downloadBoot then
      for i = 1, #downloadBoot do
        shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/SecureOS" .. downloadBoot[i])
      end
      print("Package Boot up-to-date\n")
      if fs.exists("/tmp/.hold") then
        os.remove("/tmp/.hold")
      end
    end

  else
    print("Package Boot up-to-date\n")
  end

  print("Checking etc for updates.")
  if myversions["etc"] < onlineVersions["etc"] then
    function downloadEtc()
      shell.execute("wget -fq https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/tmp/etc.dat /tmp/etc.dat")
      local env = {}
      local config = loadfile("/tmp/etc.dat", nil, env)
      if config then
        pcall(config)
      end
      return env.etc
    end

    local downloadEtc = downloadEtc()

    if downloadEtc then
      for i = 1, #downloadEtc do
        shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/SecureOS" .. downloadEtc[i])
      end
      print("Package Etc up-to-date\n")
    end

  else
    print("Package Etc up-to-date\n")
  end

  print("Checking lib for updates.")
  if myversions["lib"] < onlineVersions["lib"] then
    function downloadLib()
      shell.execute("wget -fq https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/tmp/lib.dat /tmp/lib.dat")
      local env = {}
      local config = loadfile("/tmp/lib.dat", nil, env)
      if config then
        pcall(config)
      end
      return env.lib
    end

    local downloadLib = downloadLib()

    if downloadLib then
      for i = 1, #downloadLib do
        shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/SecureOS" .. downloadLib[i])
      end
      print("Package Lib up-to-date\n")
      if fs.exists("/tmp/.hold") then
        os.remove("/tmp/.hold")
      end
    end

  else
    print("Package Lib up-to-date\n")
  end

  print("Checking root for updates.")
  if myversions["root"] < onlineVersions["root"] then
    function downloadRoot()
      shell.execute("wget -fq https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/tmp/root.dat /tmp/root.dat")
      local env = {}
      local config = loadfile("/tmp/root.dat", nil, env)
      if config then
        pcall(config)
      end
      return env.root
    end

    local downloadRoot = downloadRoot()

    if downloadRoot then
      for i = 1, #downloadRoot do
        shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/SecureOS" .. downloadRoot[i])
      end
      print("Package Root up-to-date\n")
    end

  else
    print("Package Root up-to-date\n")
  end

  print("Checking sbin for updates.")
  if myversions["sbin"] < onlineVersions["sbin"] then
    function downloadsBin()
      shell.execute("wget -fq https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/tmp/sbin.dat /tmp/sbin.dat")
      local env = {}
      local config = loadfile("/tmp/sbin.dat", nil, env)
      if config then
        pcall(config)
      end
      return env.sbin
    end

    local downloadsBin = downloadsBin()

    if downloadsBin then
      for i = 1, #downloadsBin do
        shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/SecureOS" .. downloadsBin[i])
      end
      print("Package sBin up-to-date\n")
    end

  else
    print("Package sBin up-to-date\n")
  end

  print("Checking system for updates.")
  if myversions["system"] < onlineVersions["system"] then
    function downloadSystem()
      shell.execute("wget -fq https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/tmp/system.dat /tmp/system.dat")
      local env = {}
      local config = loadfile("/tmp/system.dat", nil, env)
      if config then
        pcall(config)
      end
      return env.system
    end

    local downloadSystem = downloadSystem()

    if downloadSystem then
      for i = 1, #downloadSystem do
        shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/SecureOS" .. downloadSystem[i])
      end
      print("Package System up-to-date\n")
      if fs.exists("/tmp/.hold") then
        os.remove("/tmp/.hold")
      end
    end

  else
    print("Package System up-to-date\n")
  end

  print("Checking usr for updates.")
  if myversions["usr"] < onlineVersions["usr"] then
    function downloadUsr()
      shell.execute("wget -fq https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/tmp/usr.dat /tmp/usr.dat")
      local env = {}
      local config = loadfile("/tmp/usr.dat", nil, env)
      if config then
        pcall(config)
      end
      return env.usr
    end

    local downloadUsr = downloadUsr()

    if downloadUsr then
      for i = 1, #downloadUsr do
        shell.execute("wget -f https://raw.githubusercontent.com/Shuudoushi/SecureOS/" .. textu .. "/SecureOS" .. downloadUsr[i])
      end
      print("Package Usr up-to-date\n")
    end

  else
    print("Package Usr up-to-date\n")
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
os.remove("/tmp/dirs.dat")
require("auth").userLog(os.getenv("USER"), "update")
term.clear()
term.setCursor(1,1)
  if not fs.exists("/tmp/.hold") and not fs.exists("/tmp/.install") then
    print("Update complete. System restarting now.")
      os.sleep(2.5)
      os.remove("/tmp/.root")
      computer.shutdown(true)
  else
    print("Update complete. Returning to shell.")
      os.remove("/tmp/.root")
      os.remove("/tmp/.hold")
      os.sleep(2.5)
      term.clear()
      term.setCursor(1,1)
  end
end

update(args, options)
