params [
	["_markerName","AO"],
	["_createMissionAO",true],
	["_cacheOutsideAO",false]
];

//No one needs to run this except server
if !(isServer) exitWith {};

//Exit if the mission maker requests missionAO be disabled.
if (_createMissionAO isEqualTo false) exitWith {["FOS: MissionAO function exiting! _createMissionAO value is false!"] call BIS_fnc_logFormat};
//Exit if map marker is missing
if (getMarkerPos "AO" isEqualTo [0,0,0]) exitWith {["FOS: MissionAO function exiting! AO marker is missing!"] call BIS_fnc_logFormat};
//AO map marker is not a square
if !(markerShape "AO" isEqualTo "RECTANGLE") exitWith {
	["AO Marker is a (%1). Must be ('RECTANGLE')",markerShape "AO"] call BIS_fnc_error;
};

//Remove old borders if they exist
//for "_i" from 0 to 270 step 90 do {deleteMarker (format ["FOS_fnc_CoverMap_%1",_i])};

_AO = _markerName;
_markerWidth = getMarkerPos _AO # 0;
_markerHeight = getMarkerPos _AO # 1;
_sizeX = getMarkerSize _AO # 0;
_sizeY = getMarkerSize _AO # 1;
_dir = getMarkerPos _AO # 2;

_sizeOut = 50000;

for "_i" from 0 to 270 step 90 do {
	_size1 = [_sizeX,_sizeY] select (abs cos _i);
	_size2 = [_sizeX,_sizeY] select (abs sin _i);
	_sizeMarker = [_size2,_sizeOut] select (abs sin _i);
	_dirTemp = _dir + _i;
	_markerPos = [
		_markerWidth + (sin _dirTemp * _sizeOut),
		_markerHeight + (cos _dirTemp * _sizeOut)
	];
	[_i,_markerPos,[_sizeMarker,_sizeOut - _size1]] call bis_fnc_log;
	_marker = format ["FOS_fnc_CoverMap_%1",_i];
	createmarker [_marker,_markerPos];
	_marker setmarkerpos _markerPos;
	_marker setmarkersize [_sizeMarker,_sizeOut - _size1];
	_marker setmarkerdir _dirTemp;
	_marker setmarkershape "rectangle";
	_marker setmarkerbrush "solidFull";
	_marker setmarkercolor "colorBlack";
};

_AO setMarkerBrush "Border";

//TODO: Cache outside AO

if (!isMultiplayer) then {systemChat "FOS: AO initialized"};