# Changelog

## Version 2.5.3 – 03/08/17

* Fixes for new firmware versions

## Version 2.5.2 – 18/01/17

* Fixed second dismiss of info view

## Version 2.5.1 – 14/10/16

* Fixed crash on info view

## Version 2.5.0 – 09/09/16

* Upgraded example project to Xcode 8
* The framework is still built with Xcode 7 for now, so is still compatible down to iOS 6. This may change to iOS 8 in a future release.
* Fixed AirTurnViewManager not disabling fully

## Version 2.4.3 – 13/01/15

* Fixed strip framework script example for product names containing spaces

## Version 2.4.2 – 15/12/15

* Fixed crash in AirTurnUI

## Version 2.4.1 – 01/12/15

* Changed the info view to be optional

## Version 2.4.0 – 25/11/15

* No changes from b2

## Version 2.4.0b2 – 18/11/15

* Added Swift example project
* Improved swift support – Added nullability notation and lightweight generics to collection types in framework headers
* Fix for dynamic framework script
* Fix for manual init method in `AirTurnUIConnectionController`
* Fix for AirTurn state restoration in `AirTurnUIConnectionController`

## Version 2.4.0b1 – 21/10/15

* Added extra configuration options for new PED firmware 1.1.0
* Removed iOS 9 keyboard management disable option

## Version 2.3.4 – 11/11/15

* Fixed warnings
* Removed debug symbols – smaller download
* Fixes to AirTurnUIConnectionController

## Version 2.3.3 – 09/11/15

* Fixed keyboard dismiss bar not visible in some circumstances

## Version 2.3.2 – 21/10/15

* Fixed keyboard management bug
* Updated Dependencies
* Fixed iOS 6 regression
* Fixed some warnings

## Version 2.3.1 – 13/10/15

* Fixed project problems
* Fixed two bugs in AirTurnUI related to initialisation in HID mode
* Improved docs

## Version 2.3.0 – 01/10/15

* Added dynamic framework
* Added bitcode

## Version 2.2.0 – 12/09/15

* Dependency updates
* Removed CocoaLumberjack from the compiled static library, uses it only if available
* Modified AirTurnLogging class

## Version 2.2.0.b5 – 24/08/15

* iOS 9 fixes
* Removed copy/paste bar when automatic keyboard management has not been enabled
* Added a keyboard frame including the dismiss bar property
* iPhone example app fix
* External keyboard status fix

## Version 2.2.0.b4 – 02/07/15

* iOS 9 beta 2 fixes

## Version 2.2.0.b3 – 02/07/15

* iOS 5 and 6 fixes

## Version 2.2.0.b2 – 02/07/15

* Minor fixes

## Version 2.2.0.b1 – 23/06/15

* Support for iOS 9
* Improved logging – can now release with beta framework builds
* Added a keyboard dismiss bar to dismiss the keyboard when it is managed by the AirTurn framework

## Version 2.1.0 – 21/06/15

* Support for multiple PEDs
* Automatic keyboard management

This build contains no changes from 2.1.0b7.

## Version 2.1.0b7 – 14/06/15

* Fixed keyboard management issues
* Fixed erroneous HID event when AirTurn View was resigned as first responder

## Version 2.1.0b6 – 08/06/15

* Improved HID documentation
* Fixed: AirTurnUI did not automatically start keyboard management at App start
* Fixed: `AirTurnStateMonitor` virtual keyboard state assessment would leave virtual keyboard partially hidden
* Fixed: Keyboard was hidden in certain cases, added a timer to ensure keyboard is visible when it should be

## Version 2.1.0b5 – 20/05/15

* Fixed: Pedal press event was sent twice when key repeat was disabled
* Fixed: Automatic keyboard management state reassessments did not work properly on iOS 7
* Fixed: Virtual keyboard restoration on leaving and entering the App
* Improved: Enabled warnings 'suspicious implicit conversions' and 'hidden local variables' and fixed problems

## Version 2.1.0b4 – 14/05/15

* Removed `preventStateRestoration`, replaced with `AirTurnUIRestoreState` info.plist key
* Fixed: automatic keyboard management would not be disabled when connecting to a PED
* Fixed: AirTurn keyboard notifications would not be sent if automatic keyboard management was not available

## Version 2.1.0b3 – 03/05/15

* Added automatic keyboard management UI toggle
* Improved documentation

## Version 2.1.0b2 – 30/04/15

