s.boot;

(
SynthDef("kick", {
	var snd, dur;
	dur = \duration.kr(1);
	snd = SinOsc.ar(Env.perc(0, 0.2, curve: -10).ar.linexp(0, 1, 40, 8000));
	snd = snd * Env.perc(0.01, dur - 0.01, curve: 4).ar(2);
	snd = snd * -6.dbamp;
	snd = Pan2.ar(snd, \pan.kr(0.0));
	Out.ar(0, snd);
}).add;

SynthDef("snare", {
	var snd, dur;
	dur = \duration.kr(1);
	snd = SinOsc.ar(Env.perc(0, 0.2, curve: -3).ar.linexp(0, 1, 200, 8000));
	snd = snd + BPF.ar(WhiteNoise.ar, Env.perc(0, 0.2).ar.linlin(0, 1, 200, 8000), 2);
	snd = snd * Env.perc(0.01, dur - 0.01, curve: -8).ar(2);
	snd = snd * -6.dbamp;
	snd = Pan2.ar(snd, \pan.kr(0.0));
	Out.ar(0, snd);
}).add;
)

(
var s, beat, seq, play;
s = Server.default;
beat = 60 / 134;

play = { |synthDef, duration, args = #[]| 
	s.bind { Synth(synthDef, [duration: duration * beat]) };
};

seq = { |synthDef, duration, args = #[]| 
	play.(synthDef, duration, args);
	(duration * beat).wait;
};

Routine({
	inf.do {
		seq.("kick", [1,2,3].choose);
		seq.("snare", 1.0);
	};
}).play;
)

s.meter;
s.plotTree;
