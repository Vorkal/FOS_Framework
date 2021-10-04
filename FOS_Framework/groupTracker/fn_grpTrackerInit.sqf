#include "..\..\settings.hpp"

if !(GROUPTRACKER) exitWith {};

//Do not initialize if ACE Blueforce tracking is possible
if !(GRPTRACKERIGNOREACE) then {
	if (isClass(configfile >> "CfgPatches" >> "ace_map")) exitWith {"Group tracker disabling. ACE detected" call FOS_fnc_debugSystemAdd; //Debug message};
};

addMissionEventHandler ["EachFrame", {
	private ["_groups","_typeSide"];

	//Grab all list of units
	switch (GRPTRACKERLIST) do {
	    case ("FRIENDLY"): {
			//All friendly groups
	       _groups = allGroups select {[side group player, side _x] call BIS_fnc_sideIsFriendly}
	    };
		case ("SIDE"): {
		    _groups = allGroups select {side group player isEqualTo side _x}
		};
		 case ("FRIENDLY PLAYERS"): {
		     _groups = allGroups select {[side group player, side _x] call BIS_fnc_sideIsFriendly && isPlayer leader _x}
		 };
		 case ("SIDE PLAYERS"): {
		     _groups = allGroups select {side group player isEqualTo side _x && isPlayer leader _x}
		 };
	};

	if (GRPTRACKERNEEDGPS) then { //Mission maker wants GPS required
		//Find if leader has any of the required items given by mission maker to be
		_groups = _groups select {
			_group = _x;
			{ _x in assignedItems leader _group} count GRPTRACKERGPSNEEDED > 0
		};
	};

	//Delete player's group from the list.
	_groups deleteAt (_groups find group player);

	{
		private ["_type"];
		//Get marker type
		if ((vehicle leader _x call BIS_fnc_objectType) # 0 isEqualTo "VehicleAutonomous") then { //Is drone
			_type = "uav";
		} else { //Not drone
			if ((vehicle leader _x call BIS_fnc_objectType) # 0 isEqualTo "Soldier") then {//is Infantry
				_type = "inf";
			} else { // not infantry
				switch ((vehicle leader _x call BIS_fnc_objectType) # 1) do {
					case ("Car"): {
						_type = "motor_inf"
					};
					case ("Motorcycle");
					case ("Helicopter"): {
					    _type = "air"
					};
					case ("Plane"): {
						_type = "plane"
					};
					case ("Ship"): {
					    _type = "naval"
					};
					case ("Submarine");
					case ("TrackedAPC"): {
					    _type = "mech_inf"
					};
					case ("WheeledAPC"): {
					   _type = "mech_inf"
					};
					case ("Tank"): {
					   _Type = "armor"
					};
					default {
					    _type = "unknown"
					};
				};
			};
		};
		//Get side
		switch (side _x) do {
		    case (west): {
		        _typeSide = "b";
		    };
			case (independent): {
			   _typeSide = "n";
		   };
		   case (east): {
			   _typeSide = "o";
		   };
		   default {
		        _typeSide = "b";
		   };
		};

		//Join string
		_type = _typeSide + "_" + _type;
		_color = [side _x, true] call BIS_fnc_sideColor;
		[_x,_type,_color, groupId _x] spawn FOS_fnc_setGrpTracker
	} forEach _groups - [group player];
}];
