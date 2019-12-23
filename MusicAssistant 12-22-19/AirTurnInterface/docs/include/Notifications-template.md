# Notifications

All notifications are posted to `[NSNotificationCenter defaultCenter]` with `object` set to the posting object.



## <a name="StandardKeys"></a>Standard userInfo keys

These keys are present in the userInfo dictionaries of all notifications which indicate so.

### <a name="AirTurnPeripheralKey"></a>AirTurnPeripheralKey

	AIRTURN_EXTERN NSString * AirTurnPeripheralKey;

#### Discussion

The notification `userInfo` key for the peripheral that the notification is concerning. The value is an `AirTurnPeripheral` object. Only present on BTLE device notifications.

### <a name="AirTurnIDKey"></a>AirTurnIDKey

	AIRTURN_EXTERN NSString * AirTurnIDKey;
		
#### Discussion

 The notification `userInfo` key for the AirTurn identifier. The value is a `NSString` object. Only present on BTLE device notifications.

### <a name="AirTurnDeviceTypeKey"></a>AirTurnDeviceTypeKey

	AIRTURN_EXTERN NSString * AirTurnDeviceTypeKey;
		
#### Discussion

The notification `userInfo` key for the device type on connection notification. The value is an `NSNumber` object containing an integer which is one of the `AirTurnDeviceType` enum values.



## Pedal event notifications

### AirTurnPedalPressNotification

	AIRTURN_EXTERN NSString * AirTurnPedalPressNotification;
		
#### Discussion

