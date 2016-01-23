local string = require("string")
local auth = require("auth")
local term = require("term")

local root = io.open("/tmp/.root", "w")
 root:write("true")
  root:close()

local hn = io.open("/tmp/.hostname.dat", "r")
 texthn = hn:read()
  hn:close()

local _, super = auth.validate(texthn, "*****")

term.clear()
term.setCursor(1,1)
term.write("Changing password for ".. texthn ..". \n")
term.write("Current password: ")
passwordOld = string.gsub(term.read(nil, nil, nil, ""), "\n", "")
term.setCursor(1,3)
term.write("New password: ")
passwordNew1 = string.gsub(term.read(nil, nil, nil, ""), "\n", "")
term.setCursor(1,4)
term.write("Retype new password: ")
passwordNew2 = string.gsub(term.read(nil, nil, nil, ""), "\n", "")
term.setCursor(1,5)

  if super == true then
    su = true
  else
    su = false
  end

if auth.validate(texthn, passwordOld) == true and passwordNew1 == passwordNew2 then
  auth.addUser(texthn, passwordNew2, su)
  term.write("passwd: password updated successfully \n")
  auth.userLog(username, "pw_change")
  os.remove("/tmp/.root")
  return
else
  term.write("passwd: password not successfully updated \n")
  os.remove("/tmp/.root")
  return
end
