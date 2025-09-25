s.boot;

(
SynthDef("kick", {
	var snd;
	snd = SinOsc.ar(40 + Env.linen(0, 0, 0.03, 10000, curve: -4).ar);
	snd = snd ! 2;
	snd = snd * Env.linen(0.008, 0, 1, 1, 0).ar(Done.freeSelf);
	snd = snd * -12.dbamp;
	Out.ar(\out.ir(0), snd);
}).add;
)

Synth("kick");
