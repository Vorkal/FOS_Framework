params ["_unit","_target"];

_unit setVariable ["FOS_dragBy",_target,true];

_unit setUnconscious false;

//Make sure they are not already attached
detach _unit;
detach _target;

_unit switchMove "AinjPpneMrunSnonWnonDb_grab";
_unit playMove "AinjPpneMrunSnonWnonDb";

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
        waitUntil {sleep 0.1;systemChat str _animationState;animationstate _target != _animationState};
    };
};
