params [["_unit",objNull,[objnull]],["_target",objNull,[objnull]],["_mode",true,[true]]];


if (_mode) then {
    _unit setVariable ["FOS_dragging",_target,true];

    _unit playActionNow "grabDrag";

    //Listeners
    [_unit,_target] spawn {
        params ["_unit","_target"];

        while {alive _unit && alive _target && _unit getVariable ["FOS_dragging",objnull] isEqualTo _target} do {

            if (inputAction "MoveDown" >= 1) exitWith {
                [_unit,_target,false] call FOS_fnc_dragPlayer;
                [_target,_unit,false] remoteExecCall ["FOS_fnc_draggedPlayer",_target];
                _unit switchMove "AcinPknlMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon";
            };
            if (inputAction "MoveUp" >= 1) exitWith {
                [_unit,_target,false] call FOS_fnc_dragPlayer;
                [_target,_unit,false] remoteExecCall ["FOS_fnc_draggedPlayer",_target];
                _unit switchMove "AcinPknlMstpSrasWrflDnon_AmovPknlMstpSrasWrflDnon";
            };
        };
    };
} else {
    _unit setVariable ["FOS_dragging",nil,true];
    _unit switchMove "AcinPknlMstpSrasWrflDnon_AmovPknlMstpSrasWrflDnon";
};
