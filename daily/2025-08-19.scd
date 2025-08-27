s.reboot;
s.meter;

(
SynthDef("resaw", {
	var snd;
	var dur = \dur.kr(1);
	var freq = \freq.kr(33);

	snd = Pulse.ar(freq) ! 2;
	snd = RHPF.ar(snd, XLine.ar(22050, freq, dur), 0.9);
	snd = BPF.ar(snd, XLine.ar(22050, freq, dur), 0.99);
	snd = snd * Env.perc(0, dur, curve: 12).ar(Done.freeSelf);
	snd = snd * -6.dbamp;

	Out.ar(\bus.kr(0), snd)
}).add;

SynthDef("kick", {
	var snd, penv;
	var dur = \dur.kr(1);

	penv = EnvGen.ar(
		Env([1,0], [0.4], [-8]),
	).linlin(0, 1, 40, 200);

	snd = SinOsc.ar(penv) * Env.perc(0, dur, curve: -4).ar(Done.freeSelf);
	snd = snd * 1.8;
	snd = snd.tanh;
	snd = snd * -12.dbamp;
	snd = snd ! 2;

	Out.ar(\bus.kr(0), snd)
}).add;
)


Synth("resaw", [dur: 1]);
Synth("kick", [dur: 1]);

(
~r = Routine({
	inf.do {
		var rep = [1, 3, 5, 7, 11, 19].choose;
		var dur = [1/16, 1/12, 1/8, 1/6, 1/3, 1/2, 1, 2].choose;
		var freq = [20, 33, 40, 50].choose;

		if ((rep >= 3) && (dur >= (1/8))) { 
			dur = dur / [4, 8, 16].choose;
			freq = freq * 1.1;
		};

		rep.do {
			s.bind {
				Synth("resaw", [dur: dur, freq: freq]);
				Synth("kick", [dur: dur]);
			};
			dur.wait;
		};
	}
});
~r.play;
)

(
~r = Routine({
	inf.do {
		var rep, dur, freq;

		rep = [1,2,3,5,8].choose;
		freq = [20, 30, 40, 50].choose;

		if (rep > 1) {
			dur = [1/6, 1/8, 1/16].choose;
		} {
			dur = [1/2, 1, 1.5, 2, 3].choose;
		};

		rep.do {
			s.bind {
				Synth("resaw", [dur: dur, freq: freq]);
				Synth("kick", [dur: dur]);
			};
			dur.wait;
		};
	}
});
~r.play;
)

s.meter;
s.scope;
