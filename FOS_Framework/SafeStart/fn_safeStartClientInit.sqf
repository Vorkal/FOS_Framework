params ["_mode"];

#include "..\..\settings.hpp"
if !(SAFESTART) exitWith {};

if (_mode) then {
	[true] call FOS_fnc_safeStartToggleClient;
} else {
	[false] call FOS_fnc_safeStartToggleClient;
};
