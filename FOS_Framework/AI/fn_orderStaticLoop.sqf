/*
Similar to a patrol, but the group moves between static waypoints. Good for ambient vehicles.
Also works for helicopters which will land at each waypoint before leaving again.
*/
params [
["_grp",grpNull,[grpNull]],
["_staticPoints",[[0,0,0],[1,1,1]]],
["_delay",[30,60,90]],
["_speed",0],
["_debug",false]
];

//If this is called (not spawned), spawn script
if !(canSuspend) exitWith {_this spawn _thisScript};
//group not local to machine
if !(local _grp) exitWith {};

_veh = vehicle leader _grp;

if (_speed > 0) then { // _speed paramter used
    _veh limitSpeed _speed;
};

if (typeof _veh isKindOf "landVehicle") then { //ground vehicle
    while {sleep 0.1;!isNull _grp && alive _veh} do { //Group still exists
        //Select a random waypoint to go to
        _nextWp = selectRandom _staticPoints;

        //order group to go to next selected waypoints
        _wp =_grp addWaypoint [_nextWp, 0];
        _wp setWaypointTimeout _delay;
        _grp setBehaviour "SAFE";
        //Wait until leader vehicle arrives at the destination
        waitUntil {{unitReady _x} count [commander _veh,gunner _veh, driver _veh] isEqualTo 3};

        //Group hit combat. Disengage patrol route
        if (behaviour _grp isEqualTo "COMBAT") exitWith {};
    };
};

if (typeof _veh isKindOf "Helicopter") then { //helicopter
    while {sleep 0.1;!isNull _grp && alive _veh} do { //Group still exists
        //Select a random waypoint to go to
        _nextWp = selectRandom _staticPoints;

        //order group to go to next selected waypoints
        _veh move _nextWp;

        sleep 3;

        while { ( (alive _veh) && !(unitReady _veh) ) } do
        {
            sleep 1;
        };

        if (alive _veh) then
        {
            _veh land "LAND";
        };

        waitUntil {isTouchingGround _veh && unitReady _veh};
        sleep random _sleep;
        //Either Zeus or another script is attempting to give a waypoint to this group. Exit.
        if (count waypoints _grp > 1) exitWith {};
    };
};
