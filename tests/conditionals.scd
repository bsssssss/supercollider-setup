// FIXME
(
x = 1; //also try 1
switch (x, 0, { "hello" }, 1, { "goodbye" })
)

(
var x = 0; //also try 1
switch (x) 
	{ 0 } { "hello" }
	{ 1 } { "goodbye" };
)

(
var x, z;
z = [0, 1, 1.1, 1.3, 1.5, 2];
switch (z.choose.postln,
    1,   { \no },
    1.1, { \wrong },
    1.3, { \wrong },
    1.5, { \wrong },
    2,   { \wrong },
    0,   { \true }
).postln;
)

(
if (true) { "wooh".postln };
"nooo".postln;
)

(
a = 1 ! 2;
)
