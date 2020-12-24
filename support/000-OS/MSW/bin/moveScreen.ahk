
;https://autohotkey.com/board/topic/43979-is-there-a-way-to-move-all-windows-to-a-specific-monitor/

WinGet, list,list,,, Program Manager

Loop, %list%
{
	  this_id := list%A_Index%
	  WinGettitle,Title,ahk_id %this_id%
    
    If ( Title = "" ) {
	continue
    }
    
    ;MsgBox, 4, , Shall I move %Title%?
    ;IfMsgBox, NO, continue

    WinMove,ahk_id %this_id%,,50,50
}