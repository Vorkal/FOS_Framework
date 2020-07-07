params [
	"_newUnit",
	"_oldUnit",
	"_respawn",
	"_respawnDelay"
];

if (_oldUnit isEqualTo objNull) then {
    _saveInitLoadout = getUnitLoadout player;
    player setVariable ["FOS_InitPlayerloadout",_saveInitLoadout,false];
};

hidebody _oldUnit;
setPlayerRespawnTime 1e10;
