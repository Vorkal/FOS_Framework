/*
	Author: 417

	Description:
		Find the admin in the mission Only works on server.

	Returns:
		obj of current admin. objNull if no admin was found.
*/

private ["_admin"];
if !(isServer) exitWith {};


if (isMultiplayer) then {
	//Check which unit is returned as admin
	_adminIndex = (call BIS_fnc_listPlayers) findIf {admin owner _x > 0};
	//TODO: Is this redundant?
	if (_adminIndex == -1) then {
		if !(isDedicated) then {_admin = player};
	};
	if (_adminIndex != -1) then {
		//Admin found, select admin in list of players
		_admin = (call BIS_fnc_listPlayers) # _adminIndex
	} else {
		//Admin not found, return objNull
		_admin = objNull;
		//Admin not found, check if a listen server. If listen server then _admin is player.
		if !(isDedicated) then {_admin = player};
	};
} else {
	//Not multiplayer, _admin will always be player
	_admin = player;
};

_admin
