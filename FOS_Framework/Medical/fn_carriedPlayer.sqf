params [["_unit",objNull,[objnull]],["_target",objNull,[objnull]],["_mode",true,[true]]];

detach _target;

if (_mode) then {
    _unit setVariable ["FOS_carried",_target,true];
    disableUserInput true;

    [_unit,"AinjPfalMstpSnonWrflDnon_carried_still"] remoteExec ["switchMove",0];

    _unit attachTo [_target, [-0.6, 0.28, -0.05]];
    _unit setDir 0;


    //Create loop for animation handling
    [_unit,_target] spawn {
        params ["_unit","_target"];
        private ["_pos"];

        //PLayer dead. stop handling animations
        if (!alive _target) exitWith {};

        while {!isNil {_unit getVariable ["FOS_carried",nil]}} do {

            if (animationState _target == "AcinPercMstpSnonWnonDnon") then {
                _unit playMoveNow "AinjPfalMstpSnonWnonDnon_carried_still";
            } else {
                _unit switchMove "AinjPfalMstpSnonWnonDf_carried";
            };

            _target setVariable ["FOS_animation",animationState _target];
            _animationState = _target getVariable "FOS_animation";
            waitUntil {sleep 0.1;animationstate _target != _animationState};
        };
    };

} else {
    _unit setVariable ["FOS_carried",nil,true];

    detach _unit;
    detach _target;

    switch (toUpper (_unit getVariable ["FOS_MedicalState","HEALTHY"])) do {
        case ("DOWN"): {
            _unit setUnconscious false;
            _unit setCaptive false;
            _unit switchMove "unconsciousOutProne";
        };
        case ("INCAPACITATED"): {
            _unit switchMove "unconsciousrevivedefault";
        };
        case ("UNCONSCIOUS"): {
            _unit switchMove "unconsciousrevivedefault";
        };
        default {
            _unit setUnconscious false;
            _unit switchMove "unconsciousOutProne";
        };
    };
    disableUserInput false;
};
