/* dualshock4 vendor and product ID: 1356, 2508
*/

Gamepad {
	classvar <device;
	var <vendorID, <productID, <path;
	var <connectRoutine;
	var <timeout;
	var <disconnectedByUser;

	*new { |vendorID, productID, path, timeout|
		^super.new.init(vendorID, productID, path, timeout);
	}

	init { |vID, pID, p, t|
		vendorID = vID;
		productID = pID;
		path = p;
		timeout = t ?? 3;
	}

	connect {
		var foundDevices;
		HID.findAvailable; // rescan
		foundDevices = HID.findBy(vendorID, productID, path);
		disconnectedByUser = false;

		if (foundDevices.isEmpty) { // If not found, retry
			format("No device found with vendorID: %, productID: %, path: %", vendorID, productID, path).postln;
			format("trying again in % seconds...\n", timeout).postln;
			this.retryConnect;
		} {
			if (foundDevices.size == 1) {
				foundDevices.do {|d|
					this.open(d);
				};
			} {
				"Found more than one device !".postln;
				foundDevices.do { |d| 
					d.postInfo;
				};
			};
		};
	}

	open { |deviceInfo|
		if (not(this.isConnected)) {
			"Connecting %...".format(deviceInfo.productName).postln;
			device = deviceInfo.open;
			device.closeAction = {
				device = nil;
				format("% disconnected", deviceInfo.productName).postln;
				if (not(disconnectedByUser)) {
					this.retryConnect;
				};
			};
		} {
			format("% is already connected to this instance", device.info.productName).postln;
		};
	}

	isConnected {
		if (device.notNil) {
			if (device.isOpen) { ^true } { ^false };
		} {
			^false;
		};
	}

	disconnect {
		if (device.notNil) {
			if (device.isOpen) {
				disconnectedByUser = true;
				device.close
			} {
				format("% is not connected", device.info.productName);
			};
		}
	}

	retryConnect {
		connectRoutine = Routine({ timeout.wait; this.connect });
		connectRoutine.play;
	}

}
