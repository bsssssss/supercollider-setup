(
var path = PathName.new(thisProcess.nowExecutingPath).parentPath;
"=== Loading global effects ===".postln;
load(path +/+ "gverb.scd");
load(path +/+ "miverb.scd");
)
