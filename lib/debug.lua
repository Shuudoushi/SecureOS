local string = require("string")

local debug = {}

function debug.benchmark(amt) -- Not a clue what it could really be used for, but here it is.
  local x = os.clock()
  local s = 0
  for i=1,(amt or 100000) do
    s = s + i
  end
    return string.format("elapsed time: %.2f", os.clock() - x)
end

return debug
