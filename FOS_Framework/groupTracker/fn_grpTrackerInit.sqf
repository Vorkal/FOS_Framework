while {true} do {
	{
		if (isPlayer leader _x && _x != group player) then {
		  [_x] call FOS_fnc_setGrpTracker;
		};
	} forEach allGroups;
	sleep 5;
};
