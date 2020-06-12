
waitUntil {!isNull player};


addMissionEventHandler ["EachFrame", {
	{[_x] call FOS_fnc_setFTMarker} forEach units group player;
}];

//Alt click map click handler
addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];
	if (!(_alt) && !(_shift)) then {
		_nearestPlayer = [allUnits - [player], player] call BIS_fnc_nearestPosition;
		//CHECK IF THIS CAUSES AN UNDEF VARIABLE
		if (_nearestPlayer isEqualTo [0,0,0] || isnil "_nearestPlayer") exitWith {[FOS_previousFTMarker setMarkerTextLocal ""};
		//Execute only if click is near a player in the same group as the local player
		if (leader _nearestPlayer isEqualTo leader player && _nearestPlayer distance _pos < 2) then {
			_FTMarker = format ["FTMrk_%1", name _nearestPlayer];
			//Remove the previous marker
			if !(isNil "FOS_previousFTMarker") then {
				FOS_previousFTMarker setMarkerTextLocal "";
			};
			//Show the name of the currently clicked unit
			_FTMarker setMarkerTextLocal name _nearestPlayer;
			missionNamespace setVariable ["FOS_previousFTMarker",_FTMarker];
		};
	};
	if (_alt) then {
		_nearestPlayer = [allUnits - [player], player] call BIS_fnc_nearestPosition;
		if (_nearestPlayer isEqualTo [0,0,0]) exitWith {};
		if (leader _nearestPlayer isEqualTo leader player && _nearestPlayer distance _pos < 2) then {
			_damage = linearConversion [0, 1, damage _nearestPlayer, 100, 0, false];
			_info = format ["Unit Health is: %1%.", _damage];
			systemChat _info;
		};
	};
}];
