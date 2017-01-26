local fs = require("filesystem")
local shell = require("shell")

if not os.getenv("USER") then
  return
end

if not fs.exists("/home/"..os.getenv("USER")) then
  io.stderr:write("error: no such user")
  return
end

if fs.isAutorunEnabled() == true then
  if fs.exists("/home/"..os.getenv("USER").."/autorun.lua") then
    shell.execute("/home/"..os.getenv("USER").."/autorun.lua")
  elseif fs.exists("/home/"..os.getenv("USER").."/.autorun.lua") then
    shell.execute("/home/"..os.getenv("USER").."/.autorun.lua")
  elseif fs.exists("/home/"..os.getenv("USER").."/autorun") then
    shell.execute("/home/"..os.getenv("USER").."/autorun")
  elseif fs.exists("/home/"..os.getenv("USER").."/.autorun") then
    shell.execute("/home/"..os.getenv("USER").."/.autorun")
  else
    return
  end
else
  return
end
