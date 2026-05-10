(
var numChannels = ~dirt.numChannels;

SynthDef("dirt_global_miverb" ++ numChannels, { | dryBus, effectBus, gate=1 |
	var in = In.ar(dryBus, numChannels);
	var snd;

	snd = MiVerb.ar(
		in * \miverb_send.kr(0),
		\miverb_time.kr(0.9),
		\miverb_wet.kr(1),
		\miverb_damp.kr(0.5),
		\miverb_hp.kr(0.05),
		\miverb_freeze.kr(0),
		\miverb_diff.kr(0.666)
	);

	DirtPause.ar(snd.sum, graceTime:4);
	Out.ar(effectBus, snd)
}, [\ir, \ir]).add;


SynthDef("dirt_global_chorus" ++ numChannels, { 
	| dryBus, effectBus, gate=1, chorus_wet=0, chorus_speed=8, chorus_depth=0.1, chorus_predelay=20, chorus_fbk=0 |

	var in       = In.ar(dryBus, numChannels);
	var predelay = chorus_predelay.clip(5, 10000) / 1000;
	var depth    = chorus_depth.clip(0, 1);
	var snd      = CombL.ar(in, 10, SinOsc.kr(chorus_speed).linlin(-1, 1, 0, 1) * depth + predelay, chorus_fbk);
	snd          = XFade2.ar(in * (1 - chorus_wet), snd * chorus_wet);

	DirtPause.ar(snd, 4);
	Out.ar(effectBus, snd);
}, [\ir, \ir]).add;

//SynthDef("dirt_global_compressor" ++ numChannels, { 
//	|dryBus, effectBus, gate=1|
//
//	var amplitude, attack, release, treshold, slope;
//	var inArray, snd;
//
//	treshold = \g_comp_tresh.kr(0);
//	slope    = \g_comp_slope.kr(1/4);
//	attack   = \g_comp_atk.kr(0.05);
//	release  = \g_comp_rel.kr(0.3);
//	snd      = In.ar(dryBus, numChannels);
//
//	amplitude = (Amplitude.ar(snd, attack, release) / snd.size.sqrt).max(-100.dbamp).ampdb;
//	amplitude = ((amplitude - treshold).max(0) * (slope - 1)).lag(attack).dbamp;
//	snd       = snd * amplitude;
//
//	DirtPause.ar(snd.sum, 4);
//	ReplaceOut.ar(effectBus, snd);
//}, [\ir, \ir]).add;

//SynthDef("dirt_global_gverb" ++ numChannels, {
//	| dryBus, effectBus, gate=1,
//	  gverb_send=1, gverb_size=10, gverb_time=3, gverb_damp=0.5,
//	  gverb_bw=0.5, gverb_spread=15, gverb_dry=1, gverb_er=0.7, gverb_tail=0.7 |
//
//	var snd = In.ar(dryBus, numChannels);
//	snd = GVerb.ar(
//		snd * gverb_send,
//		gverb_size.clip(0.0, 1) * 300,
//		gverb_time,
//		gverb_damp,
//		gverb_bw,
//		gverb_spread,
//		gverb_dry, 
//		gverb_er, 
//		gverb_tail, 
//	);
//
//	DirtPause.ar(snd, graceTime:4);
//	Out.ar(effectBus, snd)
//}, [\ir, \ir, \kr]).add;

)
