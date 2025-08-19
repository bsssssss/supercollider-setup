s.boot;

(
SynthDef("gverb", {
	var snd, env;
	snd = SinOsc.ar(\freq.kr(50));
	env = EnvGen.ar(Env.perc, doneAction: Done.freeSelf);
	snd = snd * env;
	snd = snd * (-24).dbamp;
	snd = GVerb.ar(snd, revtime: 10);
	Out.ar(0, snd);
}).add;
)

Synth("gverb", [freq: {exprand(50, 10000)}]);

s.freeAll;
s.meter;

s.plotTree;

