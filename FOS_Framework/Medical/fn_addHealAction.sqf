params [["_unit",objNull,[objNull]]];

[
_unit,
"Treat " + name _unit,
"\a3\ui_f\data\IGUI\cfg\holdactions\holdAction_revive_ca.paa",
"\a3\ui_f\data\IGUI\cfg\holdactions\holdAction_revive_ca.paa",
"damage _target >= 0.25 && _target distance _this < 3 && stance _this in ['UNDEFINED',''] isEqualTo false",
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
    if ("MedicOther" in animationState _caller isEqualTo false) then {
        _caller playAction "MedicOther";
    };
},
{
    params ['_target', '_caller', '_actionId', '_arguments'];
    _target setDamage 0.25;
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
},
[],
12,
9999,
false,
false,
true
] call BIS_fnc_holdActionAdd;
