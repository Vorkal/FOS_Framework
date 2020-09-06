/*
    Author: 417

    Description: Get unit team color

    Parameters:
        _unit (OBJECT): Unit being checked
    Returns:
        Array - Color in ARGB format
*/

params ["_unit"];
private ["_color"];

switch (assignedTeam _unit) do {
    case ("MAIN"): {
        _color = [1,1,1,1]
    };
    case ("RED"): {
        _color = [0.9,0,0,1]
    };
    case ("BLUE"): {
        _color = [0,0.75,1,1]
    };
    case ("YELLOW"): {
        _color = [0.85,0.85,0,1]
    };
    case ("GREEN"): {
        _color = [0,0.8,0,1]
    };
    default {
        _color = [1,1,1,1]
    };
};

_color
