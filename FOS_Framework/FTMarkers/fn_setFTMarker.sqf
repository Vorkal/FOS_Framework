
#include "..\..\settings.hpp"
params ["_unit"];
private ["_type","_size","_size_Shadow","_alpha_Shadow","_tfarcondition"];
_FTMarker = format ["FTMrk_%1", name _unit];
_FTMarker_Shadow = format ["FTMrk_%1_Shadow", name _unit];
_FTMarker_Sel = format ["FTMrk_%1_Sel", name _unit];
_FTMarker_Speech = format ["FTMrk_%1_Speech", name _unit];

//Delete markers if the NEEDGPS parameter is true and they have no GPS
if ({"GPS" in _x || "Terminal" in _x} count assignedItems player == 0 && NEEDGPS) exitWith {
	{deleteMarker _x} forEach [_FTMarker,_FTMarker_Shadow,_FTMarker_Sel,_FTMarker_Speech];
};

_pos = getPos _unit;
//Find the current team
_color = "Color" + assignedTeam _unit;
if (_color isEqualTo "Color") then {_color = "ColorMAIN"};
//Convert string to match white marker color classname
if (_color isEqualTo "ColorMAIN") then {_color = "ColorWhite"};

//Disable FT markers while unit is in zeus
if (!isNull findDisplay 312) exitWith {
	 _FTMarker setMarkerAlphaLocal 0;
	 _FTMarker_Shadow setMarkerAlphaLocal 0;
};


//This will probably break dialogs that use map or mainmap type
/* //Don't bother updating marker pos if player doesn't have any way to see them.
if !(visibleMap || visibleGPS) exitWith {}; */


// CREATE MARKERS (If they don't exist)
if (getMarkerPos _FTMarker isEqualTo [0,0,0] || getMarkerPos _FTMarker_Shadow isEqualTo [0,0,0]) then {

	//Create shadow
	createMarkerLocal [_FTMarker_Shadow,_pos];
	_FTMarker_Shadow setMarkerShapeLocal "ICON";
	_FTMarker_Shadow setMarkerColorLocal "colorBlack";

	//Create marker
	createMarkerLocal [_FTMarker,_pos];
	_FTMarker setMarkerShapeLocal "ICON";
};

//if unit is up
if (alive _unit && lifeState _unit != "INCAPACIATED") then {
	_type = "loc_ViewTower";
	_size_Shadow = [1.4, 1.4];
	_size = [1.1745, 1.1745];
};

//if unit is injured (BIS_Revive)
if (alive _unit && lifeState _unit == "INCAPACITATED") then {
	_type = "Loc_Hospital";
	_size_Shadow = [0,0];
	_size = [0.75,0.75];
};

_FTMarker_Shadow setMarkerTypeLocal _type;

_FTMarker_Shadow setMarkerSizeLocal _size_Shadow;
_FTMarker_Shadow setMarkerAlphaLocal 1;
_FTMarker_Shadow setMarkerPosLocal _pos;
_FTMarker_Shadow setMarkerDirLocal (direction _unit);

_FTMarker setMarkerTypeLocal _type;
_FTMarker setMarkerColorLocal _color;
_FTMarker setMarkerSizeLocal _size;
_FTMarker setMarkerAlphaLocal 1;
_FTMarker setMarkerPosLocal _pos;
_FTMarker setMarkerDirLocal (direction _unit);

if (_unit in groupSelectedUnits player) then {
	createMarkerLocal [_FTMarker_Sel,_pos];
	_FTMarker_Sel setMarkerPosLocal _pos;
	_FTMarker_Sel setMarkerShapeLocal "ICON";
	_FTMarker_Sel setMarkerTypeLocal "mil_circle";
	_FTMarker_Sel setMarkerColorLocal _color;
} else {deleteMarker _FTMarker_Sel};


if (!isNil "TFAR_fnc_isSpeaking") then {_tfarcondition = _unit call TFAR_fnc_isSpeaking} else {_tfarcondition = false};

if (getPlayerChannel _unit != -1 || _tfarcondition) then {
	for "_i" from 1 to 3 do {
		_mrk = (_FTMarker_Speech + str _i);
		createMarkerLocal [_mrk,_pos];
		_ctrl = ((findDisplay 12) displayCtrl 51);
		_scale = (ctrlMapScale _ctrl) * 200;
		switch (_i) do {
		    case (1): {
				_mrkPos = _pos getPos [_scale, (getDir _unit) - 55];
				_mrk setMarkerPosLocal _mrkPos;
				_mrk setMarkerDirLocal (_unit getDir _mrkPos);
		    };
			case (2): {
				_mrkPos = _pos getPos [_scale, (getDir _unit)];
				_mrk setMarkerPosLocal _mrkPos;
				_mrk setMarkerDirLocal (_unit getDir _mrkPos);
		    };
			case (3): {
				_mrkPos = _pos getPos [_scale, (getDir _unit) + 55];
				_mrk setMarkerPosLocal _mrkPos;
				_mrk setMarkerDirLocal (_unit getDir _mrkPos);
		    };
		};
		_mrk setMarkerShapeLocal "ICON";
		_mrk setMarkerSizeLocal [0.15,0.75];
		_mrk setMarkerTypeLocal "mil_box";
		_mrk setMarkerColorLocal _color;
	};
} else {
	for "_i" from 1 to 3 do {
		_mrk = (_FTMarker_Speech + str _i);
		deleteMarker _mrk;
	};
}
