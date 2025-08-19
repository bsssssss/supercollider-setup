s.options.numInputBusChannels = 19;
s.options.numOutputBusChannels = 20;
s.options.device = "AB+MBP";

s.boot;
s.meter;

(
SynthDef("es8_recv", {
	var snd;

	snd = SoundIn.ar(\in.kr(0) + 10);
	snd = LeakDC.ar(snd);
	snd = Pan2.ar(snd);

	Out.ar(18, snd);
}).add;
)

Synth("es8_recv");

(
SynthDef("es8_send", {
	var snd, freq;
	freq = \freq.kr(1) * LFBrownNoise2.ar(rrand(0.2, 1) ! 8).linexp(0, 1, 0.001, 10);
	snd = SinOsc.ar(freq) * LFBrownNoise2.ar(rrand(0.2, 1) ! 8).linlin(0, 1, 0.1, 0.5);
	snd = snd * \amp.kr(1);

	Out.ar(10, snd);
}).add;
)

~s = Synth("es8_send");
~s.set(
	\amp, 0.3,
	\freq, 0.02
);
~s.free;

