s.boot;

(
var folder = PathName.new("~/Sounds/samples/addor/");
~samples = folder.entries.collect({ |file| 
	Buffer.read(s, file.fullPath);
});

SynthDef(\sample_player, {
	|bus=0, buf=0, rate=1, dur=1|
	var snd, phase, numChannels;
	rate = rate * BufRateScale.kr(buf);
	numChannels = 2;
	phase = Line.ar(
		0,
		BufFrames.kr(buf) - 1,
		BufDur.kr(buf) * rate.reciprocal,
		doneAction: Done.freeSelf
	);
	snd = BufRd.ar(numChannels, buf, phase, loop: 1);
	Out.ar(0, snd);
}).add;
)

(
~s0 = Routine({
	var indices, durations;
	var numSnd = ~samples.size - 1;
	var loop = true;
	indices = Array.fill(numSnd, {|i| i + 1});
	indices = indices.scramble;
	durations = Array.fill(numSnd, { rrand(0.33, 1)});

	inf.do({ |index|
		var buf, dur;
		var snd_index = indices[index % indices.size];
		buf = ~samples[snd_index];
		dur = buf.duration * durations[index % durations.size];
		Synth(\sample_player, [buf: buf, rate: 4, dur: dur]);
		("playing sample" + snd_index).postln;
		dur.wait;
	});
	postln("end playing samples");
});
~s0.play;
)

~s0.stop;
~s0.reset;

s.meter;
