local sha = require("sha256")

local auth = {}
local users = {}

local function split(str,sep)
    local array = {}
    local reg = string.format("([^%s]+)",sep)
    for mem in string.gmatch(str,reg) do
        table.insert(array, mem)
    end
    return array
end

local function buildDB()
    users = {}
    u = io.open("/.userName.dat", "r")
    raw = u:read(1000)
    
    temp = split(raw, "\n")
    
    for _,data in pairs(temp) do
      t = split(data, ":")
      users[t[1]] = t[2]
    end
    return users  
end

function auth.validate(userName, passWord)
  users = buildDB()
  
  validated = false
  
  for userName,passWord in pairs(users) do
    if userName == username and passWord == sha.sha256(passWord) then
      validated = true
    end
  end
  return validated
end

return auth