# SecureOS
Hello and thank you for looking into this little project of mine and 'official' operating system of [OpenSecurity](https://github.com/PC-Logix/OpenSecurity).

The goal of SecureOS (SOS for short) is to offer a more Unix like and secure version of the default OS - OpenOS - for [OpenComputers](http://oc.cil.li/index.php?/page/index.html) that isn't too off-putting to OpenOS users or non-Unix users.

If you find any bugs, issues, or think you can help improve SOS, then please make a new issue.

## System Requirements
SecureOS is tested, in game, on a "maxed out" T3 server. However, it can run on the following specs:

#### Minimum:
* T3 Case (T2 if using APU.)
* T1 CPU or T2 APU (Set to Lua 5.2)
* T2 Graphics Card (Not required if using an APU.)
* x2 T2 RAM
* x1 T1 HDD
* T2 Screen
* x1 Internet Card (For updating SecureOS.)

#### Recommended:
* T3 Server
* T3 CPU (Set to Lua 5.3)
* T3 Graphics Card
* x4 T3.5 RAM
* x1 T3 HDD
* T3 Screen
* x1 Internet Card (For updating SecureOS.)
* x1 T3 Data Card

## Installing
At this time, there are three ways of installing.

1.) Installing from the floppy that ships with [OpenSecurity](https://github.com/PC-Logix/OpenSecurity), in which case you'll need the default username and password to login in and run 'install'. Running 'tmpaccountdel.lua' after install with allow you to make a new account on the system and remove the default user 'root' all with little to no hassle or headache. Default user is `root` default password is `root`.

2.) Using `wget` to download `installer.lua` from a computer that already has OpenOS installed. Please note that in this case, there will still be programs/scripts left over from OpenOS that may cause issues, however, you will be prompted to make your own user account and not have to deal with removing the default user from the system.

3.) By running `pastebin run 20EcMQ7C` from a computer that already has OpenOS installed.

# People who've lent a hand
[gamax92](https://github.com/gamax92) - Helped out mainly with the filesystem lib

[SuPeRMiNoR2](https://github.com/SuPeRMiNoR2) - Made the auth lib, ported the sha256 lib, and helped out with the multi-user system

[Caitlyn](https://github.com/CaitlynMainer) - Made SOS the 'official' OS of [OpenSecurity](https://github.com/PC-Logix/OpenSecurity) and helped out with making the multi-user system

[fnuecke](https://github.com/fnuecke) (and co) - Provided a great starting point with OpenOS

[mpmxyz](https://github.com/mpmxyz) - Provided 'libarmor.lua'

[Gopher](https://github.com/OpenPrograms/Gopher-Programs/tree/master/gml) - Using his 'gml' GUI libs (check out his wiki page for GML to use it)

[Sora](https://github.com/RobertCochran) - Supplied a much cleaner util.readableNumber

[SpiritedDusty](https://github.com/SpiritedDusty) - Added things like `cd ~` taking a user to their home dir

[Kodos](https://github.com/MyNameIsKodos) - Supplied ideas and helped with getting GitHub to stop being a git

[payonel](https://github.com/payonel) - Helped with fixing SOS after merging changes to OpenOS into SOS.

All the people of [#oc on Espernet IRC](http://webchat.esper.net/?channels=#oc)

# [LICENSE](https://github.com/MightyPirates/OpenComputers/blob/master-MC1.7.10/LICENSE)
Standard MIT license from [OpenComputers](http://oc.cil.li/index.php?/page/index.html).
