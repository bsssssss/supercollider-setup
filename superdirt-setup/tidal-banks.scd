(
// var loadAndReplace = { |path, charToReplace, depth = 1|
// 	(depth-1).do { path = path +/+ "*" };
// 	path = path +/+ "*";
// 	~dirt.loadSoundFiles(pattern, namingFunction: { |x| x.basename.replace(charToReplace, "_") });
// };

// loadAndReplace.("/Users/bss/Sounds/tidal_samples/tidal-drum-machines/machines/*/*", "-", 2);
// loadAndReplace.("/Volumes/T7 Shield/sons/samples/tidal-samples/undo", "_");
// loadAndReplace.("/Volumes/T7 Shield/sons/samples/tidal-samples/jbk", "_");
// loadAndReplace.("/Users/bss/Documents/samples/percussions/", "_");
// loadAndReplace.("/Users/bss/Documents/samples/tidal-samples/bs", "_", 2);

//~dirt.loadSoundFiles(
//	"/Users/bss/Sounds/tidal_samples/tidal-drum-machines/machines/*/*",
//	namingFunction: { |x| x.basename.replace("-", "_") }
//);

load("/Users/bss/Sounds/tidal_samples/tidal-drum-machines/load-banks.scd");

// ~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/samples/tidal-samples/undo/*");
// ~dirt.loadSoundFiles("/Volumes/T7 Shield/sons/samples/tidal-samples/jbk/*");

)
