class FOS_JipMenu
{
	idd = 999; // Display identification
	enableSimulation = 1; // 1 (true) to allow world simulation to be running in the background, 0 to freeze it
	enableDisplay = 0; // 1 (true) to allow scene rendering in the background
	class controls
	{
		class FOS_List: RscListBox
		{
			idc = 1500;

			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 17.5 * GUI_GRID_H;
		};
		class FOS_TELEPORT: RscButtonMenuOK
		{
			text = "Spawn"; //--- ToDo: Localize;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			onButtonClick = "execVM 'FOS_Framework\Dialogs\pressSpawn.sqf'";
		};
		class FOS_CANCEL: RscButtonMenuCancel
		{
			text = "Cancel";
			x = 21 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			onButtonClick = "closeDialog 2";
		};
		class FOS_Text: RscText
		{
			idc = 1001;
			text = "Choose a squad member to spawn on!"; //--- ToDo: Localize;
			sizeEx = 0.030;
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};
