/*
 * Name:	CheckpointSystem
 * Date:	5/14/2019
 * Version: 1.8
 * Author:  417
 *
 * Description:
 * Checkpoint Respawn system that allows the mission maker to specify certain events that will trigger when a player can spawn back or not.
 *
 *
 * Parameter(s):
 * _SpawnOnTeam (BOOLEAN/OBJECT/ARRAY): - Will accept object location or array of objects as spawn point.
 *  TRUE = Spawn on original group
 *  FALSE = Spawn unit in whatever default way is given.
 *  OBJECT = Spawn unit on object given
 *  ARRAY (object) = Selects a random object in the array and spawns the player there. All players get their own random spawn.
 *
 * _Gear (STRING): - Gear spawn type.
 *	"" = No changes to respawn loadout.
 *	"SAVED" = Respawn with the gear you died with.
 *	"INIT" = Respawn with the gear you started the mission in.
 *
 * _Protection(SCALAR): - Spawn protection?
 * 	Number = Decides how long spawn protection lasts
 *
 * Example(s):
 * 	[true,"INIT",3] spawn FOS_fnc_checkpointSystem // Spawn dead players back to their leader with their starting gear. with 3 second spawn protection
 *	[true,"SAVED",0] spawn FOS_fnc_checkpointSystem // Spawn dead players back to their leader with their gear on death. No spawn protection
 *
 */
scriptName "CheckpointSystem";

params ["_spawn", "_Gear","_Protection"];
private ["_SpawnLocation", "_canTeleport","_randomspawn"];

//Exit the script if player alive or down in revive mode
if (player getVariable "BIS_revive_incapacitated" isEqualTo true) exitWith {};
if (alive player) exitWith {};

_playerGroup = player getVariable ["FOS_PlayerGroup",grpNull];

//Check if FOS_playerGroup has living members
/*if ({alive _x} count units _playerGroup isEqualTo 0) then {
	//define array
	_friendlyGroups = [];
	//Store all groups of the same side into an array
	{
		//If group is same side as player and is a playable unit then add to array
		if (side _x isEqualTo side _playerGroup && leader _x in playableUnits) then {
			_friendlyGroups pushBackUnique _x
		};
	} forEach allGroups;
	//Select random group to be new player group.
	_playerGroup = selectRandom _friendlyGroups;
};*/

//If the player is not a squad lead, wait a moment.
if (player != leader player) then {
	sleep 1;
};
//Spawn player
setPlayerRespawnTime 0;
//Wait for player to be alive
waitUntil {alive player};
//Reset timer
setPlayerRespawnTime 1e10;
//Rejoin old group silently without taking group lead
//player joinAsSilent [_playerGroup,2];


