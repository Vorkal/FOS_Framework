_messageArchive = missionNameSpace getVariable ["FOS_debugSystemMessageArchive",[]];

_messageArchive joinString endl;

copyToClipboard _messageArchive