* Added automatic keyboard management – see [HID Support notes](HID-docs.html#automatic)
* Added support for multiple PEDs – see [Supporting Multiple PEDs](../../index.html#multi-peds)

## Version 2.0.10 – 11/03/15

* Fixed Key Repeat Enabled toggle

## Version 2.0.9 – 02/03/15

* Fixed iOS 6 issue in AirTurnUI
* Fix for AirTurnUI on devices that do not support BLE
* Moved Done button code into ViewController class

## Version 2.0.8 – 24/02/15

* Moved Done button code out of AirTurnUI into ViewController.m

## Version 2.0.7 — 09/02/15

* Bug fixes related to pairing, Bluetooth status, adding a device

## Version 2.0.6 — 30/01/15

* Fixed a number of bugs and updated dependencies

## Version 2.0.5 — 30/09/14

* Fixed bug where an AirTurn event would be sent on App resume in HID mode

## Version 2.0.4 — 28/09/14

* Fixes for iOS 5

## Version 2.0.3 — 22/09/14

* Fixed issue where a forgotten PED would still connect on next App start

## Version 2.0.2 — 18/09/14

* iOS 5 support

## Version 2.0.1 — 18/09/14

* Fixed framework linking to iOS 8 Metal framework, framework can now be used in iOS 5
* Fixed issue when using framework in iOS 7 or lower base SDK project

## Version 2.0.0 — 08/08/14

While 2.0 does not contain substantial changes to the existing HID framework (aside from renaming `AirTurnInterface` to `AirTurnViewManager`), there are major improvements and additions

* AirTurn PED support added, adding a new section of the framework
* Major documentation and commenting overhaul — all existing developers are recommended to read
* Example project re-write using a modern iOS project structure
* An open source user interface provided for managing AirTurn devices
* Removal of virtual keyboard management and associated workaround support classes
* Now supports only iOS 6+
* Removed armv6 binary

## Version 1.5 — 02/01/13

* Bumped version.  No other changes (just more dev testing).

## Version 1.5b4 — 22/12/13

* Fixed: workaround for UIKit crashes on iOS 6 and 7
* Fixed: Keyboard issues when displaying modal views with UIModalPresentationFormSheet

## Version 1.5b3 — 12/11/13

* Fixed keyboard displaying briefly when disabling AirTurnInterface
* __Known issue__ — crash when performing the following:
	* Enable ATI
	* Press up arrow key / AirTurn Port 1
	* Click in text field
	* Press down arrow key / AirTurn Port 3
	* This issue seems to have been present in previous AirTurn Interface releases
	* We believe this is an issue with UIKit and are awaiting a response from Apple

## Version 1.5b2 — 14/09/13

* Improved some wording in documentation
* Improved iOS 7 support in example App
* Added 64-bit binary to framework, made example App 64-bit
* Framework now ensures the keyboard is not hidden when the App enters the background, meaning the keyboard will work normally outside the App
When searching for an active first responder, the interface now ignores views which do not conform to the `UIKeyInput` protocol
* Exposed keyboardWindowHidden property on AirTurnKeyboardManager.  When force hiding the keyboard, this is the property that is set to YES.
* Added restoreNormalKeyboardFunctionality to AirTurnKeyboardManager, which internally just sets keyboardWindowHidden to NO.

## Version 1.5b1 — 18/08/13

* `AirTurnViewDelegate` protocol — removed previously deprecated
* `AirTurnViewWillRemoveFromViewHeirarchy` and `AirTurnViewDidRemoveFromViewHeirarchy` methods (misspellings, use `AirTurnViewWillRemoveFromViewHierarchy` and `AirTurnViewDidRemoveFromViewHierarchy` instead).
* Added notifications, triggered when the virtual keyboard is force shown/hidden:
	* `AirTurnVirtualKeyboardWillShowNotification`, `AirTurnVirtualKeyboardDidShowNotification`, `AirTurnVirtualKeyboardWillHideNotification`, `AirTurnVirtualKeyboardDidHideNotification`
* Added NBTableViewController drop-in replacement class to example project to handle tableView insets.  Example usage inside the modal view.

## Version 1.4 — 03/04/13
* Switched to new universal framework build process, based on https://github.com/jverkoey/iOS-Framework creating a fat binary with armv6 armv7 armv7s and i386
* Fixed a memory leak
* Searches all windows for first responder
* Added note on UITableView indexes in documentation
* `AirTurnInterface` and `AirTurnView` classes — removed previously deprecated
`removeFromViewHeirarchy` method (misspelling, use `removeFromViewHierarchy` instead)
* `AirturnInterface class` — removed previously deprecated property `displayKeyboardOnResignFirstResponder`, use `displayKeyboardWhenNotFirstResponder` instead
* `AirTurnViewDelegate` protocol — deprecated `AirTurnViewWillRemoveFromViewHeirarchy` and `AirTurnViewDidRemoveFromViewHeirarchy` methods (misspellings, use `AirTurnViewWillRemoveFromViewHierarchy` and `AirTurnViewDidRemoveFromViewHierarchy` instead).  Will be removed in the next version.

## Version 1.3 — 22/09/12
* Added support for iPhone 5 in example App (launch image)
* Added armv7s binary for iPhone 5 support
* Supports new AirTurn firmware, adding two new ports
* Drops support for PC mode in older AirTurn Firmware
* Fixes a crash with AirPlay Mirroring

## Version 1.2 — 11/04/12
* Restructured framework to expose `AirTurnView`.  You can now implement keyboard handling independently if you wish.
* Added `firstResponderPollingInterval` property
`displayKeyboardOnResignFirstResponder` property has been replaced with `displayKeyboardWhenNotFirstResponder`
`removeFromViewHeirarchy` has been replaced with `removeFromViewHierarchy` (typo!)
* The interface now does not `becomeFirstResponder` when enabled if there is already a first responder.  If `firstResponderPolling` is enabled, it polls instead
* The interface will now display the keyboard when enabled if a first responder exists
Modal views can be displayed normally, without using the `UIViewController` category or manually disabling the interface

## Version 1.1 — 07/03/12
* Improved documentation
* Fixed info view display bug on iPhone or iPod Touch
* Fixed a crash when the key window had no subviews
* Fixed a problem where the interface could get stuck in a polling loop

## Version 1.0 — 27/02/12
* Initial release.