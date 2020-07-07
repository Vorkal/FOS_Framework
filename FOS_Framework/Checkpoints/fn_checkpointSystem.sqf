/*
 * Name:	CheckpointSystem
 * Date:	07/04/2020
 * Version: 2.0
 * Author:  417
 *
 * Description:
 * Checkpoint Respawn system that allows the mission maker to specify certain events that will trigger when a player can spawn back or not.
 *
 *
 * Parameter(s):
 * _SpawnOnTeam (BOOLEAN/OBJECT/ARRAY/STRING): - Will accept object location or array of objects as spawn point.
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
 *
 * Example(s):
 * 	[true,"INIT",3] spawn FOS_fnc_checkpointSystem // Spawn dead players back to their leader with their starting gear. with 3 second spawn protection
 *	[true,"SAVED",0] spawn FOS_fnc_checkpointSystem // Spawn dead players back to their leader with their gear on death. No spawn protection
 *
 */



params [
    ["_spawn",true,[true,objNull,[1,2,3]]],
    ["_Gear","",["default"]],
    ["_Protection",5,[417]],
    ["_reviveDowned",false,[false]]
];

private ["_movein"];

//Exit the script if player alive or down in revive mode
if (alive player || player getVariable ["BIS_revive_incapacitated",false]) exitWith {};
//See what the previous group was for this user
_playerGroup = player getVariable ["FOS_PlayerGroup",group player];
//Store the dead body pos
_oldPos = getPos player;

//Delay subordinate spawn time
if (leader _playerGroup != player && !(alive leader _playerGroup)) then {
    _time = time;
    //Wait 1 second OR until leader comes back to life
    waitUntil {alive leader _playerGroup || time > _time + 1};
};

//Spawn player
setPlayerRespawnTime 0;
//Wait for player to be alive
waitUntil {alive player};
//Reset timer
setPlayerRespawnTime 1e10;

//Do not perform anything if _spawn is false
if (_spawn isEqualTo false) exitWith {};

switch (typename _spawn) do {
    case ("BOOL"): {
        //Check if player is leader of his group
        _isLeader = leader player == player;
        _spawnGroup = _playerGroup;
        //If player is leader and all members are dead then change the spawn group
        if (_isLeader && {alive _x} count units _spawnGroup == 0) then {
            _friendlyPlayers = allGroups select {[side group player, side _x] call BIS_fnc_sideIsFriendly && isPlayer leader _x && leader _x != player};
            if (count _friendlyPlayers > 0) then {
                _distances = _friendlyPlayers apply {leader _x distance _oldPos};
                _spawnGroup = _friendlyPlayers select (_distances find (selectmin _distances));
            };
        };
        //If leader is in a vehicle then try to add them to their vehicle or other group owned vehicles
        if (leader _spawnGroup != vehicle leader _spawnGroup) then {
            //Put player in the vehicle of the spawn group if they are in a vehicle
            _movein = player moveInAny vehicle leader _spawnGroup;
            //if the player couldn't fit.
            if !(_moveIn) then {
                //Find if the player can fit in ANY vehicle the spawn group owns
                {_moveIn = player moveInAny vehicle _x; if (_moveIn) exitWith {true}} forEach units _spawnGroup;
                //If the player is still not in a vehicle then spawn near a group infantry unit
                {if (_x == vehicle _x && _moveIn isEqualTo false && player == vehicle player && _x != player) then {player setPos getPos _x; _moveIn = true}} forEach units _spawnGroup;
                //If _moveIn is still false then spawn in a safe pos around the vehicles
                if !(_moveIn) then {
                    //Create spawn safe spawn locations
                    _whitelist = [];
                    _blacklist = [];
                    {_whiteList pushBackUnique [getPos _x,25]; _blacklist pushBackUnique [getPos _x,15]} foreach units _spawnGroup;
                    //Spawn in random safe pos
                    _randomPos = [_whiteList,_blacklist] call BIS_fnc_randomPos;
                    if !(_randomPos isEqualTo [0,0]) then {
                        //Set player to random position determined by vehicle proximity
                        player setPos _randomPos;
                        } else {
                        //if the player SOMEHOW still can't find a place to spawn then just spawn behind leader vehicle
                        player setPos (vehicle leader _spawnGroup getRelPos [15,230]);
                    };
                };
            };
        } else {
            //If leader is alive of spawn group then spawn on them.
            if (alive leader _spawnGroup && leader _spawnGroup != player) then {
                player setPosATL (vehicle leader _spawnGroup getRelPos [2.5,180]);
            } else {
                _spawnUnit = selectRandom ((units _spawnGroup) select {alive _x});

                if (_spawnUnit == vehicle _spawnUnit) then {
                //If the leader is dead then choose a random living unit
                player setPosATL (_spawnUnit getRelPos [2.5,180]);
                } else {
                    _moveIn = player moveInAny vehicle _spawnUnit;
                    if !(_moveIn) then {player setPos (vehicle _spawnUnit getRelPos [15,230])};
                };
            }
        };
    };
    case ("OBJECT"): {
        //if _spawn is an static object then just spawn on top of it
        if (_spawn isKindOf "Static") then {
			player setposATL getposATL _spawn
		} else {
            //If spawn is not in a vehicle then spawn 3 meters behind them
			if (vehicle _spawn == _spawn) then {
				player setpos (_spawn getRelPos [3,180]);
			} else {
                // If player can fit in vehicle with _spawn then spawn in it
                _moveIn = player moveInAny (vehicle _spawn);
                if (_moveIn) then {
                    // If player can not fit in vehicle with _spawn then spawn outside it
                    player setPos (_spawn getRelPos [10,180]);
				};
            };
        };
    };
    case ("ARRAY"): {
        _randomspawn = selectRandom _spawn;
        //Find out if "randomSpawn" is actually cordinates
        if ({_x isEqualType 0} count _spawn == 3) then {_randomSpawn = _spawn};
        if (_randomspawn isEqualType objNull) then {
            //if _spawn is an static object then just spawn on top of it
            if (_randomspawn isKindOf "Static") then {
    			player setposATL getposATL _randomspawn
    		} else {
                //If spawn is not in a vehicle then spawn 3 meters behind them
    			if (vehicle _randomspawn == _randomspawn) then {
    				player setpos (_randomspawn getRelPos [3,180]);
    			} else {
                    // If player can fit in vehicle with _spawn then spawn in it
                    _moveIn = player moveInAny (vehicle _randomspawn);
                    if (_moveIn) then {
                        // If player can not fit in vehicle with _spawn then spawn outside it
                        player setPos (_randomspawn getRelPos [10,180]);
    				};
                };
            };
        } else {
            player setposATL _randomspawn
        };
    };
};
switch (toUpper _gear) do {
    case ("INIT"): {
        player setUnitLoadout (Player getVariable "FOS_InitPlayerLoadout");
    };
    case ("SAVED"): {
        player setUnitLoadout (Player getVariable "FOS_PlayerLoadout");
    };
};

if (_Protection > 0) then {
    sleep 0.01;
    player allowDamage false;
    sleep _Protection;
    player allowDamage true
};
