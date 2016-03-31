local keyboard = require("keyboard")
local computer = require("computer")
local fs = require("filesystem")
local event = require("event")
local auth = require("auth")
local term = require("term")

local running = true

local function check() -- Prevents "ctrl+alt+c" and "ctrl+c".
 if keyboard.isControlDown() then
  io.stderr:write("( ͡° ͜ʖ ͡°)")
  os.sleep(0.1)
  computer.shutdown(true)
 end
end
event.listen("key_down", check)

while running do
  if not fs.get("/").isReadOnly() then
    if fs.exists("/installer.lua") then -- Auto deletes the installer at first boot.
      fs.remove("/installer.lua")
    end
  end

  os.setenv("HOME", nil)
  os.setenv("USER", nil)
  os.setenv("PATH", nil)

  term.clear()
  term.setCursor(1,1)
  print(_OSVERSION .. " " .. os.date("%F %X"))
  term.write("User: ")
  username = string.lower(io.read())
  term.setCursor(1,3)
  term.setCursorBlink(false)
  term.write("Password: ")
  password = string.gsub(term.read({pwchar=""}), "\n", "")
  term.setCursorBlink(true)

  login = auth.validate(username, password)

  if login then
    os.setenv("USER", username)
    os.setenv("PATH", "/bin:/sbin:/usr/bin:/home/".. username .."/bin:/root:.")
    local tmpdir = os.getenv("TMPDIR")
    if tmpdir and not fs.get(tmpdir).isReadOnly() then
      hn = io.open(tmpdir .. "/.hostname.dat", "w") -- Writes the user inputted username to file for future use.
      hn:write(username)
      hn:close()
    end
    auth.userLog(username, "login_pass")

    term.clear()
    term.setCursor(1,1)
    print("Welcome, " ..username)
    os.sleep(1.5)
    term.clear()
    term.setCursor(1,1)

    local file = io.open("/etc/hostname")

    if file then
      os.setenv("PS1", username .. "@" .. file:read("*l") .. "# ")
      file:close()
    else
      os.setenv("PS1", username .. "@" .. username .. "# ")
    end

    username, password = "" -- This is just a "bandaid fix" till I find a better way of doing it.
    event.ignore("key_down", check)
    running = false
    require("shell").getShell()()
  else
    auth.userLog(username, "login_fail")
    term.clear()
    term.setCursor(1,1)
    io.stderr:write("Login failed: Invalid information.")
    os.sleep(2.5)
  end
end
