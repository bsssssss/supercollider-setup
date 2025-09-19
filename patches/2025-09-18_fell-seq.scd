s.boot;

(
SynthDef("k", {
	var snd, fenv, fenv2, dur;
	dur = \dur.kr(1);
	fenv = Env.linen(0, 0, 0.03, curve: -5).ar * \fenv.kr(1000);
	fenv2 = Env.linen(0, 0, dur, curve: -4).ar * 100;
	snd = SinOsc.ar(40 + fenv + fenv2);
	snd = snd * Env.linen(0.00, 0, dur, curve: 4).ar(Done.freeSelf);
	snd = snd * (-13.dbamp) * \amp.kr(1);
	snd = snd ! 2;
	Out.ar(\bus.ir(0), snd);
}).add;

SynthDef("s", {
	var snd, fenv, fenv2, dur;
	dur = \dur.kr(1);
	fenv = Env.linen(0, 0, 0.03, curve: -5).ar * \fenv.kr(1000);
	fenv2 = Env.linen(0, 0, dur, curve: -4).ar * 100;
	snd = SinOsc.ar(200 + fenv + fenv2);
	snd = snd + HPF.ar(WhiteNoise.ar, 2000);
	snd = snd * Env.linen(0.00, 0, dur, curve: -4).ar(Done.freeSelf);
	snd = snd * (-12.dbamp) * \amp.kr(1);
	snd = snd ! 2;
	Out.ar(\bus.ir(0), snd);
}).add;

SynthDef("h", {
	var snd, fenv, fenv2, dur;
	dur = \dur.kr(1);
	snd = HPF.ar(WhiteNoise.ar, 12000);
	snd = snd * Env.linen(0.00, 0, dur, curve: -4).ar(Done.freeSelf);
	snd = snd * (-5.dbamp) * \amp.kr(1);
	snd = snd ! 2;
	Out.ar(\bus.ir(0), snd);
}).add;
)

Synth("k", [fenv: 500, dur: 0.4]);
Synth("s", [fenv: 100, dur: 0.1]);
Synth("h", [fenv: 100, dur: 0.1]);
