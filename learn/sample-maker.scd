s.boot;

(
SynthDef(\simple_bd, {
	var snd, freq, env, penv;
	env = EnvGen.ar(
		Env.new(
			[0, 1, 0],
			[\attack.kr(0), \dur.kr(1)],
			[0, 24]
		),
		doneAction: Done.freeSelf;
	);
	env = env * \amp.kr(-12).dbamp;
	freq = \freq.kr(50);
	penv = EnvGen.ar(
		Env.new(
			[0, 1, 0],
			[\penv_attack.kr(0), \penv_dur.kr(0.1)],
			[0, -8],
		)
	);
	penv = (penv * \penv_amp.kr(1)) * ((SampleRate.ir / 2) - freq);
	snd = SinOsc.ar(freq + penv);
	snd = snd * env;
	Out.ar(0, snd ! 2);
}).add;
)

(
~rec = Routine({
	var rep = 16;
	rep.do { |index|
		var synth=\simple_bd; 
		var	dur=1/16; 
		var rec=Recorder(s);
		var	base_samples_dir="~/Sounds/samples/sc/sample-maker";
		var	path = base_samples_dir +/+ synth.asString;
		var	sample_name = {
			PathName.new(path).entries.size;
		}.value;

		if (sample_name < 10) { sample_name = "0" ++ sample_name };
		path = path +/+ synth.asString ++ "_" ++ sample_name.asString ++ ".wav";

		//rec.prepareForRecord(path, 2);
		s.bind {
			//rec.record(duration: dur);
			Synth(
				synth,
				[
					penv_amp: index.linexp(rep, 0, 1, 0.0001),
					penv_dur: index.linexp(0, rep, 0.5, 0.05),
					dur: dur
				]
			);
		};
		dur.wait;
	}
});
~rec.play;
)

