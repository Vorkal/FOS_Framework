#include "..\settings.hpp"

[] spawn FOS_fnc_debugSystemInit;

if (isServer) then {
	[AOMARKERNAME] spawn FOS_fnc_missionAOInit;
	[FOS_difficulty] spawn FOS_fnc_difficultyInit;
	if (isMultiplayer) then {
		//Run a script that protects players until the admin gives the start signal
		["init"] spawn FOS_fnc_safeStartServerInit;
		//Init the dynamic groups menu so that players can select create their own grouping if they wish
		["Initialize"] spawn BIS_fnc_dynamicGroups;
		enableSentences false;
	} else {
		//safe start timer isn't needed for singleplayer. Set it to false.
		FOS_Safemode = false
	};
	if (["revivesystem"] call FOS_fnc_getParamValue isEqualTo 0 || isClass(configfile >> "CfgPatches" >> "ace_medical") isEqualTo true ) then {
    	if (isMultiplayer) then {(call BIS_fnc_listPlayers) call BIS_fnc_disableRevive};
	};
};

if (hasInterface) then {
	[] spawn FOS_fnc_briefing;
	if (["ftMarkers"] call FOS_fnc_getParamValue isEqualTo 1) then {
		[] spawn FOS_fnc_FTMarkerInit;
	};
	[] spawn FOS_fnc_iffInit;
	[] spawn FOS_fnc_nametagInit;
	if (["groupMarkers"] call FOS_fnc_getParamValue isEqualTo 1) then {
		[] spawn FOS_fnc_grpTrackerinit;
	};
	[FOS_difficulty] spawn FOS_fnc_difficultyInit;

	if (REDUCELOOT) then {
		[player] call FOS_fnc_limitLootDrop;
	};
	if (isMultiplayer) then {
		["InitializePlayer", [player]] spawn BIS_fnc_dynamicGroups;
	};

	if (_this # 1) then {
		createDialog "FOS_JipMenu";
		{
			_index = lbAdd [1500, (format ["%1",name _x])];
			lbSetData [1500, _index,(format ["%1", _x])];
		} foreach playableUnits;
	};
};
