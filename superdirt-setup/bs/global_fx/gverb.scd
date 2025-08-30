(
var numChannels = ~dirt.numChannels;
"Loading GVerb".postln;
(1..SuperDirt.maxSampleNumChannels).do { |numChannels|
	SynthDef("dirt_global_gverb" ++ numChannels, {
		|dryBus, effectBus, gate=1|
		var snd = In.ar(dryBus, numChannels);
		snd = GVerb.ar(snd);
		
		//snd = snd * EnvGen.kr(Env.asr, gate, doneAction:2);
		//DirtPause.ar(snd.sum, graceTime:4);

		Out.ar(effectBus, snd)
	}, [\ir, \ir, \kr]).add;
};
)

(
~dirt.orbits.do { |x|
	x.globalEffects = x.globalEffects
		.addFirst(GlobalDirtEffect(\dirt_global_gverb, [\gverb_dry]));
	x.initNodeTree;
};
)

//~dirt.orbits.do { |x| 
//	x.globalEffects.postln;
//};
