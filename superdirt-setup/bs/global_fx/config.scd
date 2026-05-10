(
var effects;

"*** Loading custom global effects ***".postln;
load("./synthdefs.scd".resolveRelative);
s.sync;

effects = [
	[
		\dirt_global_miverb, [
			\miverb_send,
			\miverb_wet,
			\miverb_time,
			\miverb_damp,
			\miverb_hp,
			\miverb_freeze,
			\miverb_diff 
		]
	],
	[
		\dirt_global_chorus, [
			\chorus_wet,
			\chorus_speed,
			\chorus_depth,
			\chorus_predelay,
			\chorus_fbk,
		] 
	],
];

effects.do { |fx|
	~dirt.orbits.do { |x|
		x.globalEffects = x.globalEffects.addFirst(GlobalDirtEffect(fx[0], fx[1]));
		x.initNodeTree;
	};
	postf("\t% %\n", fx[0], fx[1]);
};

"".postln;
)
