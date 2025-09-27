s.boot;

~user1 = Gamepad(0);
~user1.userID;
~user1.controlNames;
~user1.callbacks;
~user1.postCallbacks;

~user1.addControlFunc(\LX, { |val| val.postln });
~user1.addControlFunc(\LX, { |val| (val ! 2).postln });

~user1.clearControlFuncs(\LX);
~user1.clearAll;
