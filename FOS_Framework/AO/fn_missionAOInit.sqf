/*
File: fn_coverMap.sqf
Author: Karel Moricky

Description:
Covers unused part of the map

Parameter(s):
_this: OBJECT - Area Trigger

Returns:
Nothing
*/

#include "..\..\settings.hpp"

params [
	["_markerName","AO"],
	["_createMissionAO",true],
	["_cacheOutsideAO",false]
];

if !(MISSIONAO) exitWith {};
if (getMarkerPos _markerName isEqualTo [0,0,0]) exitWith {};


_pos = getMarkerPos _markerName;
_posX = _pos select 0;
_posY = _pos select 1;
_size = getMarkerSize _markerName;
_sizeX = _size select 0;
_sizeY = _size select 1;
_dir = 0;
_sizeOut = 100000;
_sizeBorder = (_sizeX max _sizeY) / 50;


for "_i" from 0 to 270 step 90 do {
	_sizeMarker = [_sizeX,_sizeOut] select ((_i / 90) % 2);
	_dirTemp = _dir + _i;
	_markerPos = [
		_posX + (sin _dirTemp * (_sizeX + _sizeOut)),
		_posY + (cos _dirTemp * (_sizeY + _sizeOut))
	];
	_marker = createmarker [format ["zone_%1",_i],_markerPos];
	_marker setmarkersize [_sizeMarker,_sizeOut];
	_marker setmarkerdir _dirTemp;
	_marker setmarkershape "rectangle";
	_marker setmarkerbrush "solidFull";
	_marker setmarkercolor "colorblack";

	//--- White borders
	_sizeMarker = [_sizeX,_sizeY + _sizeBorder * 2] select ((_i / 90) % 2);
	//_sizeBorderTemp = if (_i == 90) then {_sizeBorder * 2} else {_sizeBorder};
	_sizeBorderTemp = _sizeBorder;
	_markerPos = [
		_posX + (sin _dirTemp * (_sizeX + _sizeBorderTemp)),
		_posY + (cos _dirTemp * (_sizeY + _sizeBorderTemp))
	];
	for "_m" from 0 to 7 do {
		_marker = createmarker [format ["zoneBorder_%1_%2",_i,_m],_markerPos];
		_marker setmarkersize [_sizeMarker,_sizeBorderTemp];
		_marker setmarkerdir _dirTemp;
		_marker setmarkershape "rectangle";
		_marker setmarkerbrush "solid";
		_marker setmarkercolor "colorwhite";
	};
};

//--- Black frame Inner
_marker = createmarker ["zoneBorderInner",_pos];
_marker setmarkersize [_sizeX,_sizeY];
_marker setmarkerdir 0;
_marker setmarkershape "rectangle";
_marker setmarkerbrush "border";
_marker setmarkercolor "colorblack";

//--- Black frame Outer
_marker = createmarker ["zoneBorderOuter",_pos];
_marker setmarkersize [_sizeX + _sizeBorder * 2,_sizeY + _sizeBorder * 2];
_marker setmarkerdir 0;
_marker setmarkershape "rectangle";
_marker setmarkerbrush "border";
_marker setmarkercolor "colorblack";
