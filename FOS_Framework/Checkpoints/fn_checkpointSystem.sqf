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
 *  STRING = Spawn unit on object with given name
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
 * _reviveDowned(BOOLEAN): - revive uncon units
 * 	TRUE = Downed units get back up
 *  FALSE = Downed units stay down
 *
 * Example(s):
 * 	[true,"INIT",3] call FOS_fnc_checkpointSystem // Spawn dead players back to their leader with their starting gear. with 3 second spawn protection
 *	[true,"SAVED",0] call FOS_fnc_checkpointSystem // Spawn dead players back to their leader with their gear on death. No spawn protection
 *
 */



params [
    ["_spawn",true,[true,objNull,"name",[1,2,3]]],
    ["_Gear","",["default"]],
    ["_Protection",3,[417]],
    ["_reviveDowned",false,[false]]
];

private ["_movein"];

//Exit the script if player alive or down in revive mode
if (player getVariable "BIS_revive_incapacitated" || alive player) exitWith {};
//See what the previous group was for this user
_playerGroup = player getVariable ["FOS_PlayerGroup",group player];
//Store the dead body pos
_oldPos = getPos player;

//Wait until player is leader or leader is alive
waitUntil {sleep 1; alive leader _playerGroup || leader _playerGroup == player};

//Spawn player
setPlayerRespawnTime 0;
//Wait for player to be alive
waitUntil {alive player};
//Reset timer
setPlayerRespawnTime 1e10;

//Do not perform anything if _spawn is false
if !(_spawn) exitWith {};

switch (typename _spawn) do {
    case ("BOOL"): {
        //Check if player is leader of his group
        _isLeader = leader player == player;
        _spawnGroup = _playerGroup;
        //If player is leader then change the spawn group
        if (_isLeader) then {
            _friendlyPlayers = allGroups select {[side group player, side _x] call BIS_fnc_sideIsFriendly && isPlayer leader _x};
            _distances = _friendlyPlayers apply {leader _x distance _oldPos};
            _spawnGroup = _friendlyPlayers select (_distances find (selectmin _distances));
        };
        //Put player in the vehicle of the spawn group if they are in a vehicle
        _movein = player moveInAny vehicle leader _spawnGroup;
        //if the player couldn't fit.
        if !(_moveIn) then {
            //Find if the player can fit in ANY vehicle the spawn group owns
            {_moveIn = player moveInAny vehicle _x; if (_moveIn) exitWith {true}} forEach units _spawnGroup;
            //If the player is still not in a vehicle then spawn near a group infantry unit
            {if (_x == vehicle _x && _moveIn isEqualTo false && player == vehicle player) then {player setPos getPos _x; _moveIn = true}} forEach units _spawnGroup;
            //If _moveIn is still false then spawn in a safe pos around the vehicles
            if !(_moveIn) then {
                //Create spawn safe spawn locations
                _whitelist = [];
                _blacklist = [];
                {_whiteList pushBackUnique [_x,25]; _blacklist pushBackUnique [_x,15]} foreach units _spawnGroup;
                //Spawn in random safe pos
                _randomPos = [[_whiteList],[_blacklist]] call BIS_fnc_randomPos;
                if !(_randomPos isEqualTo [0,0]) then {
                    //Set player to random position determined by vehicle proximity
                    player setPos _randomPos;
                    } else {
                    //if the player SOMEHOW still can't find a place to spawn then just spawn behind leader vehicle
                    player setPos (vehicle leader _spawnGroup getRelPos [15,230]);
                };
            };
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
    case ("STRING"): {
        _spawn = allPlayers select (allPlayers findIf {name _x == _spawn});
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
