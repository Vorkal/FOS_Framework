params [
	["_pos",[0,0,0],[[1,2,3],objNull],[3]],
	["_side",east,[sideEmpty]],
	["_groupDetails",["B_G_Soldier_TL_F","B_G_Soldier_AR_F","B_G_Soldier_GL_F","B_G_Soldier_LAT_F"]],
	["_amount",[1,1],[1,1],[2]]
];

_group = [_pos, _side, _groupDetails,[],[],[],[],_amount] call BIS_fnc_spawnGroup;
[_group, _pos] call BIS_fnc_taskDefend;