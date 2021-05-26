params [["_unit",objNull,[objNull]]];

//Remove heal action if it already exists
_id = _unit getVariable ["FOS_fnc_healActionID",-1];
if (_id isNotEqualTo -1) then {
    [_unit,_id] call BIS_fnc_holdActionRemove
};


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

    if ('FirstAidKit' in items _caller) then {
        _caller playAction "MedicOther";
    } else {
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
    if ("MedicOther" in animationState _caller isEqualTo false) then {
        _caller playAction "MedicOther";
    };
},
{
    params ['_target', '_caller', '_actionId', '_arguments'];
    if (_caller getUnitTrait 'medic') then {
        _target setDamage 0;
    } else {
        _target setDamage 0.25;
    };
    _caller removeItem "FirstAidKit";
    if ("ppn" in animationState _caller) then { // Prone detected in animation
        if ([currentWeapon player] call BIS_fnc_invSlotType select 0 == 1) exitWith {
            _caller switchMove "amovppnemstpsraswrfldnon";
        };
        if ([currentWeapon player] call BIS_fnc_invSlotType select 1 == 1) exitWith {
            _caller switchMove "amovppnemstpsraswpstdnon";
        };
    } else { //prone not detected in animation (So they're crouching)
        if ([currentWeapon player] call BIS_fnc_invSlotType select 0 == 1) exitWith {
            _caller switchMove "amovpknlmstpsraswrfldnon";
        };
        if ([currentWeapon player] call BIS_fnc_invSlotType select 1 == 1) exitWith {
            _caller switchMove "amovpknlmstpsraswpstdnon";
        };
        if ([currentWeapon player] call BIS_fnc_invSlotType select 2 == 1) exitWith {
            _caller switchMove "amovpknlmstpsraswlnrdnon";
        };
    };
    /* [_target] remoteExecCall ["FOS_fnc_addHealAction",0]; */
},
{
    params ['_target', '_caller', '_actionId', '_arguments'];
    if ('FirstAidKit' in items _caller isEqualTo false) exitWith {};
    if ("ppn" in animationState _caller) then { // Prone detected in animation
        if ([currentWeapon player] call BIS_fnc_invSlotType select 0 == 1) exitWith {
            _caller switchMove "amovppnemstpsraswrfldnon";
        };
        if ([currentWeapon player] call BIS_fnc_invSlotType select 1 == 1) exitWith {
            _caller switchMove "amovppnemstpsraswpstdnon";
        };
    } else { //prone not detected in animation (So they're crouching)
        if ([currentWeapon player] call BIS_fnc_invSlotType select 0 == 1) exitWith {
            _caller switchMove "amovpknlmstpsraswrfldnon";
        };
        if ([currentWeapon player] call BIS_fnc_invSlotType select 1 == 1) exitWith {
            _caller switchMove "amovpknlmstpsraswpstdnon";
        };
        if ([currentWeapon player] call BIS_fnc_invSlotType select 2 == 1) exitWith {
            _caller switchMove "amovpknlmstpsraswlnrdnon";
        };
    };
    [_target] remoteExecCall ["FOS_fnc_addHealAction",0];
},
[],
[_unit,2,2] call FOS_fnc_calculateBandageTime,
9999,
false,
false,
true
] call BIS_fnc_holdActionAdd;

_unit setVariable ["FOS_fnc_healActionID",_id];
