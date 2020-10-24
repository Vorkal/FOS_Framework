/*
Author: 417

Description: Calls in fire support on a location with an initial "spotting shell"
Once the first shell lands the AI will wait 10 seconds before sending the actual
fire support to the location.

This is intended to give a somewhat dangerous warning to the players before the
real volley rains down on their head

Parameters:
_center (POSITION): Where the fire support will be sent
_radius (SCALAR): The spread of the fire support mission
_unit (OBJECT): The gunner unit or vehicle being used for the fire support
_magazine (STRING): The magazine used in the fire support
_amount (SCALAR): How many rounds will be fired
_delay (SCALAR): Delay between each shot
_condition (CODE): Condition that will cause the unit to cease fire support if false

*/

params [
  ["_center", [0,0,0],[[0,0,0]],3],
  ["_radius", 50,[25]],
  ["_unit", objnull,[objNull]],
  ["_magazine", currentMagazine _unit,["string"]],
  ["_amount", 2,[1]],
  ["_delay", 10,[5]],
  ["_condition", true,[true,false]]
 ];

if (_unit isEqualTo objNull) exitWith {};

//Spotting shot will always land somewhere outside the actual radius given
_spotPos = [[[_center, _radius * 1.2]],[[_center, _radius]]]  call BIS_fnc_randomPos;

//How long will it take for the spotting round to hit + an added 10 seconds to simulate the spotter reporting the corrections.
_spottingTime = (vehicle _unit getArtilleryETA [(_spotPos),(_magazine)]) + 10;

 //Fire the initial spotting shot
 _unit doArtilleryFire [_spotPos, _magazine, 1];
 //Remove one shot
_amount = _amount - 1;

//Wait until the spotting round has landed
sleep _spottingTime;

while _condition do {
	// Exit loop if all rounds are fired
	if (_amount <= 0) exitWith {};
	// If there is no ammo then wait
	waitUntil {sleep 0.1; canFire _unit};
	// Find a random position within radius position
	_position = [[[_center, _radius]],[]]  call BIS_fnc_randomPos;
	// Fire the shot
	_unit doArtilleryFire [_position, _magazine, 1];
	// Reduce the amount fired by 1
	_amount = _amount - 1;
	// Delay before firing again
	sleep _delay;
};
