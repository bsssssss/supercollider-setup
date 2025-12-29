(
var numChannels = ~dirt.numChannels;

(1..SuperDirt.maxSampleNumChannels).do { |numChannels|
	SynthDef("dirt_global_gverb" ++ numChannels, {
		|dryBus, effectBus, gate=1, gverb_send=0|
		var snd = In.ar(dryBus, numChannels);
		snd = GVerb.ar(snd * gverb_send, drylevel: 0);
		
		DirtPause.ar(snd.sum, graceTime:4);
		Out.ar(effectBus, snd)
	}, [\ir, \ir, \kr]).add;
};

s.sync;

~dirt.orbits.do { |x|
	x.globalEffects = x.globalEffects
		.addFirst(GlobalDirtEffect(\dirt_global_gverb, [\gverb_send]));
	x.initNodeTree;
};

"\tGverb [ok]".postln;
)

