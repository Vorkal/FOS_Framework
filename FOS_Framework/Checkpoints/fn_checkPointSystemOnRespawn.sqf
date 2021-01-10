#include "..\..\settings.hpp"
if !(CHECKPOINTSYSTEM) exitWith {};

params [
	"_newUnit",
	"_oldUnit",
	"_respawn",
	"_respawnDelay"
];

//Hide body into the ground if mission maker wishes
if (HIDEBODIES) then {hidebody _oldUnit};
//Removes gear on the old unit if the mission maker wishses
if (CLEARBODIES) then {
	{_oldUnit removeItem _x} forEach (uniformItems _oldUnit + vestItems _oldUnit + backpackItems _oldUnit);
};
setPlayerRespawnTime 1e10;
