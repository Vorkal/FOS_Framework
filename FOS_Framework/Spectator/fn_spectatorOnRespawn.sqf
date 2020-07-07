#include "..\..\settings.hpp"
if !(SPECTATOR) exitWith {};
params ["_unit", "_corpse"];
["Terminate"] call BIS_fnc_EGSpectator;
hideBody _corpse;
