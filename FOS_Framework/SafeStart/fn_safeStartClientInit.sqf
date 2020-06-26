params ["_mode"];

if (_mode) then {
	[true] call FOS_fnc_safeStartToggleClient;
} else {
	[false] call FOS_fnc_safeStartToggleClient;
};
