(
var path = PathName.new(thisProcess.nowExecutingPath).parentPath;
// load(path +/+ "gverb.scd");
load(path +/+ "miverb.scd");
~dirt.orbits.do { |x| x.globalEffects.postln; " ----------".postln; }
)
