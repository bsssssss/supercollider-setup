(
var path = PathName.new(thisProcess.nowExecutingPath).parentPath;
var modules = [
    "bs_sine",
    "bs_noise",
    "bs_trig",
    "bs_sinefm",
    "bs_laz",
    "bs_saw",
    "mi_braids",
    "mi_plaits",
    "mi_rings",
    // "mi_omi",
    // "mi_tides"
];

"=== Loading custom synths ===".postln;
modules.do { |module|
    load(path ++ "/modules/" ++ module ++ ".scd");
    postln("\t" ++ module);
};
)


