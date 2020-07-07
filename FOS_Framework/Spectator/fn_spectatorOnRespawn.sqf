#include "..\..\settings.hpp"
if !(SPECTATOR) exitWith {};

player addEventHandler ["respawn",{
	params ["_unit", "_corpse"];
	["Terminate"] call BIS_fnc_EGSpectator;
	hideBody _corpse;
}];
