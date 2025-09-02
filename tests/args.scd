(
{ arg ...args; };
)

(
{ | arg0, arg1 ...rest | };
)

(
a = { | arg1 = (_.cubed) | arg1.postln };
a.();
)

(
{ | arg1 = ((0..2)) | };
)

(
{ | arg0(_.cubed) | };
)

(
{ | ...args, arg2 | };
)