//if _spawn exist
if (isnil "_spawn") then {
} else {
		//if _spawn is BOOL
		if (typename _spawn == "BOOL") then {
		_canTeleport = player moveInAny vehicle leader _playerGroup;
		};
		//if _spawn is NOT an array
		if (typename _spawn == "OBJECT") then {
			_SpawnLocation = getpos _spawn;
			_canTeleport = player moveInAny vehicle _spawn;
		};
		//if _spawn IS an array
		if (typename _spawn == "ARRAY") then {
			_randomspawn = selectRandom _spawn;
			_canTeleport = player moveInAny vehicle _randomspawn;
			_SpawnLocation = getpos _randomspawn;
		};

	if (_spawn isequalto true) then {
		if (vehicle leader _playerGroup == leader _playerGroup) then {
			// If player is leader of his group
			if (player == leader _playerGroup) then {
				_friendlyGroups = [];
				//Store all groups of the same side into an array
				{
					//If group is same side as player and is a playable unit then add to array
					if (side _x isEqualTo side _playerGroup && leader _x in playableUnits && _x != _playergroup) then {
						_friendlyGroups pushBackUnique _x
					};
				} forEach allGroups;

				//Move dead leader to a nearby friendly leader if group is dead else just choose a friendly squad mate
				if ({alive _x && _x != player} count units _playerGroup isEqualTo 0) then {
					player setposATL getposATL leader (selectRandom _friendlyGroups);
				} else {
					player setposATL getposATL selectRandom (units _playerGroup)
				};
			} else {
				//Non-leader units just spawn on leaders.
				player setposATL getposATL leader _playerGroup;
			};
		};
		//spawn is in a vehicle and player can fit
		if (vehicle leader _playerGroup != leader _playerGroup && _canTeleport isEqualTo true) then {
			player moveInAny (vehicle leader _playerGroup);
		};
		//Spawn is in a vehicle and the player can NOT fit
		if (vehicle leader _playerGroup != leader _playerGroup && _canTeleport isEqualTo false) then {
			player setPos [(leader _playerGroup select 0) -10, (leader _playerGroup select 1) - 10,0]
		};
	};
	//If _spawn is an object then spawn on object
	if (typename _spawn == "OBJECT") then {
		//if object is a prop
		if (_spawn isKindOf "Static") then {
			player setposATL getposATL _spawn
		};
		//if object is a man
		if (_spawn isKindOf "Man") then {
			//If spawn is not in a vehicle then spawn 3 meters behind them
			if (vehicle _spawn == _spawn) then {
				player setposATL [(_SpawnLocation select 0), (_SpawnLocation select 1) - 3,0];
			};
			//If spawn is in a vehicle then spawn in their vehicle
			if (vehicle _spawn != _spawn) then {
				// If player can fit in vehicle with _spawn then spawn in it
				if (_canTeleport isEqualTo True) then {
					player moveInAny (vehicle _spawn);
				};
				// If player can not fit in vehicle with _spawn then spawn outside it
				if (_canTeleport isEqualTo False) then {
					player setPos [( _SpawnLocation select 0) -10, (_SpawnLocation select 1) - 10,0];
				};
			};
		};
		if (_spawn isKindOf "AllVehicles" isEqualTo true && _spawn isKindOf "Man" isEqualTo false) then {
			// If player can fit in _spawn then spawn inside it
			if (_canTeleport isEqualTo true) then {
				player moveInAny (vehicle _spawn)
			};
			// If player can not fit in _spawn then spawn outside it
			if (_canTeleport isEqualTo False) then {
				player setPos [(_SpawnLocation select 0) -10, (_SpawnLocation select 1) - 10,0];
			};
		};
	};
	//If _spawn is an array then select random spawn and use it.
	if (typename _spawn == "ARRAY") then {
			//if object is a prop
		if (_randomspawn isKindOf "Static") then {
			player setposATL getposATL _randomspawn
		};
		//if object is a man
		if (_randomspawn isKindOf "Man") then {
			//If spawn is not in a vehicle then spawn 3 meters behind them
			if (vehicle _randomspawn == _randomspawn) then {
				player setposATL [(_SpawnLocation select 0), (_SpawnLocation select 1) - 3,0];
			};
			//If spawn is in a vehicle then spawn in their vehicle
			if (vehicle _randomspawn != _randomspawn) then {
				// If player can fit in vehicle with _spawn then spawn in it
				if (_CanTeleport isEqualTo True) then {
					player moveInAny (vehicle _randomspawn);
				};
				// If player can not fit in vehicle with _spawn then spawn outside it
				if (_CanTeleport isEqualTo False) then {
					player setPos [( _SpawnLocation select 0) -10, (_SpawnLocation select 1) - 10,0];
				};
			};
		};
		//if spawnpoint is a vehicle of somekind AND is also not a unit
		if (_randomspawn isKindOf "AllVehicles" isEqualTo true && _randomspawn isKindOf "Man" isEqualTo false) then {
			// If player can fit in _spawn then spawn inside it
			if (_CanTeleport isEqualTo true) then {
				player moveInAny (vehicle _randomspawn)
			};
			// If player can not fit in _spawn then spawn outside it
			if (_CanTeleport isEqualTo False) then {
				player setPos [(_SpawnLocation select 0) -10, (_SpawnLocation select 1) - 10,0];
			};
		};
	};
};
//if _gear exists before attempting to alter gear
if (isnil "_Gear") then {
} else {
	if (typename _Gear == "STRING") then {
		//If _gear is omitted then do nothing
		if (_Gear isequalto "") then {
		};
		//If _gear is "SAVED" then grab the loadout they had on death
		if (_Gear isequalto "SAVED") then {
			player setUnitLoadout (Player getVariable "FOS_PlayerLoadout");
		};
		//If _gear is "INIT" then grab the loadout they had on respawn
		if (_Gear isequalto "INIT") then {
				player setUnitLoadout (Player getVariable "FOS_InitPlayerLoadout");
		};
	} else {
		diag_log text "CheckPoint System: _gear parameter was not a STRING";
	};
};
//if _protection exist
if (isnil "_Protection") then {
} else {
		if (typeName _Protection isEqualTo "SCALAR") then {
			if (_Protection > 0) then {
				sleep 0.01;
				player allowDamage false;
				sleep _Protection;
				player allowDamage true
			};
	} else {
		diag_log text "Checkpoint System: _Protection parameter was not a SCALAR";
	};
};