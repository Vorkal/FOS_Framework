if (isServer) then {
    {
        if (damage _x > 0) then {
            [_x] remoteExecCall ["FOS_fnc_addHealAction",0];
        };
        [_x] call FOS_fnc_medicalEhDammaged
    } forEach allUnits;
};


[player] call FOS_fnc_medicalEhHandleDamage;
