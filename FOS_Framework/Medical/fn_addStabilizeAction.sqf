params [["_unit",objNull,[objNull]]];

//add drag action as well
[_unit] remoteExecCall ["FOS_fnc_addDragAction",0];

//Remove stabilize action if it already exists
_id = _unit getVariable ["FOS_stabilizeActionID",-1];
if (_id isNotEqualTo -1) then {
    [_unit,_id] call BIS_fnc_holdActionRemove
};


_id = [
_unit,
"Stabilize " + name _unit,
"\a3\ui_f\data\IGUI\cfg\holdactions\holdAction_revive_ca.paa",
"\a3\ui_f\data\IGUI\cfg\holdactions\holdAction_revive_ca.paa",
"
isNil {_this getVariable ['FOS_dragging',nil]}
&&
_target != _this
&&
_target distance _this < 3
&&
stance _this in ['UNDEFINED',''] isEqualTo false
&&
_target getVariable ['FOS_MedicalState','HEALTHY'] in ['DOWN','INCAPACITATED','UNCONSCIOUS']",
"'FirstAidKit' in items _this || ('Medkit' in items _this && _this getUnitTrait 'medic')",
{
    params ['_target', '_caller', '_actionId', '_arguments'];

    if ('FirstAidKit' in items _caller) then { //Begin revive anim
        _caller playAction "medicStart";
    } else { //Give feedback to player
        cutText ["No Medical equipment remaining", "PLAIN", 0.05];
    };
},
{
    params ['_target', '_caller', '_actionId', '_arguments', '_progress', '_maxProgress'];

},
{
    params ['_target', '_caller', '_actionId', '_arguments'];
    if ('Medkit' in items _caller && _caller getUnitTrait 'medic') then {
        //Do not remove anything
    } else {
        //Remove FirstAidKit
        _caller removeItem "FirstAidKit";
    };
    _caller playAction "medicStop";
    _target setVariable ["FOS_MedicalState","STABILIZED",true];
    [_target] remoteExec ["FOS_fnc_addReviveAction",0];
},
{
    params ['_target', '_caller', '_actionId', '_arguments'];
    _caller playAction "medicStop";
},
[],
[_unit,0.75,3] call FOS_fnc_calculateBandageTime,
9999,
false,
false,
true
] call BIS_fnc_holdActionAdd;

_unit setVariable ["FOS_stabilizeActionID",_id];