A notification indicating which pedal was pressed. A press occurs on pedal down, then at the key repeat rate after intial repeat delay. The `userInfo` dictionary contains all [standard keys](#StandardKeys) and the key [`AirTurnPortNumberKey`](#AirTurnPortNumberKey) contains the port of the pedal that was pressed and [`AirTurnPortStateKey`](#AirTurnPortStateKey) contains the state of the pedal, which will be `AirTurnPortStateDown`. For HID devices, [`AirTurnKeyCodeKey`](#AirTurnKeyCodeKey) contains the key code. For PED devices, [`AirTurnPedalRepeatCount`](#AirTurnPedalRepeatCount) contains the number of key repeats.

### AirTurnPedalDownNotification

	AIRTURN_EXTERN NSString * AirTurnPedalDownNotification;
		
#### Discussion

A notification indicating a pedal was pressed down. The `userInfo` dictionary contains all [standard keys](#StandardKeys) and the key [`AirTurnPortNumberKey`](#AirTurnPortNumberKey) contains the port of the pedal that was pressed and [`AirTurnPortStateKey`](#AirTurnPortStateKey) contains the state of the pedal, which will be `AirTurnPortStateDown`.

### AirTurnPedalUpNotification

	AIRTURN_EXTERN NSString * AirTurnPedalUpNotification;
		
#### Discussion

A notification indicating which pedal was pressed. A press occurs on pedal down, then at the key repeat rate after intial repeat delay. The `userInfo` dictionary contains all [standard keys](#StandardKeys) and the key [`AirTurnPortNumberKey`](#AirTurnPortNumberKey) contains the port of the pedal that was pressed and [`AirTurnPortStateKey`](#AirTurnPortStateKey) contains the state of the pedal, which will be `AirTurnPortStateUp`. For PED devices, [`AirTurnPedalRepeatCount`](#AirTurnPedalRepeatCount) contains the number of key repeats that occurred.

### <a name="AirTurnPortNumberKey"></a>AirTurnPortNumberKey

	AIRTURN_EXTERN NSString * AirTurnPortNumberKey;
		
#### Discussion

The notification `userInfo` key for the connected state. The value is an `NSNumber` object containing an integer which is one of the `AirTurnConnectionState` enum values

### <a name="AirTurnPortStateKey"></a>AirTurnPortStateKey

	AIRTURN_EXTERN NSString * AirTurnPortStateKey;
		
#### Discussion

The notification `userInfo` key for the port state. The value is an `NSNumber` object containing an integer which is one of the `AirTurnPortState` enum values

### <a name="AirTurnKeyCodeKey"></a>AirTurnKeyCodeKey

AIRTURN_EXTERN NSString * AirTurnKeyCodeKey;

#### Discussion

The notification `userInfo` key for the port state from a HID device only. The value is an `NSNumber` object containing an integer which is one of the `AirTurnKeyCode` enum values.

### <a name="AirTurnPedalRepeatCount"></a>AirTurnPedalRepeatCount

AIRTURN_EXTERN NSString * AirTurnPedalRepeatCount;

#### Discussion

The notification `userInfo` key for the repeat count when a pedal is held. Only present for PED devices. The value is an `NSNumber` object containing an integer representing the number of repeats. This will be 0 on the first pedal press event and increment subsequently.



## BTLE Central State

### AirTurnCentralStateChangedNotification

	AIRTURN_EXTERN NSString * AirTurnCentralStateChangedNotification;
		
#### Discussion

A notification indicating the state of the central has changed. The `userInfo` key [`AirTurnCentralStateKey`](#AirTurnCentralStateKey) contains an `NSNumber` object containing an integer which is one of the `AirTurnCentralState` enum values

### <a name="AirTurnCentralStateKey"></a>AirTurnCentralStateKey

	AIRTURN_EXTERN NSString * AirTurnCentralStateKey;
		
#### Discussion

The notification `userInfo` key for the new central state. The value is an `NSNumber` object containing one of the `AirTurnCentralState` enum values

## BTLE Devices Discovered/Lost Notifications

### AirTurnDiscoveredNotification

	AIRTURN_EXTERN NSString * AirTurnDiscoveredNotification;
		
#### Discussion

A notification indicating the list of BTLE Devices discovered has changed. The `userInfo` dictionary contains all [standard keys](#StandardKeys) and the key [`AirTurnDiscoveredPeripheralsKey`](#AirTurnDiscoveredPeripheralsKey) contains the set of all discovered devices, and [`AirTurnPeripheralKey`](#AirTurnPeripheralKey) contains the device just discovered

### <a name="AirTurnDiscoveredPeripheralsKey"></a>AirTurnDiscoveredPeripheralsKey

	AIRTURN_EXTERN NSString * AirTurnDiscoveredPeripheralsKey;
		
#### Discussion

The notification `userInfo` key for all discovered BTLE devices. The value is an `NSSet` object containing `AirTurnPeripheral` objects. Pass a peripheral object back to `-connectToAirTurn:` on `AirTurnCentral` to connect.

### AirTurnLostNotification

AIRTURN_EXTERN NSString * AirTurnLostNotification;

#### Discussion

A notification indicating the list of BTLE Devices discovered has changed. The `userInfo` dictionary contains all [standard keys](#StandardKeys) and the key [`AirTurnDiscoveredPeripheralsKey`](#AirTurnDiscoveredPeripheralsKey) contains the set of all discovered devices, and [`AirTurnPeripheralKey`](#AirTurnPeripheralKey) contains the device just lost. The device could have been lost if we have not received an advertising packet within a 10 second window, 10 seconds after disconnecting from a device without receiving an advertising packet, or when the state of the Bluetooth radio changes.



## Connection Notifications

### AirTurnConnectingNotification

	AIRTURN_EXTERN NSString * AirTurnConnectingNotification;
		
#### Discussion

A notification indicating the BTLE central is connecting to an AirTurn. The `userInfo` dictionary contains all [standard keys](#StandardKeys)

### AirTurnConnectionStateChangedNotification

	AIRTURN_EXTERN NSString * AirTurnConnectionStateChangedNotification;
		
#### Discussion

A notification indicating the connection state changed. The `userInfo` dictionary contains all [standard keys](#StandardKeys) and the key [`AirTurnConnectionStateKey`](#AirTurnConnectionStateKey) contains the new connection state

### AirTurnDidConnectNotification

	AIRTURN_EXTERN NSString * AirTurnDidConnectNotification;
		
#### Discussion

A notification indicating an AirTurn device failed to connect. The `userInfo` dictionary contains all [standard keys](#StandardKeys) and the key [`AirTurnConnectionStateKey`](#AirTurnConnectionStateKey) contains the new connection state

### AirTurnDidFailToConnectNotification

	AIRTURN_EXTERN NSString * AirTurnDidFailToConnectNotification;
		
#### Discussion

A notification indicating an AirTurn device failed to connect. The `userInfo` dictionary contains all [standard keys](#StandardKeys)

### AirTurnDidDisconnectNotification

	AIRTURN_EXTERN NSString * AirTurnDidDisconnectNotification;
		
#### Discussion

A notification indicating an AirTurn device disconnected. The `userInfo` dictionary contains all [standard keys](#StandardKeys) and the key [`AirTurnConnectionStateKey`](#AirTurnConnectionStateKey) contains the new connection state

### <a name="AirTurnConnectionStateKey"></a>AirTurnConnectionStateKey

	AIRTURN_EXTERN NSString * AirTurnConnectionStateKey;
		
#### Discussion

The notification `userInfo` key for the connected state. The value is an `NSNumber` object containing an integer which is one of the `AirTurnConnectionState` enum values

### <a name="AirTurnErrorKey"></a>AirTurnErrorKey

	AIRTURN_EXTERN NSString * AirTurnErrorKey;
		
#### Discussion

The notification `userInfo` key for the error. The value is an `NSError` object.



## Storage notifications

### <a name="AirTurnAddedNotification"></a>AirTurnAddedNotification

	AIRTURN_EXTERN NSString * AirTurnAddedNotification;
		
#### Discussion

A notification indicating an AirTurn device was added. The `userInfo` dictionary contains all [standard keys](#StandardKeys)

### <a name="AirTurnRemovedNotification"></a>AirTurnRemovedNotification

	AIRTURN_EXTERN NSString * AirTurnRemovedNotification;
		
#### Discussion

A notification indicating an AirTurn device was removed. The `userInfo` dictionary contains all [standard keys](#StandardKeys)

### <a name="AirTurnInvalidatedNotification"></a>AirTurnInvalidatedNotification

	AIRTURN_EXTERN NSString * AirTurnInvalidatedNotification;
		
#### Discussion

A notification indicating an AirTurn device was invalidated, meaning the identifier originally used is no longer valid and your Application should removed any stored data relating to that identifier. This notification can only occur at App start. The `userInfo` key [`AirTurnIDKey`](#AirTurnIDKey) contains a unique identifier string for the device.




## Peripheral Notifications

### AirTurnEncounteredErrorNotification

	AIRTURN_EXTERN NSString * AirTurnEncounteredErrorNotification;
		
#### Discussion

A notification indicating an error has occurred while performing an action on the peripheral. The `userInfo` dictionary contains all [standard keys](#StandardKeys) and the key [`AirTurnErrorKey`](#AirTurnErrorKey) contains the `NSError` object. The posting object is the `AirTurnPeripheral`.

### AirTurnWriteCompleteNotification

	AIRTURN_EXTERN NSString * AirTurnWriteCompleteNotification;
		
#### Discussion

A notification indicating a value has been written successfully to the peripheral. The `userInfo` dictionary contains all [standard keys](#StandardKeys) and the key [`AirTurnWriteTypeKey`](#AirTurnWriteTypeKey) contains a `NSNumber` object containing an integer which is one of the `AirTurnWriteType` values. The posting object is the `AirTurnPeripheral`.

### <a name="AirTurnWriteTypeKey"></a>AirTurnWriteTypeKey

	AIRTURN_EXTERN NSString * AirTurnWriteTypeKey;
		
#### Discussion

The notification `userInfo` key for the type of value just written on write complete notification. The value is an `NSNumber` object containing an integer which is one of the `AirTurnPeripheralWriteType` values.

### AirTurnDidUpdateNameNotification

AIRTURN_EXTERN NSString * AirTurnDidUpdateNameNotification;

#### Discussion

A notification indicating the name of the peripheral has changed. The `userInfo` dictionary contains all [standard keys](#StandardKeys). The posting object is the `AirTurnPeripheral`.




## Keyboard Notifications

These notifications supercede the UIKeyboard notifications, and can be used even when automatic keyboard management is disabled.

### AirTurnAutomaticKeyboardManagementEnabledChangedNotification

	AIRTURN_EXTERN NSString * AirTurnAutomaticKeyboardManagementEnabledChangedNotification;
		
#### Discussion

A notification indicating automatic keyboard management was enabled or disabled.

### AirTurnVirtualKeyboardWillShowNotification

	AIRTURN_EXTERN NSString * AirTurnVirtualKeyboardWillShowNotification;
		
#### Discussion

A notification indicating the virtual keyboard will be displayed.  The posting object is the `AirTurnKeyboardManager` shared object. The `userInfo` dictionary contains the keys [`AirTurnVirtualKeyboardFrameBeginUserInfoKey`](#AirTurnVirtualKeyboardFrameBeginUserInfoKey), [`AirTurnVirtualKeyboardFrameEndUserInfoKey`](#AirTurnVirtualKeyboardFrameEndUserInfoKey), [`AirTurnVirtualKeyboardAnimationCurveUserInfoKey`](#AirTurnVirtualKeyboardAnimationCurveUserInfoKey) and [`AirTurnVirtualKeyboardAnimationDurationUserInfoKey`](#AirTurnVirtualKeyboardAnimationDurationUserInfoKey).

### AirTurnVirtualKeyboardDidShowNotification

	AIRTURN_EXTERN NSString * AirTurnVirtualKeyboardDidShowNotification;
		
#### Discussion

A notification indicating the virtual keyboard was displayed.  The posting object is the `AirTurnKeyboardManager` shared object. The `userInfo` dictionary contains the keys [`AirTurnVirtualKeyboardFrameBeginUserInfoKey`](#AirTurnVirtualKeyboardFrameBeginUserInfoKey), [`AirTurnVirtualKeyboardFrameEndUserInfoKey`](#AirTurnVirtualKeyboardFrameEndUserInfoKey), [`AirTurnVirtualKeyboardAnimationCurveUserInfoKey`](#AirTurnVirtualKeyboardAnimationCurveUserInfoKey) and [`AirTurnVirtualKeyboardAnimationDurationUserInfoKey`](#AirTurnVirtualKeyboardAnimationDurationUserInfoKey).

### AirTurnVirtualKeyboardWillHideNotification

	AIRTURN_EXTERN NSString * AirTurnVirtualKeyboardWillHideNotification;
		
#### Discussion

A notification indicating the virtual keyboard will be hidden.  The posting object is the `AirTurnKeyboardManager` shared object. The `userInfo` dictionary contains the keys [`AirTurnVirtualKeyboardFrameBeginUserInfoKey`](#AirTurnVirtualKeyboardFrameBeginUserInfoKey), [`AirTurnVirtualKeyboardFrameEndUserInfoKey`](#AirTurnVirtualKeyboardFrameEndUserInfoKey), [`AirTurnVirtualKeyboardAnimationCurveUserInfoKey`](#AirTurnVirtualKeyboardAnimationCurveUserInfoKey) and [`AirTurnVirtualKeyboardAnimationDurationUserInfoKey`](#AirTurnVirtualKeyboardAnimationDurationUserInfoKey).

### AirTurnVirtualKeyboardDidHideNotification

	AIRTURN_EXTERN NSString * AirTurnVirtualKeyboardDidHideNotification;
		
#### Discussion

A notification indicating the virtual keyboard was hidden.  The posting object is the `AirTurnKeyboardManager` shared object. The `userInfo` dictionary contains the keys [`AirTurnVirtualKeyboardFrameBeginUserInfoKey`](#AirTurnVirtualKeyboardFrameBeginUserInfoKey), [`AirTurnVirtualKeyboardFrameEndUserInfoKey`](#AirTurnVirtualKeyboardFrameEndUserInfoKey), [`AirTurnVirtualKeyboardAnimationCurveUserInfoKey`](#AirTurnVirtualKeyboardAnimationCurveUserInfoKey) and [`AirTurnVirtualKeyboardAnimationDurationUserInfoKey`](#AirTurnVirtualKeyboardAnimationDurationUserInfoKey).

### <a name="AirTurnVirtualKeyboardFrameBeginUserInfoKey"></a>AirTurnVirtualKeyboardFrameBeginUserInfoKey

	AIRTURN_EXTERN NSString * AirTurnVirtualKeyboardFrameBeginUserInfoKey;
		
#### Discussion

The notification `userInfo` key for the frame of the keyboard at the beginning of an animation at a show/hide notification.  The value is an `NSValue` object containing a `CGRect`.

### <a name="AirTurnVirtualKeyboardFrameEndUserInfoKey"></a>AirTurnVirtualKeyboardFrameEndUserInfoKey

	AIRTURN_EXTERN NSString * AirTurnVirtualKeyboardFrameEndUserInfoKey;
		
#### Discussion

The notification `userInfo` key for the frame of the keyboard at the end of an animation at a show/hide notification.  The value is an `NSValue` object containing a `CGRect`.

### <a name="AirTurnVirtualKeyboardAnimationCurveUserInfoKey"></a>AirTurnVirtualKeyboardAnimationCurveUserInfoKey

	AIRTURN_EXTERN NSString * AirTurnVirtualKeyboardAnimationCurveUserInfoKey;
		
#### Discussion

The notification `userInfo` key for the keyboard animation curve at a show/hide notification.  The value is an `NSNumber` object containing a `UIViewAnimationCurve` constant.

### <a name="AirTurnVirtualKeyboardAnimationDurationUserInfoKey"></a>AirTurnVirtualKeyboardAnimationDurationUserInfoKey

	AIRTURN_EXTERN NSString * AirTurnVirtualKeyboardAnimationDurationUserInfoKey;
		
#### Discussion

The notification `userInfo` key for the keyboard animation duration at a show/hide notification.  The value is an `NSNumber` object containing a `double` that identifies the duration of the animation in seconds.