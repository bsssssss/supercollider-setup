(
var names = ~dirt.buffers.keys.asArray.sort;
var file_path = PathName.new(thisProcess.nowExecutingPath).parentPath +/+ "tmp/sounds.txt";

File.use(file_path.standardizePath, "w", { |f|
	names.do { |name|
		f.write(format("%\n", name));
	}
})
)
