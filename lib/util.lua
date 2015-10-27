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

return util
