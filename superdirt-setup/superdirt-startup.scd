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
	~dirt.stop; // stop any old ones, avoid duplicate dirt (if it is nil, this won't do anything)
	~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
	~dirt.doNotReadYet = true;

	~dirt.loadSoundFiles("~/Sounds/samples/addor");
	~dirt.loadSoundFiles("~/Sounds/samples/clak/");
	~dirt.loadSoundFiles("~/Sounds/samples/sinst/");
	~dirt.loadSoundFiles("~/Sounds/tidal_samples/jungle_breaks/*");
	~dirt.loadSoundFiles("~/Sounds/samples/sc/rrec/kickfm");

	if (PathName("/Volumes/T7 Shield").isFolder) {
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/samples/jungle/junglebreaks");
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/samples/jungle/junglebreaks2");
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/samples/jungle/junglebreaks3");
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/samples/tidal-samples/legowelt/*");
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/samples/tidal-samples/undo/*");
		~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/samples/tidal-samples/jbk/*");
	};

	TidalDrumMachines.loadBanks(~dirt);
	//load(PathName.new(thisProcess.nowExecutingPath).parentPath +/+ "tidal-banks.scd");

	// s.sync; // optionally: wait for samples to be read

	~root_path = "/Users/bss/supercollider/superdirt-setup";

	// MIDI SETUPS :
	MIDIClient.init(verbose: false);
	load(~root_path +/+ "tidal-midi.scd");
	// load(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "/tidal-midi-audiobox.scd");
	// load(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "/tidal-midi-audiobox&m8u.scd");
	// load(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "/tidal-midi-m8u.scd");

	// SYNTHS & FX
	load(~root_path +/+ "bs/synths/config.scd");
	load(~root_path +/+ "bs/fx/bs_fx.scd");
	load(~root_path +/+ "bs/global_fx/config.scd");
	load(~root_path +/+ "dirt-modules-order.scd");
	load(~root_path +/+ "dirt-compressor.scd");

	// Update database
	load(~root_path +/+ "dirt-extract-data.scd");

	// load(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "/scala.scd");

	// ~dirt.start(57120, [0, 2, 4, 6, 8, 10, 12, 14]); // 8 stereos out
	~dirt.start(57120, 0 ! 12); // 12 stereos mixdown

	SuperDirt.default = ~dirt; // make this instance available in sclang (optional)

	// optional, needed for convenient access from sclang:
	(
		~d1 = ~dirt.orbits[0]; ~d2  = ~dirt.orbits[1]; ~d3  = ~dirt.orbits[2];  ~d4  = ~dirt.orbits[3];
		~d5 = ~dirt.orbits[4]; ~d6  = ~dirt.orbits[5]; ~d7  = ~dirt.orbits[6];  ~d8  = ~dirt.orbits[7];
		~d9 = ~dirt.orbits[8]; ~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
	);
};

s.latency = 0.5; // increase this if you get "late" messages
)
