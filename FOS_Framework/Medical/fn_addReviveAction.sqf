params [["_unit",objNull,[objNull]]];

//Remove stabilize action if it already exists
_id = _unit getVariable ["FOS_reviveActionID",-1];
if (_id isNotEqualTo -1) then {
    [_unit,_id] call BIS_fnc_holdActionRemove
};

_id = [
_unit,
"Revive " + name _unit,
"\a3\ui_f\data\IGUI\cfg\holdactions\holdAction_revive_ca.paa",
"\a3\ui_f\data\IGUI\cfg\holdactions\holdAction_revive_ca.paa",
"
_target != _this
&&
_target distance _this < 3
&&
stance _this in ['UNDEFINED',''] isEqualTo false
&&
_target getVariable ['FOS_MedicalState','HEALTHY'] isEqualTo 'STABILIZED'",
"true",
{
    params ['_target', '_caller', '_actionId', '_arguments'];
    _caller playAction "medicStart";
},
{
    params ['_target', '_caller', '_actionId', '_arguments', '_progress', '_maxProgress'];
    //Slowly remove damage
    if (_progress % 2 == 0) then {
        if (_caller getUnitTrait 'medic') then { //is medic
            _target setHitIndex [round random 11, 0, false];
        } else { //is not medic
            _target setHitIndex [round random 11, 0.25, false];
        };
    };
},
{
    params ['_target', '_caller', '_actionId', '_arguments'];
    _caller playAction "medicStop";
    [_target] remoteExec ["FOS_fnc_forceRevive",_target];
},
{
    params ['_target', '_caller', '_actionId', '_arguments'];
    //Cancelled
    _caller playAction "medicStop";
    [_target] remoteExec ["FOS_fnc_addReviveAction",0];
},
[],
[_unit,2,3] call FOS_fnc_calculateBandageTime,
9999,
false,
false,
true
] call BIS_fnc_holdActionAdd;

_unit setVariable ["FOS_reviveActionID",_id];
