local args, options = require("shell").parse(...)

local function myversions()
  local env = {}
  local config = loadfile("/.version", nil, env)
  if config then
    pcall(config)
  end
  return env.myversions
end

local myversions = myversions()

if options.a then
  io.write(_OSVERSION .. " " .. _VERSION)
  for k,v in pairs(myversions) do
    print(k .. " = " .. v)
  end
else
  io.write(_OSVERSION)
end
