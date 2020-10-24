#include "..\settings.hpp"

[] spawn FOS_fnc_debugSystemInit;

//Server only code
if (isServer) then {
	[AOMARKERNAME] spawn FOS_fnc_missionAOInit;
	[FOS_difficulty] spawn FOS_fnc_difficultyInit;

	if (isMultiplayer) then {
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
		FOS_Safemode = false
	};
	//Disable revive if ace detected or player wants it off in the parameters
	if (["revivesystem"] call FOS_fnc_getParamValue isEqualTo 0 || isClass(configfile >> "CfgPatches" >> "ace_medical") isEqualTo true ) then {
    	if (isMultiplayer) then {(call BIS_fnc_listPlayers) call BIS_fnc_disableRevive};
	};
	if (CHECKPOINTPOINTSYSTEM) then {
		[true] call FOS_fnc_checkpointPointsSystem;
		[INITIALPOINTAMOUNT] call FOS_fnc_checkpointPointsSystem
	};
	[] spawn FOS_fnc_adminChecker;

	//Run dynamic simulation settings if requested
	if (isServer && ENABLEDYNAMICSIMULATION) then {
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
	};
	if (FIXARSENALBUG) then {
		waitUntil {time > 0};
		{_x setUnitLoadout getUnitLoadout _x} forEach allUnits;
	};
};

//Client only code
if (hasInterface) then {
	//Execute briefing
	[] spawn FOS_fnc_briefing;
	if (CHECKPOINTPOINTSYSTEM) then {
		[true] call FOS_fnc_checkpointPointsSystem;
	};
	//create fire team markers if requested on in the parameters
	if (["ftMarkers"] call FOS_fnc_getParamValue isEqualTo 1) then {
		[] spawn FOS_fnc_FTMarkerInit;
	};
	[] spawn FOS_fnc_addTeleportAction;
	//add nametags
	[] spawn FOS_fnc_iffInit;
	[] spawn FOS_fnc_nametagInit;
	//Create group trackers if requested on in the parameters
	if (["groupMarkers"] call FOS_fnc_getParamValue isEqualTo 1) then {
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

	if (_this # 1) then {
		createDialog "FOS_JipMenu";
		{
			_index = lbAdd [1500, (format ["%1",name _x])];
			lbSetData [1500, _index,(format ["%1", _x])];
		} foreach playableUnits;
	};
};
