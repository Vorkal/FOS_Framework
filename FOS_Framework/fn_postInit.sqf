if (isServer) then {
	[] spawn FOS_fnc_missionAOInit;
	[] spawn FOS_fnc_checkpointSystemInit;
	[1] spawn FOS_fnc_difficultyInit;
	if (isMultiplayer) then {
		["init"] spawn FOS_fnc_safeStartServerInit;
		["Initialize"] spawn BIS_fnc_dynamicGroups;
		enableSentences false;
	};
	if (["revivesystem",true] call FOS_fnc_getParamValue) then {
    	call BIS_fnc_reviveInit;
	};
};


if (hasInterface) then {
	[] spawn FOS_fnc_briefing;
	[] spawn FOS_fnc_spectatorInit;
	[] spawn FOS_fnc_FTMarkerInit;
	if (["groupMarkers",true]) then {
		{[_x,nil,5] spawn FOS_fnc_grpTrackerinit} forEach BIS_fnc_listPlayers;
	};
	[1] spawn FOS_fnc_difficultyInit;


	if (isMultiplayer) then {
		[true] spawn FOS_fnc_safeStartClientInit;
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
