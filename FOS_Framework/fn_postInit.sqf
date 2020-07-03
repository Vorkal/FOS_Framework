[] spawn FOS_fnc_debugSystemInit;
[] spawn FOS_fnc_checkpointSystemInit;

if (isServer) then {
	[] spawn FOS_fnc_missionAOInit;
	[FOS_difficulty] spawn FOS_fnc_difficultyInit;
	if (isMultiplayer) then {
		["init"] spawn FOS_fnc_safeStartServerInit;
		["Initialize"] spawn BIS_fnc_dynamicGroups;
		enableSentences false;
	} else {
		//safe start timer isn't needed for singleplayer. Set it to false so a mission can detect when safestart is over regardless of mode
		FOS_Safemode = false
	};
	if (["revivesystem"] call FOS_fnc_getParamValue isEqualTo 0) then {
    	(call BIS_fnc_listPlayers) call BIS_fnc_disableRevive;
	};
};

if (hasInterface) then {
	[] spawn FOS_fnc_briefing;
	[] spawn FOS_fnc_spectatorInit;
	if (["ftMarkers"] call FOS_fnc_getParamValue isEqualTo 1) then {
		[] spawn FOS_fnc_FTMarkerInit;
	};
	if (["groupMarkers"] call FOS_fnc_getParamValue isEqualTo 1) then {
		//[] spawn FOS_fnc_grpTrackerinit;
	};
	[FOS_difficulty] spawn FOS_fnc_difficultyInit;


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
