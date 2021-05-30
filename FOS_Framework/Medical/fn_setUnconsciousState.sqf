params [["_unit",player,[objnull]],["_state",true,[true,false]]];

if !(_unit isEqualTo player) exitWith {};

if (_state) then {
    //Disable action menu
    showHud false;
    _unit setVariable ["FOS_MedicalState","UNCONSCIOUS",true];
    ["unconscious",true] call FOS_fnc_medicalPPEffects;
    _unit setUnconscious true;

    if (vehicle _unit != _unit) then {_unit playAction "unconscious"}; //In a vehicle

    _unit setCaptive true;
    [_unit] remoteExecCall ["FOS_fnc_addStabilizeAction",0];
} else {
    //Declare unit healthy
    _unit setVariable ["FOS_MedicalState","HEALTHY",true];
    ["unconscious",false] call FOS_fnc_medicalPPEffects;
    _unit setUnconscious false;
    showHud true;
    _unit setCaptive true;
};
