params ["_value","_default"];
private ["result"];

if (["loadParams",1] call BIS_fnc_getParamValue) then {
  _result = [_value,_default] call FOS_fnc_loadParams;
} else {
  _result = [_value,_default] call BIS_fnc_getParamValue;
};
_result
