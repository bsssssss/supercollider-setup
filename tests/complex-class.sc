/*

This library unifies access to buffers and synth events.

valid fileExtensions can be extended, currently they are ["wav", "aif", "aiff", "aifc"]

*/


DirtSoundLibrary {
	set { |name, indices ... pairs|
		var allEvents = this.at(name);
		if(allEvents.isNil) {
			"set: no events found with this name: %\n".format(name).warn
		} {
			if(indices.notNil) { allEvents = allEvents.at(indices.asArray) };
			allEvents.do { |each|
				each.putPairs(pairs)
			}
		}
	}

	loadSoundFiles { |paths, appendToExisting = false, namingFunction = (_.basename)| // paths are folderPaths
		var folderPaths, memory;

		paths = paths ?? { "../../Dirt-Samples/*".resolveRelative };
		folderPaths = if(paths.isString) { paths.pathMatch } { paths.asArray };
		folderPaths = folderPaths.select(_.endsWith(Platform.pathSeparator.asString));
		if(folderPaths.isEmpty) {
			"no folders found in paths: '%'".format(paths).warn; ^this
		};
		memory = this.memoryFootprint;
		"\n\n% existing sample bank%:\n".postf(folderPaths.size, if(folderPaths.size > 1) { "s" } { "" });
		folderPaths.do { |folderPath|
			this.loadSoundFileFolder(folderPath, namingFunction.(folderPath), appendToExisting)
		};
		if(doNotReadYet) {
			"\n ... sample banks registered, will read files as necessary".postln;
		} {
			"\n... file reading complete. Required % MB of memory.\n\n".format(
				this.memoryFootprint - memory div: 1e6
			).post
		};
	}
}
