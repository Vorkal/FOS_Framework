/*
 * Name:	CheckPointPointsSystem
 * Date:	4/26/2019
 * Version: 1.0
 * Author:  417
 *
 * Description:
 * Intended for use with the checkpointSystem. number parameter requires running from the server. Fails silently when ran on client. Currently respawns EVERY PLAYER.
 *
 *
 * Parameter(s):
 * _var (BOOLEAN/NUMBER/STRING): - True initializes the point system. Number controls the adding or removal of points used. String is for internal use.
 *
 *
 * Example(s):
 * 	[true] call FOS_fnc_checkpointPointsSystem
 * 	[3] call FOS_fnc_checkpointPointsSystem
 */

 #include "..\..\settings.hpp"
 if !(CHECKPOINTSYSTEM) exitWith {};

params ["_var"];

//if caller put false... for some reason... exit script
if (_var isEqualTo false) exitWith {};

switch (typeName _var) do {
	case "BOOL": {
        player createDiarySubject  ["Checkpoint system","Call checkpoint"];

        player createDiaryRecord ["Checkpoint system",["Call checkpoint","
		<font color='#FF8C00'>CHECKPOINT SYSTEM</font color>
		<br/><br/>
		<font color='#ffff00'><execute expression='[""spawnsLeft""] call FOS_fnc_checkpointPointsSystem'>Amount of checkpoints left</execute></font color>.
		<br/><br/><br/><br/>
		<font color='#ADFF2F'><execute expression='[""activated""] call FOS_fnc_checkpointPointsSystem'>Activate checkpoint</execute></font color>!
		<br/><br/><br/><br/>
		Clicking the number will call a checkpoint and respawn all dead players. The one who initiated the checkpoint call will be broadcasted to the server in a hint.
		<br/><br/>
		Complete optional tasks to increase the amount of checkpoints available to call!
		"
		]];

		"Call Checkpoints briefing menu created" call FOS_fnc_debugSystemAdd
	};
	case "SCALAR": {
	if (!isServer) exitWith {};
	// Find current points
	_currentPoints = missionNameSpace getVariable ["FOS_PointsLeft",0];
	// Update points with _var
	missionNameSpace setVariable ["FOS_PointsLeft",_currentPoints + _var,true];
	};
	case "STRING": {
		if (_var isEqualTo "spawnsLeft") then {
			//Report to player points left
			_points = format ["Checkpoints left: %1",missionNameSpace getVariable ["FOS_PointsLeft",0]];
            cutText ["<t color='#FFA500' size='2.5'>" + _points + "</t><br/>", "PLAIN DOWN",0.15, true, true];
		};
		if (_var isEqualTo "activated") then {
            //Check if player is allowed to
            _permissionGranted = switch (CALLCHECKPOINTPERMISSIONS) do {
                case 0: {
                    true
                };
                case 1: {
                    if (player == leader player) then {
                        true
                    } else {
                        false
                    };
                };
                case 2: {
                    if (player == ([] call FOS_fnc_getAdmin)) then {
                        true
                    } else {
                        false
                    };
                };
            };
            if !(_permissionGranted) exitWith {hintSilent "You are not allowed to call checkpoints"};

			_currentPoints = missionNameSpace getVariable ["FOS_PointsLeft",0];
			//Stop activation of the checkpoint during briefing
			if (time isEqualTo 0) exitWith {};
			//Stop activation of the checkpoint if there are none left
			if (_currentPoints <= 0) exitWith {hintSilent "Out of checkpoints"};

			//Remove a point
			missionNameSpace setVariable ["FOS_PointsLeft",_currentPoints + -1,true];

			// Store players name
			_player = name player;

			//Broadcast the person who used the checkpoint
			if (ANNOUNCEUSER) then {
                (format ["%1 used a checkpoint point! \n %2 more points left!",_player,_currentPoints - 1]) remoteExec ["hint",0,false]
                } else {
                (format ["%1 used a checkpoint point! \n %2 more points left!",_player]) remoteExec ["hint",(call FOS_fnc_getAdmin),false]
            };
			//Respawn people
			[POINTSPAWN,POINTGEAR,POINTPROTECTION] remoteExec ["FOS_fnc_checkpointSystem",0,false];
		};
	};
};
