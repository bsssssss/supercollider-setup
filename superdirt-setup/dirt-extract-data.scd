(
var sounds_path = PathName.new(thisProcess.nowExecutingPath).parentPath +/+ "tmp/sounds.txt";
var sounds = ~dirt.buffers.keys.asArray.sort;
var banks_path = PathName.new(thisProcess.nowExecutingPath).parentPath +/+ "tmp/banks.txt";
var banks = ~dirt.banks.keys.asArray.sort;

File.use(sounds_path, "w", { |f|
	sounds.do { |name|
		f.write(format("%\n", name));
	}
});

File.use(banks_path, "w", { |f|
	banks.do { |name|
		f.write(format("%\n", name));
	}
})
)
