params [
	["_pos",[0,0,0],[[1,2,3],objNull],[3]],
	["_side",east,[sideEmpty]],
	["_groupDetails",["B_G_Soldier_TL_F","B_G_Soldier_AR_F","B_G_Soldier_GL_F","B_G_Soldier_LAT_F"]],
	["_amount",[1,1],[1,1],[2]]
];

if !(isServer) exitWith {};
if (_pos isEqualTo objNull) exitWith {};

_group = [_pos, _side, _groupDetails,[],[],[],[],_amount] call BIS_fnc_spawnGroup;
_building = nearestObject [_pos,"Building"];


_garrisonList = [_building] call BIS_fnc_buildingPositions;

{
	_garrisonPos = selectRandom _garrisonList;
	_garrisonList deleteAt (_garrisonList find _garrisonPos);
	_x setPosATL _garrisonPos;
	_x disableAI "PATH";
	_x setUnitPos selectRandom ["UP","MIDDLE"];
	_x setDir (_building getDir _x);
} forEach units _group;