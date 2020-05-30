
waitUntil {!isNull player};


addMissionEventHandler ["EachFrame", {
	{[_x] call FOS_fnc_setFTMarker} forEach units group player;
}];

//Alt click map click handler
addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];
	if !(_alt) exitWith {};
	_nearestPlayer = [allUnits - [player], player] call BIS_fnc_nearestPosition;
	if (_nearestPlayer isEqualTo [0,0,0]) exitWith {};
	if (leader _nearestPlayer isEqualTo leader player && _nearestPlayer distance _pos < 2) then {
		_damage = linearConversion [0, 1, damage _nearestPlayer, 100, 0, false];
		_info = format ["Unit Health is: %1%.", _damage];
		systemChat _info;
	};
}];
