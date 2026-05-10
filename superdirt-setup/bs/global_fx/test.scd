(
var numChannels = ~dirt.numChannels;

SynthDef("dirt_global_miverb" ++ numChannels, { 
	| dryBus, effectBus, gate=1,
	  miverb_send, miverb_wet=1, miverb_time=0.9, miverb_damp=0.5,
	  miverb_hp=0.05, miverb_freeze, miverb_diff=0.625 |

	var snd = In.ar(dryBus, numChannels);

	snd = MiVerb.ar(
		snd * miverb_send,
		miverb_time,
		miverb_wet,
		miverb_damp,
		miverb_hp,
		miverb_freeze,
		miverb_diff
	);

	DirtPause.ar(snd.sum, graceTime:4);
	Out.ar(effectBus, snd)
}, [\ir, \ir]).add;

s.sync;

~dirt.orbits.do { |x|
	x.globalEffects = x.globalEffects.addFirst(GlobalDirtEffect(\dirt_global_miverb, [\miverb_send]));
	x.initNodeTree;
};
)

