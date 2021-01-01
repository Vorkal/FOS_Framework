//Executes only in 3den (preview scenario)

addMissionEventHandler ["EachFrame", {
    {
        _mrkText = markerText _x;
        //Draw marker icon
        drawIcon3D [
          "\A3\ui_f\data\map\markers\handdrawn\dot_CA.paa",
          [0,0,0,1],
          getMarkerPos _x,
          1,
          1,
          0,
          _mrkText,
          0,
          0.1,
          "PuristaLight"
        ];
    } forEach allMapMarkers;
}];

addMissionEventHandler ["EachFrame", {
    _allLines = missionNameSpace getVariable ["FOS_allDrawnLines",[]];
    if (count _allLines == 0) exitWith {};
    {
        if (count _x == 3) then {
            _lineData = _x # 2;

            // Go through all projectile segments and draw them
            {
                private _nextSegmentIndex = _forEachIndex + 1;

                if (count _lineData > _nextSegmentIndex) then
                {
                    private _locOld = _x;
                    "_locOld: " + str _locOld call FOS_fnc_debugSystemAdd;
                    private _locNew = _lineData select _nextSegmentIndex;
                    "_locNew: " + str _locNew call FOS_fnc_debugSystemAdd;

                    drawLine3D [_locOld, _locNew,[0,0,0,1]];
                };
            } forEach _lineData;
        };
    } forEach _allLines;
}];

//Map  ctrl
_map = (findDisplay 12 displayCtrl 51);
//handler for button down on map
_map ctrlAddEventHandler ["MouseButtonDown",
{
    params ["_displayorcontrol", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
    //Set variable to alert the other handlers that a line is being drawn
    if (_ctrl) then { //Ctrl key pressed down on button click
        //Get the index of the current marker being created
        _index = player getVariable ["FOS_currentMarkerIndex",-1];
        _index = _index + 1;
        missionNameSpace setVariable ["FOS_CurrentLineTrack",[owner player,_index,[]]];
        player setVariable ["FOS_currentMarkerIndex",_index];

        missionNameSpace setVariable ["FOS_MapLineTrack",true];
    };
}];
_map ctrlAddEventHandler ["MouseMoving",
{
    params ["_control", "_xPos", "_yPos", "_mouseOver"];
    if (missionNameSpace getVariable ["FOS_MapLineTrack",false]) then { //Ctrl is pressed down as map is moving
        //Get empty array to push points into
        _Line = missionNameSpace getVariable ["FOS_CurrentLineTrack",[0,0,[]]];
        //Get current line data
        _currentLineData = _line # 2;
        systemChat str _currentLineData;
        if !(_currentLineData isEqualTo []) then { //usable Data exists
            _previousLinePoint = _currentLineData select (count _currentLineData) - 1;
            _worldCords = _control ctrlMapScreenToWorld [_xPos, _yPos];
            if (_worldCords distance _previousLinePoint > 2) then {
                //Push the X and Y position to the global variable FOS_CurrentLineTrack
                (_Line # 2) pushBack (_worldCords + [0.5]);
            };
        } else { //usable data does not exist (First point created)
            //Push the X and Y position to the global variable FOS_CurrentLineTrack
            _worldCords = _control ctrlMapScreenToWorld [_xPos, _yPos];
            (_Line # 2) pushBack (_worldCords + [0.5]);
        };
    };
}];
_map ctrlAddEventHandler ["MouseButtonUp",
{
    params ["_displayorcontrol", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
    //Set variable to false to alert the other handlers that a line is no longer being drawn
    missionNameSpace setVariable ["FOS_MapLineTrack",false];
    //Grab all line points recorded in array
    _Line = missionNameSpace getVariable ["FOS_CurrentLineTrack",[]];
    //Get the variable that stores all current line tracks
    _allLinePoints = missionNameSpace getVariable ["FOS_allDrawnLines",[]];
    //Add newest line to array
    _allLinePoints pushBack _line;
    //Clear CurrentLineTrack varaible
    missionNameSpace setVariable ["FOS_CurrentLineTrack",nil];
    //Update variable globally
    missionNameSpace setVariable ["FOS_allDrawnLines",_allLinePoints];
}];
