s.boot;

(
~clock = TempoClock(180/60).permanent_(true);

SynthDef("hat", {
	var snd;
	snd = HPF.ar(WhiteNoise.ar(), 12000);
	snd = snd * Env.perc(\atk.kr(0.004), \rel.kr(0.1)).ar(Done.freeSelf);
	snd = snd * \amp.kr(0.3);
	snd = snd ! 2;
	Out.ar(\bus.ir(0), snd);
}).add;
//Synth("hat");

~rissetR = Routine({
	var play, playP,
		dur, bpms, steps, baseTempo, amps;

	play = { |synthDef, args = #[], dur|
		s.bind { Synth(synthDef, args) };
		dur.wait;
	};

	playP = { |synthDef, args = #[]|
		s.bind { Synth(synthDef, args) };
	};

	baseTempo = 190;
	bpms      = [baseTempo, baseTempo * 0.5];
	steps     = 128;
	dur       = 1/4;

	amps = [
		[0.3, 0.3],
		[0.3, 0.3 * (-70.dbamp)],
	];

	bpms = bpms.reverse;
	amps = amps.reverse;

	inf.do { |i|
		var tempo, amp;
		i = i % steps;

		tempo = i.linexp(0, steps-1, bpms[0], bpms[1]);
		~clock.tempo_(tempo / 60);

		amps.collect { |a|
			amp = i.linexp(0, steps-1, amps[1], amps[0]); 
		};
		amp = amp.wrapAt(i);

		play.( "hat", [rel: 0.08, amp: amp], dur: dur);
	};
});
)

~rissetR.play(clock: ~clock);
