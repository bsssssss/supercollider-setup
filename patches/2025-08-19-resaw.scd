s.boot;
s.meter;

(
SynthDef("resaw", {
	var snd;
	var dur = \dur.kr(1);
	var freq = \freq.kr(33);
	var cutoffs = \cutoffs.kr([22050, 33]);
	var hpq = \hpq.kr(0.8);

	snd = Pulse.ar(freq) ! 2;
	snd = RHPF.ar(snd, XLine.ar(cutoffs[0], cutoffs[1], dur), hpq);
	snd = BPF.ar(snd, XLine.ar(cutoffs[0], cutoffs[1], dur), 0.7);
	snd = snd * Env.perc(0.05, dur, curve: 8).ar(Done.freeSelf);
	snd = snd * -3.dbamp;

	Out.ar(\bus.kr(0), snd)
}).add;

SynthDef("kick", {
	var snd, penv;
	var dur = \dur.kr(1);
	var freq = \freq.kr(60);

	penv = EnvGen.ar(Env([1,0], [0.01], [-8]))
		.linlin(0, 1, freq, 500);
	penv = penv + Env.perc(0, dur * (2/3), curve: -8).ar
		.linlin(0, 1, 0, 36.midicps);

	snd = SinOsc.ar(penv) * Env.perc(0, dur, curve: 8).ar(Done.freeSelf);
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
		var rep, dur, del, freq, cutoffs, hpq;

		rep = [1, 4, 6, 8].choose;
		freq = [20, 30, 40, 50, 80].choose;
		hpq = rrand(0.4, 0.7);

		if (rep > 1) {
			dur = [1/6, 1/8, 1/16, 1/32].choose;
			del = 0;
		} {
			dur = [1/2, 1, 1.5, 2, 3].choose;
			del = dur * [0, 0.25, 0.5, 0.75].choose;
		};

		if (0.5.coin) {
			cutoffs = [22050, freq];
		} {
			cutoffs = [freq, 22050];
		};

		rep.do {
			s.bind {
				Synth("kick", [dur: dur, freq: freq]);
			};
			del.wait;
			s.bind {
				Synth(
					"resaw", [
						dur: dur - del,
						freq: freq,
						cutoffs: cutoffs,
						hpq: hpq
					]
				);
			};
			(dur - del).wait;
		};
	}
});
~r.play;
)

s.meter;
s.scope;
