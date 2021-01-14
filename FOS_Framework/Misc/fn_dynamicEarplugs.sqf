params [["_state",true,[true,"string"]]];

if (typeName _state isEqualType typeName true) then {
    _currentSetting = missionNameSpace getVariable ["FOS_dynamicEarplugsSetting","off"];
    switch (_currentSetting) do {
        case ("strong"): {
            missionNameSpace setVariable ["FOS_dynamicEarplugsSetting","off"];
            systemChat "Dynamic Earplugs set to strong";
        };
        case ("normal"): {
            missionNameSpace setVariable ["FOS_dynamicEarplugsSetting","strong"];
            systemChat "Dynamic Earplugs set to normal";
        };
        case ("weak"): {
            missionNameSpace setVariable ["FOS_dynamicEarplugsSetting","normal"];
            systemChat "Dynamic Earplugs set to weak";
        };
        default { //Off
            missionNameSpace setVariable ["FOS_dynamicEarplugsSetting","weak"];
            systemChat "Dynamic Earplugs set to off";
        };
    };
} else {
    switch (toLower _state) do {
        case ("strong"): {
            missionNameSpace setVariable ["FOS_dynamicEarplugsSetting","strong"];
            systemChat "Dynamic Earplugs set to strong";
        };
        case ("normal"): {
            missionNameSpace setVariable ["FOS_dynamicEarplugsSetting","normal"];
            systemChat "Dynamic Earplugs set to normal";
        };
        case ("weak"): {
            missionNameSpace setVariable ["FOS_dynamicEarplugsSetting","weak"];
            systemChat "Dynamic Earplugs set to weak";
        };
        case ("off"): {
            missionNameSpace setVariable ["FOS_dynamicEarplugsSetting","off"];
            systemChat "Dynamic Earplugs set to off";
        };
        default {
            missionNameSpace setVariable ["FOS_dynamicEarplugsSetting","off"];
        };
    };
};

if (missionNameSpace getVariable ["FOS_dynamicEarplugs",false] isEqualTo false) then { //Dynamic Earplugs not running yet
    //Set variable so this is not ran again twice
    missionNameSpace setVariable ["FOS_dynamicEarplugs",true];
    while {sleep 0.1;true} do {
        private _state = missionNameSpace getVariable ["FOS_dynamicEarplugsSetting","off"];
        switch (_state) do {
            case ("strong"): {
                if (vehicle player == player) then {
                    1.5 fadeSound 1;
                } else {
                    1.5 fadeSound 0.15;
                };
            };
            case ("normal"): {
                if (vehicle player == player) then {
                    1.5 fadeSound 1;
                } else {
                    1.5 fadeSound 0.35;
                };
            };
            case ("weak"): {
                if (vehicle player == player) then {
                    1.5 fadeSound 1;
                } else {
                    1.5 fadeSound 0.70;
                };
            };
            default {1.5 fadeSound 1;};
        };
    };
};
