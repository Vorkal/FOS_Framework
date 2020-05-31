params ["_value"];


{
  _result = ["_value"] call BIS_fnc_getParamValue;
  profileNamespace setVariable [_x,_result];
} forEach [];

saveProfileNamespace;
