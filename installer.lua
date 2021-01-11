local computer = require("computer")
local fs = require("filesystem")
local kb = require("keyboard")
local event = require("event")
local shell = require("shell")
local term = require("term")

local running = true

local function greeting()
term.clear()
term.setCursor(1,1)
  print("Welcome to the SecureOS installer!")
  print("This installer will help guide you through setting up and installing SecureOS.")
  print("Press any key to continue.")
local event = event.pull("key_down")
  if event and not kb.isControlDown() then
    term.clear()
    term.setCursor(1,1)
  end
end

local function downLoad()

  if not fs.exists("/tmp/.root") then
    r = io.open("/tmp/.root", "w")
     r:write("true")
      r:close()
  end

  if not fs.exists("/tmp/.install") then
    n = io.open("/tmp/.install", "w")
      n:write(os.date())
        n:close()
  end

  if not fs.exists("/sbin") then
    fs.makeDirectory("/sbin")
  end

  if not fs.exists("/etc/update.cfg") then
    c = io.open("/etc/update.cfg", "w")
     c:write("release")
      c:close()
  end

  term.write("Please wait while the files are downloaded and installed.")
  os.sleep(1)
  term.setCursor(1,2)

shell.execute("wget -q https://raw.githubusercontent.com/Shuudoushi/SecureOS/release/SecureOS/sbin/update.lua /sbin/update.lua \n")
shell.execute("/sbin/update.lua")
end

local function userInfo()
  term.clear()
  term.setCursor(1,1)
  term.write("Please enter a username and password.")
  term.setCursor(1,2)
  term.write("Username: ")
    username = string.lower(io.read())
  term.setCursor(1,3)
  term.write("Password: ")
    password = string.gsub(term.read({pwchar=""}), "\n", "")

  require("auth").addUser(username, password, true)

  if not fs.exists("/home/" .. username .. "/") then
    fs.makeDirectory("/home/" .. username .. "/")
    fs.makeDirectory("/home/" .. username .. "/bin/")
    fs.makeDirectory("/home/" .. username .. "/lib/")
    fs.makeDirectory("/home/" .. username .. "/var/")
  end

  term.clear()
  term.setCursor(1,1)
  term.write("Would you like to restart now? [Y/n]")
  term.setCursor(1,2)
    input = string.lower(io.read())

    if input == "y" or input == "yes" then
      computer.shutdown(true)
    elseif input == "n" or input == "no" then
      io.write("Returning to shell.")
      os.sleep(1.5)
      term.clear()
      term.setCursor(1,1)
      running = false
    end
end

while running do
  local v = io.open("/.version", "w")
    v:write("myversions = { bin = '0', boot = '0', etc = '0', lib = '0', root = '0', sbin = '0', system = '0', usr = '0' }")
      v:close()
    greeting()
    downLoad()
    userInfo()
end
