s.boot;

(
SynthDef("kick", { |freq=50, fenv=100|
	var snd, env;

	freq = freq + (EnvGen.ar(Env.new([1, 0], [0.2], -8)) * fenv);
	snd = SinOsc.ar(freq);
	env = EnvGen.ar(Env.perc(0.0, 1), doneAction: Done.freeSelf);
	snd = snd * env * -12.dbamp;
	snd = snd ! 2;

	Out.ar(0, snd);
}).add;
)

Synth("kick");

(
~p = Routine {
	loop {
		[1, 2, 2, 1, 1, 3, 3].do { |n|
			s.bind {
				Synth("kick");
			};
			(n/rrand(4, 8)).wait;
		};
		s.bind {
			Synth("kick", [ freq: 30, fenv: 1000 ]);
		};
		(1/2).wait;
	};
};
)

~p.play;
~p.resume;
~p.stop;
~p.reset;
