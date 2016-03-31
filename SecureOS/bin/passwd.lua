local string = require("string")
local auth = require("auth")
local term = require("term")

local user = os.getenv("USER")
local _, super = auth.validate(user, "*****")

term.clear()
term.setCursor(1,1)
term.write("Changing password for ".. user ..". \n")
term.write("Current password: ")
passwordOld = string.gsub(term.read({pwchar=""}), "\n", "")
term.setCursor(1,3)
term.write("New password: ")
passwordNew1 = string.gsub(term.read({pwchar=""}), "\n", "")
term.setCursor(1,4)
term.write("Retype new password: ")
passwordNew2 = string.gsub(term.read({pwchar=""}), "\n", "")
term.setCursor(1,5)

  if super == true then
    su = true
  else
    su = false
  end

if auth.validate(user, passwordOld) == true and passwordNew1 == passwordNew2 then
  auth.addUser(user, passwordNew2, su)
  term.write("passwd: password updated successfully \n")
  auth.userLog(user, "pw_change")
  return
else
  term.write("passwd: password not successfully updated \n")
  return
end
