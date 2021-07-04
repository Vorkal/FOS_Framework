/*
	Author: Nelson Duarte || Modified: 417

	Description:
		Set's skill for an entire AI side

	Parameters:


	Returns:
		Nothing
*/

// Server only
if (!isServer) exitWith
{
	"Function must be executed only on the server" call BIS_fnc_error;
};

// Parameters
params
[
	["_side", sideUnknown, [sideUnknown]],
	["_skillMin", 0.5, [0.0]],
	["_skillAimMin", 0.3, [0.0]],
	["_skillMax", 0.8, [0.0]],
	["_skillAimMax", 0.5, [0.0]]
];
private ["_alpha","_skill","_skillAim"];

// Validate side
if (_side == sideUnknown) exitWith
{
	"SideUnknown is not a valid side" call BIS_fnc_error;
};

// Lerp function
private _fn_lerp =
{
	params [["_a", 0.0, [0.0]], ["_b", 0.0, [0.0]], ["_alpha", 0.0, [0.0]]];
	_a + _alpha * (_b - _a);
};

_playableSlots = playableSlotsNumber west + playableSlotsNumber east + playableSlotsNumber independent + playableSlotsNumber civilian;

if (_playableSlots > 0) then {
	_alpha = count ([] call BIS_fnc_listPlayers) / _playableSlots;
} else {
	_alpha = 1;
};

_skill = [_skillMin, _skillMax, _alpha] call _fn_lerp;
_skillAim = [_skillAimMin, _skillAimMax, _alpha] call _fn_lerp;

{
	if (side _x == _side) then
	{
		_x setSkill _skill;
		_x setskill ["spotDistance", _skill];
		_x setskill ["spotTime", _skill];
		_x setskill ["general", _skill];

		_x setskill ["aimingAccuracy", _skillAim];
		_x setskill ["aimingShake", _skillAim];
		_x setskill ["aimingSpeed", _skillAim];
	};
}
forEach allUnits;

// Log
if (true) then
{
	["Skill set for side %1 - Alpha: %2 / Skill: %3 / SkillAim: %4", _side, _alpha, _skill, _skillAim] call BIS_fnc_logFormat;
};
