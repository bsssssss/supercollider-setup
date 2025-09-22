/* dualshock4 vendor and product ID: 1356, 2508
*/

Gamepad {
	classvar <device;
	var <vendorID, <productID, <path;
	var <isConnected, <connectRoutine;
	var <timeout;

	*new { |vendorID, productID, path, timeout|
		^super.new.init(vendorID, productID, path, timeout);
	}

	init { |vID, pID, p, t|
		isConnected = false;
		vendorID = vID;
		productID = pID;
		path = p;
		timeout = t ?? 3;
	}

	connect {
		var foundDevices;
		HID.findAvailable; // rescan
		foundDevices = HID.findBy(vendorID, productID, path);

		if (foundDevices.isEmpty) { // If not found, retry
			isConnected = false;
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
		if (device.isNil) {
			"Connecting %...".format(deviceInfo.productName).postln;
			device = deviceInfo.open;
			device.closeAction = {
				device = nil;
				isConnected = false;
				format("% disconnected", deviceInfo.productName).postln;
				this.connect;
			};
			isConnected = true;
		} {
			format("% already connected", device.productName).postln;
		};
	}

	retryConnect {
		connectRoutine = Routine({ timeout.wait; this.connect });
		if (isConnected) {
			connectRoutine.stop;
			connectRoutine = nil;
		} {
			connectRoutine.play;
		};
	}

}
