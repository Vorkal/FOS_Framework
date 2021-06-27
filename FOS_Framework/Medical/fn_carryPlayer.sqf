params [["_unit",objNull,[objnull]],["_target",objNull,[objnull]],["_mode",true,[true]]];

detach _unit;

if (_mode) then {
    _unit setVariable ["FOS_carrying",_target,true];

    _unit switchMove "AcinPercMstpSnonWnonDnon";

} else {
    _unit setVariable ["FOS_carrying",nil,true];
    _unit switchMove "AcinPercMrunSnonWnonDf_AmovPercMstpSnonWnonDnon";
};
