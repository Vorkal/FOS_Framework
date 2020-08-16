#include "..\..\settings.hpp"
if !(CHECKPOINTSYSTEM) exitWith {};

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

if (HIDEBODIES) then {hidebody _oldUnit};
if (CLEARBODIES) then {
	{_oldUnit removeItem _x} forEach (uniformItems _oldUnit + vestItems _oldUnit + backpackItems _oldUnit);
};
setPlayerRespawnTime 1e10;
