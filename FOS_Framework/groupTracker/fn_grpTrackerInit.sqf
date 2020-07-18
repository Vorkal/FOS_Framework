#include "..\..\settings.hpp"
if !(GROUPTRACKER) exitWith {};

addMissionEventHandler ["EachFrame", {
	_playerGroup = allGroups select {leader _x != leader player && isPlayer leader _x && [side player, side _x] call BIS_fnc_sideIsFriendly};
	{
		_type = "b_inf";
		switch (side _x) do {
		    case (west): {
		        _Type = "b_inf";
		    };
			case (independent): {
			   _Type = "n_inf";
		   };
		   case (east): {
			   _Type = "o_inf";
		   };
		};
		_color = [side _x, true] call BIS_fnc_sideColor;
		[_x,_type,_color, groupId _x] spawn FOS_fnc_setGrpTracker
	} forEach _playerGroup;
}];
