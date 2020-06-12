
waitUntil {!isNull player};

_initUnits = units group player;

addMissionEventHandler ["EachFrame", {
	{[_x] call FOS_fnc_setFTMarker} forEach units group player;
}];

//private function that adds event handlers to units. Needed to detect when they have fired and such.
_ftEventHandlers = {
	params ["_units"];
	{
		_x addEventHandler ["FiredMan", {
			params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
			_FTMarker_Shadow = format ["FTMrk_%1_Shadow", name _unit];
			_FTMarker_Shadow spawn {
				_this setMarkerColor "colorWhite";
				sleep 0.1;
				_this setMarkerColor "colorBlack";
			};
		}];

	} forEach _units;

	{
		_x addEventHandler ["Hit", {
			params ["_unit", "_source", "_damage", "_instigator"];
			_FTMarker_Shadow = format ["FTMrk_%1_Shadow", name _unit];
			_FTMarker_Shadow spawn {
				_this setMarkerColor "colorRed";
				sleep 0.1;
				_this setMarkerColor "colorBlack";
			};
		}];
	} forEach _units;

	{
		_x addEventHandler ["Killed", {
			params ["_unit", "_killer", "_instigator", "_useEffects"];
			_mrk = format ["FTMrk_%1", name _unit];
			_mrk_Shadow = format ["FTMrk_%1_Shadow", name _unit];
			_mrk setMarkerTypeLocal "KIA";
			_mrk_Shadow setMarkerTypeLocal "KIA";
			_mrk setMarkerSizeLocal [0.75,0.75];
			_mrk_Shadow setMarkerSizeLocal [0,0];
			[_mrk,300] spawn BIS_fnc_hideMarker;
			[_mrk_Shadow,300] spawn BIS_fnc_hideMarker;
			[_mrk,_mrk_Shadow] spawn {sleep 300; {deleteMarker _x} forEach _this};
		}];
	} forEach _units
};

[units group player] call _ftEventHandlers;
//Alt click map click handler
addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];
	if (!(_alt) && !(_shift)) then {
		_nearestPlayer = [allUnits, _pos] call BIS_fnc_nearestPosition;
		//Execute only if click is near a player in the same group as the local player. Remove text from last marker if condition not satisifed
		if (leader _nearestPlayer isEqualTo leader player && _nearestPlayer distance _pos < 3) then {
			_FTMarker = format ["FTMrk_%1", name _nearestPlayer];
			//Remove the previous marker
			if !(isNil "FOS_previousFTMarker") then {
				FOS_previousFTMarker setMarkerTextLocal "";
			};
			//Show the name of the currently clicked unit
			_FTMarker setMarkerTextLocal name _nearestPlayer;
			missionNamespace setVariable ["FOS_previousFTMarker", _FTMarker];
		} else {
			FOS_previousFTMarker setMarkerTextLocal ""
		};
	};
	if (_alt) then {
		_nearestPlayer = [allUnits, _pos] call BIS_fnc_nearestPosition;
		if (_nearestPlayer isEqualTo [0,0,0]) exitWith {};
		if (leader _nearestPlayer isEqualTo leader player && _nearestPlayer distance _pos < 2) then {
			_damage = linearConversion [0, 1, damage _nearestPlayer, 100, 0, false];
			_info = format ["Unit Health is: %1%.", _damage];
			systemChat _info;
		};
	};
}];


[_initUnits,_ftEventHandlers] spawn {
	params ["_initUnits","_ftEventHandlers"];
	private ["_newUnits"];
	while {sleep 0.1; true} do {
		waitUntil {sleep 5; _newUnits = (units group player) - _initUnits; count _newUnits > 0};
		systemChat "new unit detected";
		systemChat str _newUnits;
		[_newUnits] call _ftEventHandlers;
		_initUnits = (units group player);
	};
};
