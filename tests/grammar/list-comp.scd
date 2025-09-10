all {: [x,y], x <- (1..5), y <- (1..x), (x+y).isPrime };

all {: [x,y], x <- (0..10), (x % 5 == 0) || x.isPowerOfTwo, y <- (1..2), (x+y).even };

all {: z, x <- (1..20), var z = (x*x-x) div: 2, z.odd };

all {: z, x <- (1..20), var z = (x*x-x) div: 2, :: [x,z].postln, z.even };

all {: z, x <- (1..20), var z = (x*x-x) div: 2,  :: [x,z].postln, :while z < 50 };
