local internet = require("internet")

local util = {}

function util.readableNumber(num, places)
    local ret
    local placeValue = ("%%.%df"):format(places or 0)
    if not num then
        return 0
    elseif num >= 1000000000000 then
        ret = placeValue:format(num / 1000000000000) .. " T" -- trillion
    elseif num >= 1000000000 then
        ret = placeValue:format(num / 1000000000) .. " B" -- billion
    elseif num >= 1000000 then
        ret = placeValue:format(num / 1000000) .. " M" -- million
    elseif num >= 1000 then
        ret = placeValue:format(num / 1000) .. "k" -- thousand
    else
        ret = num -- hundreds
    end
    return ret
end

function util.round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function util.time()
local timestamp = ""
for data in internet.request("http://www.timeapi.org/utc/now?\\s") do
timestamp = timestamp .. data
end
return tonumber(timestamp)
end

function util.date(format, tz)
tz = tz or "utc"
local timeformat = ""
for data in internet.request("http://www.timeapi.org/" .. tz .. "/now?" .. format:gsub(".", function(a) return "%" .. string.format("%02X",a:byte()) end)) do
timeformat = timeformat .. data
end
return timeformat
end

function util.formatSize(size)
  local sizes = {"", "K", "M", "G"}
  local unit = 1
  local power = 1024
  while size > power and unit < #sizes do
    unit = unit + 1
    size = size / power
  end
  return math.floor(size * 10) / 10 .. sizes[unit]
end

return util
