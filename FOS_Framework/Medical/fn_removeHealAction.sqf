params [["_unit",objNull,[objNull]]];

_id = _unit getVariable ["FOS_fnc_healActionID",-1];
if (_id isNotEqualTo -1) then {
    [_unit,_id] call BIS_fnc_holdActionRemove
};
