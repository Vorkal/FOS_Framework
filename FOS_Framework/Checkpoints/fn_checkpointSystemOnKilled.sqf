//include settinngs.hpp
#include "..\..\settings.hpp"
if !(CHECKPOINTSYSTEM) exitWith {};

params [
	"_oldUnit",
	"_killer",
	"_respawn",
	"_respawnDelay"
];
//Save player's loadout to variable
_saveLoadout = getUnitLoadout _oldUnit;
player setVariable ["FOS_Playerloadout",_saveLoadout,false];

//Save group to variable
_saveGroupName = group _oldUnit;
player setVariable ["FOS_PlayerGroup", _saveGroupName, false];
//Force infinite spawn time
setPlayerRespawnTime 1e10;
