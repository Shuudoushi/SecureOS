local keyboard = require("keyboard")
local computer = require("computer")
local process = require("process")
local event = require("event")
local shell = require("shell")
local term = require("term")
local io = require("io")

u = io.open("/username.dat", "r") -- Reads the username file.
 textu = u:read()
  u:close()

p = io.open("/password.dat", "r") -- Reads the password file.
 textp = p:read()
  p:close()

function check()

 if keyboard.isControlDown() and keyboard.isAltDown() then -- Prevents "ctrl+alt+c".
  computer.shutdown(true)
 end
end
event.listen("key_down", check)

while true do
  term.clear()
  term.setCursor(1,1)
  term.write("User: ")
  username = term.read()
  username = string.gsub(username, "\n", "")
  term.setCursor(1,2)
  term.write("Password: ")
  password = term.read(nil, nil, nil, "")
  password = string.gsub(password, "\n", "")
  if username == textu and password == textp then -- Checks to see if the input from the user matches that which is on file.
    hn = io.open("/tmp/.hostname.dat", "w") -- Writes the user inputted username to file for future use.
     hn:write(username)
      hn:close()
    term.clear()
    term.setCursor(1,1)
    print("Welcome, " ..textu)
    os.sleep(1.5)
    term.clear()
    term.setCursor(1,1)
    shell.setAlias("usage", "/bin/usage.lua")
    shell.setAlias("logout", "/bin/logout.lua")
    os.setenv("PS1", textu .. "@" .. textu .. "# ") -- Sets the user environment.
    shell.setWorkingDirectory("/usr/home/" .. textu .. "/")
    shell.execute("/bin/.root.lua/") -- Starts the root check program.
    break
  else
    term.clear()
    term.setCursor(1,1)
    term.write("Password incorrect...")
    os.sleep(2.5)
  end
end
