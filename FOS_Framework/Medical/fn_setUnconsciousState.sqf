params [["_unit",player,[objnull]],["_state",true,[true,false]]];

if !(_unit isEqualTo player) exitWith {};

if (_state) then {
    //Disable action menu
    showHud false;
    _unit setVariable ["FOS_MedicalState","unconscious"];
    ["unconscious",true] call FOS_fnc_medicalPPEffects;
    _unit setUnconscious true;
    _unit setCaptive true;
} else {
    //Declare unit healthy
    _unit setVariable ["FOS_MedicalState","HEALTHY"];
    ["unconscious",false] call FOS_fnc_medicalPPEffects;
    _unit setUnconscious false;
    showHud true;
    _unit setCaptive true;

};
