(
// server options are only updated on reboot
// configure the sound server: here you could add hardware specific options
// see http://doc.sccode.org/Classes/ServerOptions.html

s.options.device_("BH+MBP");
s.options.hardwareBufferSize = 128;
// s.options.numInputBusChannels  = 0;

s.options.numBuffers  = 1024 * 32; // increase this if you need to load more samples
s.options.memSize     = 8192 * 16; // increase this if you get "alloc failed" messages
s.options.numWireBufs = 1024 * 8;  // increase this if you get "exceeded number of interconnect buffers" messages
s.options.maxNodes    = 1024 * 32; // increase this if you are getting drop outs and the message "too many nodes"

// boot the server and start SuperDirt
s.waitForBoot {
	~dirt.stop;              // stop any old ones, avoid duplicate dirt (if it is nil, this won't do anything)
	~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels

	/*
	 * Samples
	 */

	~dirt.doNotReadYet = true;
	~dirt.loadSoundFiles("~/Sounds/samples/addor");
	~dirt.loadSoundFiles("~/Sounds/samples/clak/");
	~dirt.loadSoundFiles("~/Sounds/samples/sinst/");
	~dirt.loadSoundFiles("~/Sounds/tidal_samples/jungle_breaks/*");
	~dirt.loadSoundFiles("~/Sounds/samples/sc/rrec/kickfm");
	~dirt.loadSoundFiles("~/Sounds/tidal_samples/autodafe/*");
	~dirt.loadSoundFiles("~/Sounds/tidal_samples/jungle/junglebreaks");
	~dirt.loadSoundFiles("~/Sounds/tidal_samples/jungle/junglebreaks2");
	~dirt.loadSoundFiles("~/Sounds/tidal_samples/jungle/junglebreaks3");
	~dirt.loadSoundFiles("~/Sounds/tidal_samples/legowelt/*");
	~dirt.loadSoundFiles("~/Sounds/tidal_samples/undo/*");
	~dirt.loadSoundFiles("~/Sounds/samples/chansons/bruant");

	if (PathName("/Volumes/T7 Shield").isFolder) {
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/samples/tidal-samples/jbk/*");
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/Archives/zoom/stereos");
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/Archives/zoom/stereos2");
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/Archives/zoom/stereos3");
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/Archives/zoom/stereos4");
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/Archives/zoom/stereos5");
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/Archives/zoom/stereos6");
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/Archives/adecoup");
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/Archives/longs/longs");
	};

	TidalDrumMachines.loadBanks(~dirt);
	// s.sync; // optionally: wait for samples to be read

	postln("");
	postln("*************");
	postln("* Bss Setup *");
	postln("*************");
	postln("");

	// MIDI
	MIDIClient.init(verbose: false);
	load("tidal-midi.scd".resolveRelative);
	// load(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "/tidal-midi-audiobox.scd");
	// load(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "/tidal-midi-audiobox&m8u.scd");
	// load(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "/tidal-midi-m8u.scd");

	// SYNTHS & FX
	load("bs/synths/config.scd".resolveRelative);
	load("bs/fx/bs_fx.scd".resolveRelative);
	load("dirt-compressor.scd".resolveRelative);
	load("dirt-modules-order.scd".resolveRelative);

	// scala setup
	// load(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "/scala.scd");


	// ~dirt.start(57120, [0, 2, 4, 6, 8, 10, 12, 14]); // 8 stereos out

	~dirt.start(57120, 0 ! 12); // 12 stereos mixdown
	SuperDirt.default = ~dirt; // make this instance available in sclang (optional)
	"".postln;

	// custom global effects
	load("bs/global_fx/config.scd".resolveRelative);

	// optional, needed for convenient access from sclang:
	(
		~d1 = ~dirt.orbits[0]; ~d2  = ~dirt.orbits[1]; ~d3  = ~dirt.orbits[2];  ~d4  = ~dirt.orbits[3];
		~d5 = ~dirt.orbits[4]; ~d6  = ~dirt.orbits[5]; ~d7  = ~dirt.orbits[6];  ~d8  = ~dirt.orbits[7];
		~d9 = ~dirt.orbits[8]; ~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
	);

	// Update database
	load("dirt-extract-data.scd".resolveRelative);
};

s.latency = 0.5; // increase this if you get "late" messages
)

SuperDirt.resetEverything;
