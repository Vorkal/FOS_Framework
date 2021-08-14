#include "..\settings.hpp"

if (DEBUGMESSAGESYSTEM) then {
	[] spawn FOS_fnc_debugSystemInit;
};

//Server only code
if (isServer) then {
	//debug channel
	private _channelName = "Debug Channel";
	private _channelID = radioChannelCreate [[0.96, 0.34, 0.13, 0.8], _channelName, "Debug Message:", []];
	if (_channelID == 0) exitWith {diag_log format ["Custom channel '%1' creation failed!", _channelName]};
	[_channelID, {_this radioChannelAdd [player]}] remoteExec ["call", [0, -2] select isDedicated, _channelName];
	missionNameSpace setVariable ["FOS_debugChannelID",_channelID,true];

	[AOMARKERNAME] spawn FOS_fnc_missionAOInit;
	[FOS_difficulty] spawn FOS_fnc_difficultyInit;

	if !(is3denPreview) then {
		//Run a script that protects players until the admin gives the start signal
		["init"] spawn FOS_fnc_safeStartServerInit;
		if (RESTRICTATSTART) then {
			[] spawn FOS_fnc_safeStartRestrictZone;
		};
		if (PAUSEATSTART) then {
			call FOS_fnc_pauseMissionServer;
		};
		//Init the dynamic groups menu so that players can select create their own grouping if they wish
		["Initialize"] spawn BIS_fnc_dynamicGroups;
		enableSentences false;
	} else {
		//safe start timer isn't needed for singleplayer. Set it to false.
		missionNameSpace setVariable ["FOS_Safemode",false];
		//Add zeus for all players in preview
		{_x call FOS_fnc_zeusInit} forEach allPLayers;
	};
	//Disable revive if ace detected or player wants it off in the parameters
	if (REVIVEENABLED isEqualTo 0 || isClass(configfile >> "CfgPatches" >> "ace_medical") isEqualTo true ) then {
    	if (isMultiplayer) then {(call BIS_fnc_listPlayers) call BIS_fnc_disableRevive};
	};
	if (CHECKPOINTPOINTSYSTEM) then {
		[true] call FOS_fnc_checkpointPointsSystem;
		[INITIALPOINTAMOUNT] call FOS_fnc_checkpointPointsSystem
	};
	[] spawn FOS_fnc_adminChecker;

	//Run dynamic simulation settings if requested
	if (ENABLEDYNAMICSIMULATION) then {
		enableDynamicSimulationSystem ENABLEDYNAMICSIMULATION;
		"Group" setDynamicSimulationDistance DYNAMICSIMDISTANCEINFANTRY;
		"Vehicle" setDynamicSimulationDistance DYNAMICSIMDISTANCEVEHICLE;
		"EmptyVehicle" setDynamicSimulationDistance DYNAMICSIMDISTANCEEMPTYVEHICLE;
		"Prop" setDynamicSimulationDistance DYNAMICSIMDISTANCEPROP;

		"IsMoving" setDynamicSimulationDistanceCoef DYNAMICSIMMOVEMENTCOEF;

		//Get all AI units
		_AIUnits = allUnits - (call BIS_fnc_listPlayers);
		//Add all AI units into simulation manager if requested
		if (DYNAMICSIMAUTOADDUNITS) then {
			{_x enableDynamicSimulation true} forEach _AIUnits;
		};
		if !(DYNAMICSIMCANAIWAKE) then {
			{_x triggerDynamicSimulation false} forEach _AIUnits;
		};
		//Auto gear option
		if (AUTOGEARPLAYERS) then {
			{[_x,AUTOGEARARRAY] call FOS_fnc_autogear} forEach (call BIS_fnc_listPlayers);
		};
	};
	//Friendly Kill tracker event handler
	if (FRIENDLYKILLTRACKER) then {
		{
			//Add to all players
			_x addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				//Check if the killer was friendly
				if ([side group _instigator, side group _unit] call BIS_fnc_sideIsFriendly) then {
					_admin = call FOS_fnc_getAdmin;
					_message = format ["Friendly Kill Tracker: %1 killed %2!",name _instigator,name _unit];
					if (_admin != objNull) then {
						_message remoteExec ["systemChat",_admin];
					};
				};
			}]
		} forEach (call BIS_fnc_listPlayers)
	};
	//Friendly fire tracker event handler
	if (FRIENDLYFIRETRACKER) then {
		{
			//Add to all players
			_x addEventHandler ["Hit", {
				params ["_unit", "_source", "_damage", "_instigator"];
				//Check if the _instigator was friendly
				if ([side _instigator, side _unit] call BIS_fnc_sideIsFriendly) then {
					_admin = call FOS_fnc_getAdmin;
					_message = format ["Friendly Fire Tracker: %1 attacked %2!",name _instigator,name _unit];
					if (_admin != objNull) then {
						_message remoteExec ["systemChat",_admin];
					};
				};
			}]
		} forEach (call BIS_fnc_listPlayers);
	};
	if (FIXARSENALBUG) then {
		waitUntil {time > 0};
		{_x setUnitLoadout getUnitLoadout _x} forEach allUnits;
	};
	if (MISSIONPERSISTANCE && MISSIONINDEX > 0 && MISSIONKEY != "") then {
		[] spawn FOS_fnc_loadCampaign;
	};
};

//Client only code
if (hasInterface) then {
	//Execute briefing
	[] spawn FOS_fnc_briefing;
	if (FIRETEAM) then { //FT markers requested in description.ext
		[] spawn FOS_fnc_FTMarkerInit;
	};
	[] spawn FOS_fnc_addTeleportAction;
	if (IFF) then {
		[] spawn FOS_fnc_iffInit;
	};
	if (GRPTRACKER) then {
		[] spawn FOS_fnc_grpTrackerinit;
	};


	[FOS_difficulty] spawn FOS_fnc_difficultyInit;

	if (REDUCELOOT) then {
		[player] call FOS_fnc_limitLootDrop;
	};

	if (isMultiplayer) then {
		["InitializePlayer", [player]] spawn BIS_fnc_dynamicGroups;
		[] call FOS_fnc_orbatnotes;
	};
	if (didJip) then {
		[false] spawn FOS_fnc_jipSpawn;
	};

	//Spectator on uncon

	//Player hit. Check if uncon.
	if (UNCONSCIOUSSPECTATOR) then {
		player addEventHandler ["Hit", {
			params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

			if (alive player && (player getVariable ["ace_isunconscious",false] || lifestate player isEqualTo "INCAPACITATED")) then { //Player is uncon
				//Run SPECTATOR
				[true] call FOS_fnc_SpectatorOnUnconcious;
				[] spawn {
					//Wait until not uncon to exit spectator
					waitUntil {sleep 1;alive player && (player getVariable ["ace_isunconscious",false] || lifestate player isEqualTo "INCAPACITATED") isEqualTo false};
					[false] call FOS_fnc_SpectatorOnUnconcious;
				};
			};
		}];
	};
};
