params [["_unit",player]];

//Declare unit healthy
_unit setVariable ["FOS_MedicalState","HEALTHY",true];
{["unconscious",false] call FOS_fnc_medicalPPEffects} forEach ["DOWN","INCAPACITATED","UNCONSCIOUS"];
_unit setUnconscious false;

if (vehicle _unit != _unit) then {moveOut _unit};

showHud true;
_unit setCaptive false;

_unit setDamage 0;
