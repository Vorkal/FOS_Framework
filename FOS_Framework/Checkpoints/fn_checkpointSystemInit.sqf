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

[true] call FOS_fnc_checkpointPointsSystem;

if (!isMultiplayer) then {systemChat "FOS: Checkpoint system initialized";};