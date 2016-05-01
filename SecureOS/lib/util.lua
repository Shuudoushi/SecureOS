local internet = require("internet")
local fs = require("filesystem")

local util = {}

local prefixes = {
        [0] = "",
        [1] = "K",
        [2] = "M",
        [3] = "G",
        [4] = "T",
        [5] = "P",
}

local function round(n)
        return string.format("%.1f", n)
end

function util.readableNumber(n)
        local n = tonumber(n)

        if not n then error("Not a number", 2) end
        -- Get the log
        local l = ((n == 0) and 0) or math.floor(math.log(n, 1000))
        return round(n / math.pow(1000, l))..prefixes[l]
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
  local sizes = {"", "Kb", "Mb", "Gb", "Tb"}
  local unit = 1
  local power = 1024
  while size > power and unit < #sizes do
    unit = unit + 1
    size = size / power
  end
  return math.floor(size * 10) / 10 .. sizes[unit]
end

function utli.realTime(format)
  if not format then format = "%F %X" end
  local x = io.open("/tmp/.time", "w")
  x:write("a")
  x:close()
  return os.date(format, fs.lastModified("/tmp/.time") / 1000)
end

return util
