if (isServer) then {
    {
        if (damage _x > 0) then {
            [_x] call FOS_fnc_addHealAction;
        };
        [_x] call FOS_fnc_medicalEhDammaged
    } forEach allPlayers;
};


[_x] call FOS_fnc_medicalEhHandleDamage;
