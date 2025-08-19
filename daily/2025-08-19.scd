s.boot;

(
SynthDef("resaw", {
	var snd;
	var dur = \dur.kr(1);

	snd = Saw.ar(40) ! 2;
	snd = snd * Env.perc(0.008, dur - 0.008, curve: 8).ar(Done.freeSelf);
	snd = RHPF.ar(snd, (Env.perc(0, dur, curve: -8).ar) * 12000 + 100, 0.3);
	snd = snd * -12.dbamp;

	Out.ar(\bus.kr(0), snd)
}).add;
)

Synth("resaw", [dur: 8]);
