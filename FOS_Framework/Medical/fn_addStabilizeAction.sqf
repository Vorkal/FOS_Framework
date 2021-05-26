params [["_unit",objNull,[objNull]]];

//Remove stabilize action if it already exists
_id = _unit getVariable ["FOS_fnc_stabilizeActionID",-1];
if (_id isNotEqualTo -1) then {
    [_unit,_id] call BIS_fnc_holdActionRemove
};

_unit setVariable ["FOS_MedicalState","STABILIZED"];

_id = [
_unit,
"Stabilize " + name _unit,
"\a3\ui_f\data\IGUI\cfg\holdactions\holdAction_revive_ca.paa",
"\a3\ui_f\data\IGUI\cfg\holdactions\holdAction_revive_ca.paa",
"
_target != _this
&&
((damage _target >= 0 && _this getUnitTrait 'medic') || (damage _target > 0.25 && _this getUnitTrait 'medic' isEqualTo false))
&&
_target distance _this < 3
&&
stance _this in ['UNDEFINED',''] isEqualTo false
&&
_target getVariable ['FOS_MedicalState','HEALTHY'] isNotEqualTo 'HEALTHY'",
"'FirstAidKit' in items _this || ('Medkit' in items _this && _this getUnitTrait 'medic')",
{
    params ['_target', '_caller', '_actionId', '_arguments'];

    if ('FirstAidKit' in items _caller) then { //Begin revive anim
        _caller playAction "medicStart";
    } else { //Give feedback to player
        cutText ["No FAKs remaining", "PLAIN", 0.05];
    };
},
{
    params ['_target', '_caller', '_actionId', '_arguments', '_progress', '_maxProgress'];
    //Slowly remove damage
    if (12 % 4 == 0) then {
        if (_caller getUnitTrait 'medic') then { //is medic
            _target setHitIndex [round random 11, 0, false];
        } else { //is not medic
            _target setHitIndex [round random 11, 0.25, false];
        };
    };
},
{
    params ['_target', '_caller', '_actionId', '_arguments'];
    if ('Medkit' in items _caller && _caller getUnitTrait 'medic') then {
        //Do not remove anything
    } else {
        //Remove FirstAidKit
        _caller removeItem "FirstAidKit";
    };

    //[_target] call FOS_fnc_forceRevive;
    [_target] remoteExec ["FOS_fnc_addReviveAction",0];
},
{
    params ['_target', '_caller', '_actionId', '_arguments'];
    //Cancelled
    [_target] remoteExec ["FOS_fnc_addReviveAction",0];
},
[],
[_unit,0.75,3] call FOS_fnc_calculateBandageTime,
9999,
false,
false,
true
] call BIS_fnc_holdActionAdd;

_unit setVariable ["FOS_fnc_healActionID",_id];
