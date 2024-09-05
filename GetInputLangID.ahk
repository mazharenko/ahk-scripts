#SingleInstance force
#Warn
#UseHook
#Requires AutoHotkey v2


GetInputLangID(hWnd := '') {
	(!hWnd) && hWnd := WinActive('A'), childPID := ''
	If WinGetProcessName(hWnd) = 'ApplicationFrameHost.exe' {
	 pid := WinGetPID(hWnd)
	 For ctl in WinGetControls(hWnd)
	  DllCall('GetWindowThreadProcessId', 'Ptr', ctl, 'UIntP', childPID)
	 Until childPID != pid
	 DetectHiddenWindows True
	 hWnd := WinExist('ahk_pid' childPID)
	}
	threadId := DllCall('GetWindowThreadProcessId', 'Ptr', hWnd, 'UInt', 0)
	lyt      := DllCall('GetKeyboardLayout', 'Ptr', threadId, 'UInt')
	Return lyt & 0x3FFF
   }

/* usage

#HotIf GetInputLangID() = 1049 ;ru


#HotIf GetInputLangID() = 1033 ;en-us


#Hotif

*/