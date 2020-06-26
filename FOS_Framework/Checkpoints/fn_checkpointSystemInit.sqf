#include "..\..\settings.hpp"


if !(CHECKPOINTSYSTEM) exitWith {};

_saveInitLoadout = getUnitLoadout player;
player setVariable ["FOS_InitPlayerloadout",_saveInitLoadout,false];

//Sets up Checkpoint system saving
player addEventHandler ["killed", {
	_saveLoadout = getUnitLoadout (_this select 0);
	player setVariable ["FOS_Playerloadout",_saveLoadout,false];

	_saveGroupName = group (_this select 0);
	player setVariable ["FOS_PlayerGroup", _saveGroupName, false];
	setPlayerRespawnTime 1e10;

}];

if (isServer) then {
	[true] call FOS_fnc_checkpointPointsSystem;
};

"FOS: Checkpoint system initialized" call FOS_fnc_debugSystemAdd;
