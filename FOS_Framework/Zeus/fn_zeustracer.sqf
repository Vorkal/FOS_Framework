//Executes only in 3den (preview scenario)


//Attach the event handler to detect when the EMP bullet is shot
{_x addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    private _projectiles = missionNamespace getVariable ["FOS_Tracers", []];
    if (count _projectiles > 50) then {_projectiles deleteAt 0};
    _projectiles pushBack [_projectile, [[getPosVisual _projectile, [1,0,0,0]]]];
    missionNamespace setVariable ["FOS_Tracers", _projectiles];
}]} forEach allUnits;

addMissionEventHandler ["Draw3D", {
    if (isNull findDisplay 312) exitWith {};
    private _projectiles = missionNamespace getVariable ["FOS_Tracers", []];
    private _projectilesNew = [];

    // Draw projectiles if there are any
    if (count _projectiles > 0) then
    {
        // Go through all projectiles and draw their path
        {
            private _projectile = _x param [0, objNull, [objNull]];
            private _segments = _x param [1, [], [[]]];

            // Projectile may be null at this point, if so ignore
            // This will also prevent it's data from being added to next frame
            if (!isNull _projectile) then
            {
                // Calculate color depending on projectile speed
                private _speed = vectorMagnitude velocity _projectile;
                private _newColor = switch (true) do
                {
                    case (_speed < 250) : {[0,0,1,1]};
                    case (_speed < 500) : {[0,1,0,1]};
                    default {[1,0,0,1]};
                };

                // Store new segment
                _segments pushBack [getPosVisual _projectile, _newColor];

                // Clamp number of projectiles to be drawn
                if (count _segments > 50) then
                {
                    reverse _segments;
                    _segments resize 50;
                    reverse _segments;
                };

                // Go through all projectile segments and draw them
                {
                    private _nextSegmentIndex = _forEachIndex + 1;

                    if (count _segments > _nextSegmentIndex) then
                    {
                        private _locOld = _x select 0;
                        private _colorOld = _x select 1;

                        private _locNew = (_segments select _nextSegmentIndex) select 0;
                        private _colorNew = (_segments select _nextSegmentIndex) select 1;

                        drawLine3D [_locOld, _locNew, _colorNew];
                    };
                }
                forEach _segments;

                // Store projectile data for next frame
                _projectilesNew pushBack [_projectile, _segments];
            };
        }
        forEach _projectiles;
    };
    missionNamespace setVariable ["FOS_Tracers", _projectilesNew];
}];
