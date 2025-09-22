/* dualshock4 vendor and product ID: 1356, 2508
*/
(
s.waitForBoot {
	Gamepad(1356, 2508);
}
)

(
~ds4 = Gamepad(1356, 2508);
~ds4.connect;
)

(
~ds3 = Gamepad(1000, 2508);
~ds3.connect;
)
