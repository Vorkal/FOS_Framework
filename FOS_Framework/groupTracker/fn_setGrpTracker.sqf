
params ["_group","_markerType","_text","_loop"];

if (_group isEqualTo group player) exitWith {};
if (!canSuspend) exitWith {_this spawn FOS_fnc_setGrpTracker};

//fixes a bug that can be caused by the editor.
if (time == 0) then {
    _initGroupId = groupID _group;
    waitUntil {_initGroupId != groupID _group};
};

_grpMarker = format ["grpMrk_%1", groupID _group];
_pos = getPos leader _group;


if (getMarkerPos _grpMarker isEqualTo [0,0,0]) then {
    createMarkerLocal [_grpMarker,_pos];
    _grpMarker setMarkerShape "ICON";
    _grpMarker setMarkerColorLocal "default";
    _grpMarker setMarkerSizeLocal [0.75,0.75];
    _grpMarker setMarkerAlphaLocal 1;
    _grpMarker setMarkerPosLocal _pos;
    _grpMarker setMarkerTypeLocal _markerType;
    _grpMarker setMarkerText _text;
} else {
    _grpMarker setMarkerPosLocal _pos;
    _grpMarker setMarkerTypeLocal _markerType;
    _grpMarker setMarkerText _text;
};

if (_loop > 0) exitWith {
    sleep _loop;
    _this spawn FOS_fnc_setGrpTracker;

};
