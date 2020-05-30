/*
	Author: 417

	Description:
		Find the admin in the mission

	Returns:
		obj of current admin. objNull if no admin was found.
*/

private ["_admin"];

if (isMultiplayer) then {
	_adminIndex = (call BIS_fnc_listPlayers) findIf {admin owner _x > 0};
	if (_adminIndex != -1) then {_admin = (call BIS_fnc_listPlayers) # _adminIndex} else {_admin = objNull};
} else {
	_admin = player;
};

_admin