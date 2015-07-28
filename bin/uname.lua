local args, options = local name = require("shell").parse(...)

if options.a then
  io.write(_OSVERSION .. " " .. _VERSION)
else
  io.write(_OSVERSION)
end
