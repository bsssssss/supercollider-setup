s.boot;

(
SynthDef("k", {
	var snd;
	snd = SinOsc.ar(\freq.kr(60));
	snd = snd * EnvGen.ar(Env.new([0,1,0], [0.01, \dec.kr(0.1)], -5), doneAction: Done.freeSelf);
	snd = snd ! 2;
	snd = snd * -12.dbamp;
	Out.ar(\bus.kr(0), snd);
}).add;
)

Synth("k");

~durs = [1,2,3,3,1,2,4,5];

(
~seq = Routine {
	loop {
		fork {
			~durs.do { |d,i|
				s.bind {
					Synth("k");
				};
				(d/8).wait;
			};
		};
		fork {
			~durs.reverse.do { |d,i|
				s.bind {
				Synth("k", [freq: 80, dec: 0.7]);
				};
				((d)/8).wait;
			};
		}
	};
}.play;
)
~seq.stop;
