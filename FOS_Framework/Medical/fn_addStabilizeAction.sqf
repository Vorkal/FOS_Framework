params [["_unit",objNull,[objNull]]];


_unit setVariable ["FOS_MedicalState","STABILIZED"];

_id = [
_unit,
"Treat " + name _unit,
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
_target getVariable ['FOS_MedicalState','HEALTHY'] isEqualTo 'HEALTHY'",
"'FirstAidKit' in items _this",
{
    params ['_target', '_caller', '_actionId', '_arguments'];
    //Begin
},
{
    params ['_target', '_caller', '_actionId', '_arguments', '_progress', '_maxProgress'];
    // progress
},
{
    params ['_target', '_caller', '_actionId', '_arguments'];
    //succeeded
},
{
    params ['_target', '_caller', '_actionId', '_arguments'];
    //Cancelled
},
[],
6,
9999,
false,
false,
true
] call BIS_fnc_holdActionAdd;

_unit setVariable ["FOS_fnc_healActionID",_id,true];
