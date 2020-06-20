params ["_value","_default"];
private ["_result"];

/* switch (_default) do {
    case (true): {
        _default = 1;
    };
    case (false): {
        _default = 0;
    };
}; */

_profileVar = profileNameSpace getVariable ("FOS_" + _value);

if (["loadParams",1] call BIS_fnc_getParamValue isEqualTo 1 && !(isNil "_profileVar")) then {
  _result = profileNamespace getVariable ("FOS_" + _value);
} else {
    if (isNil "_default") then {
        _result = [_value] call BIS_fnc_getParamValue;
    } else {
        _result = [_value,_default] call BIS_fnc_getParamValue;
    }
};
_result
