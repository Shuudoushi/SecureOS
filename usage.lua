local computer = require("computer")
local component = require("component")
local colors = require("colors")

function round(num, idp)
 local mult = 10^(idp or 0)
 return math.floor(num * mult + 0.5) / mult
end

local usedMemory = round(computer.totalMemory() / 1048576 - computer.freeMemory() / 1048576, 2)
local freeMem = round(computer.freeMemory() / 1048576, 2)

print("Date/Time: " .. os.date())
print("Up Time: " .. round(computer.uptime() / 60, 2) .. " Minutes")
print("Total Memory: " .. round(computer.totalMemory() / 1048576, 2) .. " MB")

if freeMem * 100 <= 15 then
 component.gpu.setForeground(0xFF0000)
  print("Free Memory: " .. round(freeMem, 2) .. " MB")
 component.gpu.setForeground(0xFFFFFF)
 else
  print("Free Memory: " .. round(freeMem, 2) .. " MB")
end

if usedMemory >= 85 then
 component.gpu.setForeground(0xFF0000)
  print("Used Memory: " .. round(usedMemory, 2) * 100 .. "%")
 component.gpu.setForeground(0xFFFFFF)
 else
  print("Used Memory: " .. round(usedMemory, 2) * 100 .. "%")

end
