// register a user (0 based)
~user1 = Gamepad(0);
// get back the user
~user1.userID;
// the list of control names
~user1.controlNames;
// the IdentityDictionary of callbacks
~user1.callbacks;
// prints the number of functions registered per controls
~user1.postCallbacks;
// maps a control name to a function
// this doesn't replace previously set functions for this control
// it adds it to an array of functions
~user1.addControlFunc(\LX, { |val| val.postln });
~user1.addControlFunc(\LX, { |val| (val ! 2).postln });
// reset a control name's mapping to an empty array
~user1.clearControlFuncs(\LX);
// reset all control mappings to empty arrays
~user1.clearAll;
