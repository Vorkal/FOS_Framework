{
    _result = [_x] call BIS_fnc_getParamValue;
    profileNamespace setVariable ["FOS" + _x,_result];
} forEach ["reviveSystem","FTMarkers","groupMarkers"];

saveProfileNamespace;
