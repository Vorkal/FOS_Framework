params ["_toggle"];

if (_toggle) then {
    while {missionNameSpace getVariable ["FOS_PauseState",false]} do {
        "pauseMessage" cutText ["Please wait...", "PLAIN",0.01];
    };
} else {
    "pauseMessage" cutText ["", "PLAIN",0.01];
};
