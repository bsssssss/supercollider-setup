Server.program = "scsynth";
s.options.hardwareBufferSize = 128;

if (\SCNvim.asClass.notNil) {
    Server.default.doWhenBooted {
        \SCNvim.asClass.updateStatusLine(1, \SCNvim.asClass.port);
    }
};
