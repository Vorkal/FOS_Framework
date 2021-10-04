#define MISSIONKEY "TEST KEY"
#define MISSIONINDEX 0
#define PERSISTENTPLAYERGEAR false
#define SAVEARRAY []

#include "..\..\settings.hpp"
if !(CAMPAIGNSYSTEM) exitWith {};

_campaignList = profileNameSpace getVariable ["FOS_CAMPAIGNDATA",[]];


//Delete any data where the missionKey and MissionIndex matches
_duplicateEntryIndex = _campaignList findIf {_x # 0 # 0 == MISSIONKEY && _x # 0 # 1 == MISSIONINDEX};
if (_duplicateEntryIndex != -1) then {
	"Existing campaign data at index: " + str _duplicateEntryIndex call FOS_fnc_debugSystemAdd; //Debug message
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
	"Saving" + name _x + "'s gear" call FOS_fnc_debugSystemAdd; //Debug message
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
_objectData = [];
_objectList = SAVEARRAY	select {!isNil "_x"};
_objectList = _objectList + (missionNameSpace getVariable ["FOS_CampaignObjects",[]]);
{

	if !(isNil "_x") then {
		"Saving object" + str _x call FOS_fnc_debugSystemAdd; //Debug message
		//All storable data
	    _objectData pushBack [
	        str _x, //need stringify variable name so it doesn't become NULL
	        getAllHitPointsDamage _x,
	        fuel _x,
	        getFuelCargo _x,
	        magazinesAllTurrets _x,
	        getAmmoCargo _x,
	        [getWeaponcargo _x,getMagazineCargo _x,getBackpackCargo _x,getItemCargo _x],
			damage _x //Alternative damaage modifier if getAllHitPointsDamage fails
	    ];
	} else {
		str _x + " is nil" call FOS_fnc_debugSystemAdd; //Debug message
	};
} forEach _objectList;

//update list with new campaign
_campaign = [_campaignMetaData,_playerData,_objectData];
_campaignList pushBack _campaign;

/*
    VARIABLE DATA
*/

/* TODO: Add Variable data functionlity */

"Saved campaign data" call FOS_fnc_debugSystemAdd; //Debug message

//Set variable
profileNameSpace setVariable ["FOS_CAMPAIGNDATA",_campaignList];
