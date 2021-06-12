params [["_unit",objNull,[objnull]],["_target",objNull,[objnull]],["_mode",true,[true]]];

if (_mode) then {
    _unit setVariable ["FOS_dragBy",_target,true];

    _unit setUnconscious false;
    sleep 0.1;

    _unit switchMove "AinjPpneMrunSnonWnonDb_grab";
    _unit playMove "AinjPpneMrunSnonWnonDb";

    //Make sure they are not already attached
    detach _unit;
    detach _target;

    //Attach units together.
    _unit attachTo [_target, [0, 1.1, 0.05]];
    //For some reason set dir is local argument only
    _unit setDir 180;

    //Create loop for animation handling
    [_unit,_target] spawn {
        params ["_unit","_target"];
        private ["_pos","_moving"];

        while {!isNil {_unit getVariable ["FOS_dragBy",nil]}} do {

            if (animationState _target == "AcinPknlMwlkSrasWrflDb") then {
                _moving = true;
                _unit playMoveNow "AinjPpneMrunSnonWnonDb";
            } else {
                _moving = false;
                _unit switchMove "AinjPpneMrunSnonWnonDb_still";
            };

            _target setVariable ["FOS_animation",animationState _target];
            _animationState = _target getVariable "FOS_animation";
            waitUntil {sleep 0.1;animationstate _target != _animationState};
        };
    };
} else {
    _unit setVariable ["FOS_dragBy",nil,true];
    detach _unit;
    detach _target;
    //_unit switchMove "Unconscious";
    systemChat toUpper (_unit getVariable ["FOS_MedicalState","HEALTHY"]);
    switch (toUpper (_unit getVariable ["FOS_MedicalState","HEALTHY"])) do {
        case ("DOWN"): {
            _unit setUnconscious false;
            _unit setCaptive false;
            _unit switchMove "AinjPpneMstpSnonWrflDb_release";
            _unit playMoveNow "unconsciousOutProne";
        };
        case ("INCAPACITATED"): {
            _unit switchMove "unconsciousrevivedefault";
            _unit setUnconscious true;
        };
        case ("UNCONSCIOUS"): {
            _unit playMove "unconsciousrevivedefault";
            _unit setUnconscious true;
        };
        default {
            _unit setUnconscious false;
            _unit switchMove "unconsciousoutprone";
        };
    };
};
