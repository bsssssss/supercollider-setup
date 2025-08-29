s.boot;
s.meter;

(
SynthDef("resaw", {
	var snd;
	var dur = \dur.kr(1);
	var freq = \freq.kr(33);

	snd = Pulse.ar(freq) ! 2;
	snd = RHPF.ar(snd, XLine.ar(22050, freq, dur), 0.99);
	snd = BPF.ar(snd, XLine.ar(22050, freq, dur), 0.99);
	snd = snd * Env.perc(0, dur, curve: 8).ar(Done.freeSelf);
	snd = snd * -3.dbamp;

	Out.ar(\bus.kr(0), snd)
}).add;

SynthDef("kick", {
	var snd, penv;
	var dur = \dur.kr(1);
	var freq = \freq.kr(33);

	penv = EnvGen.ar( Env([1,0], [0.01], [-8]))
		.linlin(0, 1, 0, 500);
	penv = penv + Env.perc(0, dur/3).ar
		.linlin(0, 1, freq, freq * 1.5);

	snd = SinOsc.ar(penv) * Env.perc(0, dur, curve: 0).ar(Done.freeSelf);
	snd = snd * -3.dbamp;
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
		var rep, dur, del, freq;

		rep = [1, 2, 3, 5, 8].choose;
		freq = [20, 30, 40, 50, 80].choose;

		if (rep > 2) {
			dur = [1/6, 1/8, 1/16, 1/32].choose;
			del = dur * 0.5;
		} {
			dur = [1/2, 1, 1.5, 2, 3].choose;
			del = 0;
		};

		rep.do {
			s.bind {
				Synth("kick", [dur: dur / 2, freq: freq]);
			};
			del.wait;
			s.bind {
				Synth("resaw", [dur: dur, freq: freq]);
			};
			dur.wait;
		};
	}
});
~r.play;
)

s.meter;
s.scope;
