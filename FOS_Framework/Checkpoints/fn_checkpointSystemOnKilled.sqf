params [
	"_oldUnit",
	"_killer",
	"_respawn",
	"_respawnDelay"
];

_saveLoadout = getUnitLoadout _oldUnit;
player setVariable ["FOS_Playerloadout",_saveLoadout,false];

_saveGroupName = group _oldUnit;
player setVariable ["FOS_PlayerGroup", _saveGroupName, false];
setPlayerRespawnTime 1e10;
