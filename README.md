# SecureOS
Hello and thank you for looking into this little project of mine and 'official' operating system of [OpenSecurity](https://github.com/PC-Logix/OpenSecurity).

The goal of SecureOS (SOS for short) is too offer a more Unix like and secure version of the default OS - OpenOS - for [OpenComputers](http://oc.cil.li/index.php?/page/index.html) that isn't too off-putting to OpenOS users or non-Unix users.

If you find any bugs, issues, or think you can help improve SOS, then please make a new issue.

## Installing
At this time, there is three ways of installing.

1.) Installing from the floppy that ships with [OpenSecurity](https://github.com/PC-Logix/OpenSecurity), in which case you'll need the default username and password to login in and run 'install'. Running 'tmpaccount.del' after install with allow you to make a new account on the system and remove the default user 'root' all with little to no hassle or headache. Default user is 'root' default password is 'root'.

2.) Using 'wget' to download 'installer.lua' from a computer that already has OpenOS installed. Please note that in this case, there will still be programs/scripts left over from OpenOS that may cause issues, however, you will be prompted to make your own user account and not have to deal with removing the default user from the system.

3.) By running `pastebin run 20EcMQ7C` from a computer that already has OpenOS installed.

# People who've lent a hand
[gamax92](https://github.com/gamax92) - Helped out mainly with the filesystem lib

[SuPeRMiNoR2](https://github.com/SuPeRMiNoR2) - Made the auth lib, ported the sha256 lib, and helped out with the multi-user system

[Caitlyn](https://github.com/CaitlynMainer) - Made SOS the 'official' OS of [OpenSecurity](https://github.com/PC-Logix/OpenSecurity) and helped out with making the multi-user system

[fnuecke](https://github.com/fnuecke) (and co) - Provided a great starting point with OpenOS

[mpmxyz](https://github.com/mpmxyz) - Provided 'libarmor.lua'

[Gopher](https://github.com/OpenPrograms/Gopher-Programs/tree/master/gml) - Using his 'gml' GUI libs (check out his wiki page for GML to use it)

All the people of #oc on Espernet IRC

# [LICENSE](https://github.com/MightyPirates/OpenComputers/blob/master-MC1.7.10/LICENSE)
Standard MIT license from [OpenComputers](http://oc.cil.li/index.php?/page/index.html).
