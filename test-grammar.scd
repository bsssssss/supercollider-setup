(
x = { |arg1, arg2| 
	arg1.do {
		postln("hello" + (arg2 ?? ""));
	}
};

x.(arg1: 10);
)
