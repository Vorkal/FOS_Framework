params ["_unit"];

if !(_unit isEqualTo player) exitWith {};

//Play PP effects for player
["INCAPACITATED",true] call FOS_fnc_medicalPPEffects;

//Start ragdoll
_unit setCaptive true;
_unit setUnconscious true;

//Wait until player rolls over
waitUntil {animationState _unit isEqualTo "unconsciousrevivedefault"};

while {_unit getVariable ["FOS_MedicalState","HEALTHY"] isEqualTo "INCAPACITATED"} do {

};


//Unconscious state exited
waitUntil {animationState _unit isNotEqualTo "unconsciousoutprone" || _unit getVariable ["FOS_MedicalState","HEALTHY"] isNotEqualTo "DOWN"};
