

params ["_unit"];
private ["_type","_size","_size_Shadow","_alpha_Shadow"];
_FTMarker = format ["FTMrk_%1", name _unit];
_FTMarker_Shadow = format ["FTMrk_%1_Shadow", name _unit];
_pos = getPos _unit;
//Find the current team
_color = "Color" + assignedTeam _unit;
//Convert string to match white marker color classname
if (_color isEqualTo "ColorMAIN") then {_color = "ColorWhite"};

//Disable FT markers while unnit is in zeus
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
