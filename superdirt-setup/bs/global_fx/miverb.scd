Routine({
	var numChannels = ~dirt.numChannels;
	"*** Loading MiVerb ***".postln;
	(1..SuperDirt.maxSampleNumChannels).do { |numChannels|
		SynthDef("dirt_global_miverb" ++ numChannels, {
			|dryBus, effectBus, gate=1, miverb_wet=0.5|

			var snd = In.ar(dryBus, numChannels);
			snd = MiVerb.ar(snd, drywet: miverb_wet);
			//snd = snd * EnvGen.kr(Env.asr, gate, doneAction:2);
			DirtPause.ar(snd.sum, graceTime:4);
			Out.ar(effectBus, snd)
		}, [\ir, \ir, \kr]).add;
	};

	s.sync;

	~dirt.orbits.do { |x|
		x.globalEffects = x.globalEffects
		.addFirst(GlobalDirtEffect(\dirt_global_miverb, [\miverb_wet]));
		x.initNodeTree;
	};
}).play;
