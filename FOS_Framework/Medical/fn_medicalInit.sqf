{
    [_x] call FOS_fnc_addHealAction;
    [_x] call FOS_fnc_medicalEhHandleDamage;
    [_x] call FOS_fnc_medicalEhDammaged;
} forEach allUnits;
