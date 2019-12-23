# HID support documentation

To implement the HID part of the framework properly, it is essential to have a basic understanding of how it works and why it is required.

The AirTurn BT-105 acts as a Bluetooth keyboard. In iPad mode it emulates the arrow keys, which correspond to the four ports on the device. This framework supports all modes of the BT-105.

UIKit, the frameworks provided by Apple for developing iOS applications, do not provide direct notification of keyboard key events. This is an issue when developing software which needs to use those key events. Neither do they provide any information as to whether an external keyboard is connected, or give the developer any control over the display of the virtual keyboard. This leads to two main problems:

* The developer cannot easily detect the AirTurn key inputs
* The developer cannot easily show the virtual keyboard when the AirTurn ‘Bluetooth keyboard’ is connected

The HID part of the framework is divided into four parts, `AirTurnView` and `AirTurnViewManager` handle the first problem, `AirTurnKeyboardManager` and `AirTurnKeyboardStateMonitor` the second.

At the core of HID support is `AirTurnView`, which is a hidden text field that responds to instructions from iOS and figures out which key was pressed to generate those instructions.  Most developers will only interact with `AirTurnViewManager` which controls when `AirTurnView` is active (first responder). `AirTurnView` can be used independently of the rest of the framework just to process key events. As `AirTurnView` is a hidden text field that is always active, there are some implications for developers which are discussed later in this document.

`AirTurnKeyboardManager` controls the display of the virtual keyboard in a way that Apple will approve in App submissions. `AirTurnKeyboardStateMonitor` observes the state of first responders and the virtual keyboard to determine when an external keyboard is connected and when the virtual keyboard should be shown.

The `AirTurnView` must be the first responder to operate; there can only be one first responder at any time.  When the user taps a text field to enter text, the field becomes the first responder, resigning the `AirTurnView` as first responder.  When this happens, `AirTurnStateMonitor` will observe this and send out a `AirTurnKeyboardStateMonitorFirstResponderChangedNotification` notification. The same will happen when the text field is resigned as first responder, but as there is no other first responder then the `AirTurnView` is made first responder again.

## <a name="automatic"></a>Automatic keyboard management

Automatic keyboard management is disabled by default as it can cause problems depending on what UI elements you are using in your App. To enable it, add the `AirTurnAutomaticKeyboardManagement` key to your App's `info.plist` and set the value to boolean `YES`. If you are **not** using AirTurnUI, you will also need to enable automatic keyboard management when you are using AirTurn support:

```
[AirTurnKeyboardManager sharedManager].automaticKeyboardManagementEnabled = true;
```

UIKit is built to adapt itself to the presence of a virtual keyboard on the screen, but AirTurn automatic keyboard management interferes with that. For example, a popup shrinks when the keyboard is displayed so its content is not covered by the keyboard, however it may not do the same when the keyboard has been forced on screen by automatic keyboard management. This is also the case with table view indexes.

To workaround these problems two classes have been provided: `NBPopoverController` and `NBTableViewController`. Both these classes are designed to be drop in replacements for the respective UI-prefixed classes.

In addition, you will need to use the AirTurn virtual keyboard notifications to adjust your UI to avoid the virtual keyboard. These notifications are `AirTurnVirtualKeyboardWillShowNotification`, `AirTurnVirtualKeyboardDidShowNotification`, `AirTurnVirtualKeyboardWillHideNotification`, `AirTurnVirtualKeyboardDidHideNotification`, which have the same `userInfo` keys as the equivalent `UIKeyboard` notifications. These notifications are sent even if automatic keyboard management is not enabled, in which case they just proxy the `UIKeyboard` events.

If automatic keyboard management causes other problems with your user interface, please contact AirTurn support.

## Caveats of HID support in AirTurn Interface

### Form sheet modal views

If the BT-105 does not work when a modal view is displayed: modal views displayed with `modalPresentationStyle` set to `UIModalPresentationFormSheet` will suspend keyboard input to `AirTurnView`.  To make `AirTurnViewManager` respond to AirTurn events while a form sheet is displayed, it must be made first responder again.  The easiest way to do this is by setting the parent view again.

When a modal view is dismissed, if there is no external keyboard connected but a text view is first responder, after the modal view is dismissed the AirTurn framework will indicate an external keyboard has been connected. This is because for some reason, UIKit dismisses the keyboard before resigning first responder. To avoid this problem, resign first responder before the view disappears.