//[(getPos target),50,artyUnit,currentMagazine artyUnit,12,5,{true}] spawn FOS_fnc_Bombardment.sqf

params [
//Center of arty target
["_center", [0,0,0]],
//Radius of arty attack
["_radius", 50],
//Mortar unit (Needs to be the one with the artillery computer option, usually gunner)
["_unit", objnull],
// The magazine used
["_magazine", nil],
//shots fired
["_amount", 2],
//Delay between each shot. Avoid small numbers.
["_delay", 10],
//Condition
["_condition", true]
 ];

if (_unit isEqualTo objNull) exitWith {};
if (_delay < 10) then {_delay = 10};

_spotPos = [[[_center, _radius * 1.2]],[[_center, _radius]]]  call BIS_fnc_randomPos;

//How long will it take for the spotting round to hit + an added 10 seconds to simulate the spotter reporting the corrections.
_spottingTime = (vehicle _unit getArtilleryETA [(_spotPos),(_magazine)]) + 10;

 //Fire the initial spotting shot
 _unit doArtilleryFire [_spotPos, _magazine, 1];
 //Remove one shot
_amount = _amount - 1;

//Wait until the spotting round has landed and
waitUntil {
_spottingTime = (_spottingTime) - 1;
sleep 1;
(_spottingTime <= 0);
 };

while _condition do {
	// Exit loop if all rounds are fired
	if (_amount isEqualTo 0) exitWith {};
	// If there is no ammo in currect magazine, wait.
	waitUntil {_unit ammo (currentMuzzle _unit) > 0};
	// Find a random position within radius position
	_position = [[[_center, _radius]],[]]  call BIS_fnc_randomPos;
	// Fire the shot
	_unit doArtilleryFire [_position, _magazine, 1];
	// Reduce the amount fired by 1
	_amount = _amount - 1;
	// Delay before firing again
	sleep _delay;
};

