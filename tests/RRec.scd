s.boot;

(
SynthDef("kick", {
	var snd;
	snd = SinOsc.ar(
		Env.perc(0, \pdur.kr(0.01), curve: -6).ar
			.linlin(0, 1, \freq.kr(50), (SampleRate.ir / 2) * \penv.kr(1))
	);
	snd = snd * Env.perc(0, \dur.kr(1), curve: 4).ar(Done.freeSelf);
	snd = snd * -12.dbamp;
	snd = snd ! 2;
	Out.ar(\bus.kr(0), snd);
}).add;

SynthDef("kickfm", {
	var snd, mod, freq, ratio;
	freq = \note.kr(36).midicps;

	ratio = freq * \ratio.kr(1);
	mod = SinOsc.ar(ratio);

	snd = SinOsc.ar(
		Env.perc(0, \pdur.kr(0.01), curve: -6).ar
			.linlin(0, 1, freq, freq + (((SampleRate.ir / 2) - freq) * \penv.kr(1)))
		+ (mod * \index.kr(1000))
	);
	snd = snd * Env.perc(0.004, \dur.kr(1) - 0.004, curve: 8).ar(Done.freeSelf);
	snd = snd * -12.dbamp;
	snd = snd ! 2;

	Out.ar(\bus.kr(0), snd);
}).add;
)

(
~r = Routine({
	var rec = RRec();
	4.do {
		var dur = 1/8;
		s.bind {
			rec.record(duration: dur);
			Synth("kick", [dur: dur]);
		};
		dur.wait;
	}
});
~r.play;
)

Synth("kick");
Synth("kickfm", [ratio: (9.2), index: 50, penv: 0.01, pdur: 0.2]);

s.meter;
s.plotTree;
