#define MISSIONKEY "TEST KEY"
#define MISSIONINDEX 0
#define PERSISTENTPLAYERGEAR false
#define SAVEARRAY []

//#include "..\..\settings.hpp"
if !(CAMPAIGNSYSTEM) exitWith {};

_campaignList = profileNameSpace getVariable ["FOS_CAMPAIGNDATA",[]];


//Delete any data where the missionKey and MissionIndex matches
_duplicateEntryIndex = _campaignList findIf {_x # 0 # 0 == MISSIONKEY && _x # 0 # 1 == MISSIONINDEX};
systemChat str _duplicateEntryIndex;
if (_duplicateEntryIndex != -1) then {
	_campaignList deleteAt _duplicateEntryIndex;
	profileNameSpace setVariable ["FOS_CAMPAIGNDATA",_campaignList];
};

//Get mission key and index
_campaignMetaData = [MISSIONKEY,MISSIONINDEX];


/*
    PLAYER LOADOUTS
*/

//get player loadouts
_playerData = [];
{
	//Find unique ID so load function can figure out player data later.
	_playerID = getPlayerUID _x;
	//Get loadout
	_loadout = getUnitLoadout [_x,true];
	//Push character data to variable.
	_playerData pushBack [_playerID,_loadout];
} forEach (call BIS_fnc_listPlayers);


/*
    OBJECT DATA
*/

//save data from SAVEARRAY
_variableData = [];
{
    //All storable data
    _variableData pushBack [
        str _x, //need stringify variable name so it doesn't become NULL
        getAllHitPointsDamage _x,
        fuel _x,
        getFuelCargo _x,
        magazinesAllTurrets _x,
        getAmmoCargo _x,
        [getWeaponcargo _x,getMagazineCargo _x,getBackpackCargo _x,getItemCargo _x],
		damage _x //Alternative damaage modifier if getAllHitPointsDamage fails
    ]
} forEach SAVEARRAY;

//update list with new campaign
_campaign = [_campaignMetaData,_playerData,_variableData];
_campaignList pushBack _campaign;

/*
    VARIABLE DATA
*/

/* TODO: Add Variable data functionlity */

//Set variable
profileNameSpace setVariable ["FOS_CAMPAIGNDATA",_campaignList];
