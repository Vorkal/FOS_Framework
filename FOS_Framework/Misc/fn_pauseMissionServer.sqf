_state = missionNameSpace getVariable ["FOS_PauseState",false];

if !(_state) then {
    //Disable all entities
    {_x enableSimulationGlobal false} forEach entities "" - [call FOS_fnc_getAdmin];
    //Alert players about the pause
    [true] remoteExec ["FOS_fnc_pauseMissionClient",0,"FOS_PauseMessage"];
    //Update current state of pause
    missionNameSpace setVariable ["FOS_PauseState",true,true];
} else {
    //Enable all entities
    {_x enableSimulationGlobal true} forEach entities "";
    //Remove pause message
    [false] remoteExec ["FOS_fnc_pauseMissionClient",0,"FOS_PauseMessage"];
    //Update current state of pause
    missionNameSpace setVariable ["FOS_PauseState",false,true];
};
