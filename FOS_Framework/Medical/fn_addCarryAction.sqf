params [["_unit",player,[objNull]]];

//Remove heal action if it already exists
_id = _unit getVariable ["FOS_fnc_carryActionID",-1];
if (_id isNotEqualTo -1) then {
    [_unit,_id] call BIS_fnc_holdActionRemove
};


_id = [
_unit,
"carry " + name _unit,
"\a3\ui_f\data\IGUI\cfg\holdactions\holdAction_revive_ca.paa",
"\a3\ui_f\data\IGUI\cfg\holdactions\holdAction_revive_ca.paa",
"
alive _target
&&
_target distance _this < 3
&&
stance _this in ['UNDEFINED',''] isEqualTo false
&&
_target getVariable ['FOS_MedicalState','HEALTHY'] isNotEqualTo 'HEALTHY'",
"true",
{
    params ['_target', '_caller', '_actionId', '_arguments'];

},
{
    params ['_target', '_caller', '_actionId', '_arguments', '_progress', '_maxProgress'];

},
{
    params ['_target', '_caller', '_actionId', '_arguments'];
    [_caller,_target] remoteExec ["FOS_fnc_carryPlayer",_caller];
    [_target,_caller] remoteExec ["FOS_fnc_carriedPlayer",_target];
},
{
    params ['_target', '_caller', '_actionId', '_arguments'];

},
[],
3,
9998,
false,
false,
true
] call BIS_fnc_holdActionAdd;

_unit setVariable ["FOS_fnc_carryActionID",_id];
