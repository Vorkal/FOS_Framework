params ["_state"];

switch (toUpper _unit getVariable ["FOS_MedicalState","HEALTHY"]) do {
    case ("DOWN"): {
        //Declare unit healthy
        _unit setVariable ["FOS_MedicalState","HEALTHY"];
    };
    case ("INCAPACITATED"): {
        //Declare unit healthy
        _unit setVariable ["FOS_MedicalState","HEALTHY"];
    };
    case ("UNCONSCIOUS"): {
        //Declare unit healthy
        _unit setVariable ["FOS_MedicalState","HEALTHY"];
        ["unconscious",false] call FOS_fnc_medicalPPEffects;
        _unit setUnconscious false;
        showHud true;
        _unit setCaptive false;
    };
};
