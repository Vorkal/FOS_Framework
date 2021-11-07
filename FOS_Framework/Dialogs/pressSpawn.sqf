/*
 * Name:	pressSpawn
 * Date:	07/04/2021
 * Version: 2.0
 * Author:  417
 *
 * Description:
 * Moves player to their selected unit
 *
 */
private ["_didTeleport"];

// Keep the JIP unit from using themself to teleport
if (player == allPlayers select (lbCurSel 1500)) exitWith {hint "Pick someone who isn't you!"};
// Stop JIP unit from spawning on corpses
if (!alive (allPlayers select (lbCurSel 1500))) exitWith {hint "Select player is dead"};


// Place player inside selected unit's vehicle IF he is inside a vehicle.
//If the vehicle is NOT full then close the menu. Otherwise, stay open.
if ((allPlayers select (lbCurSel 1500)) != vehicle (allPlayers select (lbCurSel 1500))) then {
	_didTeleport = player moveInAny (vehicle (allPlayers select (lbCurSel 1500)));
		if (_didTeleport isEqualTo false) exitwith {hint "Chosen player's vehicle is full!"};
		CloseDialog 2;
};



// Place player behind selected unit IF he is outside a vehicle
if ((allPlayers select (lbCurSel 1500)) == vehicle (allPlayers select (lbCurSel 1500))) then {
	player setpos ((allPlayers select (lbCurSel 1500)) modelToWorld [0,-1,0]);
	CloseDialog 2;
};
