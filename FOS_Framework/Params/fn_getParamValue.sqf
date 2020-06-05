params ["_value","_default"];
private ["_result"];

if (["loadParams",1] call BIS_fnc_getParamValue) then {
  _result = profileNamespace getVariable ["FOS" + _value,nil];
} else {
  _result = [_value,_default] call BIS_fnc_getParamValue;
};
_result
