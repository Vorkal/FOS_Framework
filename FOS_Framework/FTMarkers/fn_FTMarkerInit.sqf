
#include "..\..\settings.hpp"
if !(FTMARKERS) exitWith {};
//Make sure player exists
waitUntil {!isNull player};
//all units in player's group
_initUnits = units group player;

//Continously draw FT Markers
addMissionEventHandler ["EachFrame", {
	_units = [];
	if (DRAWPLAYER) then {_units pushBack player};
	if (DRAWTEAM) then {{_units pushBack _x} forEach units group player - [player]};
	{[_x] call FOS_fnc_setFTMarker} forEach _units;
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
			if ("handgrenade" in toLower _magazine || "minigrenade" in toLower _magazine) then {
				[_unit,_projectile] spawn {
					params ["_unit","_projectile"];
					_mrk = createMarkerLocal [name _unit + str _projectile + str random 999, getPos _projectile];
					_mrk setMarkerType "Loc_SmallTree";
					_mrk setMarkerSizeLocal [1.25,1.25];
					_mrk setMarkerColorLocal "colorRed";
					while {_projectile != objNull} do {
						_mrk setMarkerPosLocal getpos _projectile;
					};
					deleteMarker _mrk;
				};
			};

		}];
		_x addEventHandler ["Hit", {
			params ["_unit", "_source", "_damage", "_instigator"];
			_FTMarker_Shadow = format ["FTMrk_%1_Shadow", name _unit];
			_FTMarker_Shadow spawn {
				_this setMarkerColor "colorRed";
				sleep 0.1;
				_this setMarkerColor "colorBlack";
			};
		}];
		if (DEATHMARKER) then {
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
		};
		if (DELETEONDEATH) then {
			_x addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				_mrk = format ["FTMrk_%1", name _unit];
				_mrk_Shadow = format ["FTMrk_%1_Shadow", name _unit];
				deleteMarker _mrk;
				deleteMarker _mrk_Shadow;
			}];
		};
	} forEach _units;
};

[units group player] call _ftEventHandlers;

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
		[_newUnits] call _ftEventHandlers;
		_initUnits = (units group player);
	};
};

//Todo: this needs to be tied to an event handler
[] spawn {
	//Force exit if mission maker chose to use death markers
	if !(DEATHMARKER) exitWith {};
    while {sleep 1; true} do {
        _FTMarkers = allMapMarkers;
        //Filter array down to FTMARKER specific markers
        _FTMarkers = _FTMarkers select {"FTMrk_" in _x};
        //Delete any markers that doesn't match a unit name
        {
            _marker = _x;
            _index = (units group player) findIf {name _x in _marker};
            if (_index == -1) then {deletemarker _marker};
        } forEach _FTMarkers;
    };
};
