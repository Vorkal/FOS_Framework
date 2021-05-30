if (isServer) then {
    {
        [_x] remoteExecCall ["FOS_fnc_addHealAction",0];
    } forEach allUnits;
};
if !(isDedicated) then {
    [player] call FOS_fnc_medicalEhHandleDamage;
    [player] call FOS_fnc_medicalEhDammaged;
};
