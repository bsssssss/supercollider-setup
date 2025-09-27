Gamepad {
	var <>userID;
	var <controlNames;
	var <callbacks;

	*new { |userID|
		^super.new.init(userID);
	}

	init { |uID|
		userID = uID;
		controlNames = [
			\LX, \LY,
			\RX, \RY,
		];
		this.initCallbacks;
		this.makeOSCDefs;
	}

	makeOSCDefs {
		controlNames.do { |controlName|
			var path = format("/gamepad/%/%", userID, controlName);
			OSCdef(format("%_%", userID, controlName), { |msg|
				var value = msg[1];
				this.callback(controlName, value);

			}, path, recvPort: 57130);
		}
	}

	initCallbacks {
		callbacks = IdentityDictionary.new;
		controlNames.do { |controlName|
			callbacks[controlName] = [];
		}
	}

	addControlFunc { |controlName, func|
		callbacks[controlName] = callbacks[controlName].add(func);
	}

	clearControlFuncs { |controlName|
		if (callbacks[controlName].isNil) {
			"No function registered yet for %"
				.format(controlName)
				.postln;
		} {
			callbacks[controlName] = [];
		}
	}

	callback { |controlName, value|
		callbacks[controlName].do { |func|
			func.value(value);
		}
	}

	postCallbacks {
		callbacks.keysValuesDo { |k, v|
			format("%: % functions", k, v.size).postln;
		}
	}

	clearAll {
		this.initCallbacks;
	}
}
