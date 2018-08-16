# ios-command-line-tool

<!-- Brandon Azad -->

This project shows how to compile a command line tool for iOS using Xcode. Xcode offers a template
called "Command Line Tool" for macOS, but that template is not available for iOS. Nonetheless,
Xcode can be persuaded to build standalone Mach-O executables for iOS as well.

This technique has been tested with Xcode 9.3 and iOS 11.1.2.

## Build on Your System

Building the tool on your system requires updating signing information and deployment info. You
can do that from Xcode or from the command line.

In order to build on your system you need a developer account. You find out if you have one by
running the `security find-identity` command below on macOS. If you get an output similar to the
one below, you have a developer account:

```
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "iPhone Developer: AAAAAAA (BBBBBBBBBB)"
```

If you don't have a developer account you need to create one. See the instructions
[here](https://stackoverflow.com/questions/39524148/requires-a-development-team-select-a-development-team-in-the-project-editor-cod).

### Building on Xcode

Open the `ios-command-line-tool.xcodeproj` folder in Xcode (by using `File -> Open` in Xcode),
click on the `ios-command-line-tool` top icon in the project navigator (left side), then go to
the `General` tab (in the middle view). In the `Signing` section choose your `Team`. Once you
do that, other issues will disappear.

You may need to enable the `Project Navigator` view in Xcode. You do that by using `View ->
Navigators -> Show Project Navigator`.

If you want to build for an earlier version of iOS, go to the `Deployment Info` section in the
middle view and choose the `Deployment Target` of your choice.

You can now build the executable in Xcode (`Product -> Build`). The executable file will by
default be located in
`~/Library/Developer/Xcode/DerivedData/ios-command-line-tool-XXXXXXXXXXXX/Build/Products/Debug-iphoneos/ios-command-line-tool`
(see more on that [here](https://pewpewthespells.com/blog/xcode_build_locations.html)). For
example:

```
$ file ~/Library/Developer/Xcode/DerivedData/ios-command-line-tool-ffawlhgezawmrmfewovgtsimimkd/Build/Products/Debug-iphoneos/ios-command-line-tool
/Users/razvan/Library/Developer/Xcode/DerivedData/ios-command-line-tool-ffawlhgezawmrmfewovgtsimimkd/Build/Products/Debug-iphoneos/ios-command-line-tool: Mach-O 64-bit arm64 executable, flags:<NOUNDEFS|DYLDLINK|TWOLEVEL|PIE>
```

### Building on the Command Line

You can bypass using Xcode IDE altogether and resort to using the command line. You use the
`Makefile` and the `make` command.

Similar to the Xcode configuration, you first need to choose your development team. Create a
`vars.mk` file by copying `vars.mk.sample`:

```
cp vars.mk.sample vars.mk
```

Now update the `DEV_TEAM` and the `IOS_TARGET` variables to proper values. You can find out
existing development teams by running the one liner below, as shown
[here](https://answers.unity.com/questions/1248794/ios-build-error-devleopment-team.html).

```
security find-identity -v -p codesigning | awk -F \" '{if ($2) print $2}' | while read acct ; do security find-certificate -a -c "$acct" -p | openssl x509 -text | grep "^ *Subject:" | awk -v acct="$acct" -F , '{if ($3) {sub(/ *OU=/,"",$3);print $3","acct}}' ; done
```

In the `vars.mk` file update the `DEV_TEAM` with one of the team IDs from output lines above
and the `IOS_TARGET` with the iOS version you want to use.

Now use `make` build the executable. The executable will be located in
`build/Release-iphoneos/ios-command-line-tool`:

```
$ file build/Release-iphoneos/ios-command-line-tool
build/Release-iphoneos/ios-command-line-tool: Mach-O 64-bit arm64 executable, flags:<NOUNDEFS|DYLDLINK|TWOLEVEL|PIE>
```

You can use `make clean` to clean the project.

## License

The ios-command-line-tool template is released into the public domain.
