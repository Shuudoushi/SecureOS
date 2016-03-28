-- Fixed with the help of DrHoffman from IRC.

local shell = require("shell")
local auth = require("auth")
local term = require("term")

local hn = io.open("/tmp/.hostname.dat", "r") -- Reads the hostname file.
  texthn = hn:read()
    hn:close()

local history = history or {}
table.insert(history, "")
local historyIndex = #history

local function getHistoryIndex()
  return historyIndex
end

local function setHistoryIndex(newIndex)
  historyIndex = newIndex
end

local args = {...}

if #args ~= 0 then
  path = args[1]
else
  return 1 -- Too lazy to properly do this bit atm...
end

if args[1] == "!!" then
  local index = getHistoryIndex()
  os.execute("/root/sudo.lua " .. setHistoryIndex(index - 1))
end

term.setCursorBlink(false)
term.write("[sudo] password for ".. texthn ..": ")
local password = string.gsub(term.read({pwchar=""}), "\n", "")
term.setCursorBlink(true)

if password == nil then return 1 end

local login, super = auth.validate(texthn, password)

if login and super then
  auth.userLog(texthn, "root_pass")
  local r = io.open("/tmp/.root", "w")
    r:write("true")
      r:close()
  os.sleep(0.1)
  local result, reason = shell.execute(path, nil, table.unpack(args,2))
  if not result then
    io.stderr:write(reason)
  end
  os.sleep(0.1)
  if args[1] == "su" then
    if os.getenv("HOSTNAME") == nil then -- Sets the user environment.
      os.setenv("PS1", "root@" .. texthn .. "$ ")
    else
      os.setenv("PS1", "root@" .. os.getenv("HOSTNAME") .. "$ ")
    end
    shell.setWorkingDirectory("/root")
    os.setenv("HOME", "/root")
    os.setenv("USER", "root")
    return
  else
    os.remove("/tmp/.root")
  end
else
  auth.userLog(texthn, "root_fail")
  io.write("Sorry, try again. \n")
end
