;
; Script: window_management.ahk
; Author: BeMacized
; Description: Provides all hotkeys for managing windows
;

#SingleInstance force
#Include func/vdctl.ahk
#Include lib/windrag.ahk

; Setup
SetWinDelay, 2
CoordMode, Mouse

; Navigating to workspace
#1::VDCTL_Send("d1")
#2::VDCTL_Send("d2")
#3::VDCTL_Send("d3")
#4::VDCTL_Send("d4")
#5::VDCTL_Send("d5")
#6::VDCTL_Send("d6")
#7::VDCTL_Send("d7")
#8::VDCTL_Send("d8")
#9::VDCTL_Send("d9")
#0::VDCTL_Send("d10")

; Moving active window to workspace
#+1::VDCTL_Send("m1")
#+2::VDCTL_Send("m2")
#+3::VDCTL_Send("m3")
#+4::VDCTL_Send("m4")
#+5::VDCTL_Send("m5")
#+6::VDCTL_Send("m6")
#+7::VDCTL_Send("m7")
#+8::VDCTL_Send("m8")
#+9::VDCTL_Send("m9")
#+0::VDCTL_Send("m10")

; Maximizing
#F::
    SysGet, VirtualScreenWidth, 78
    WinGetPos, X, Y, Width, Height, A
    OutputDebug, % VirtualScreenWidth
    if (Width < VirtualScreenWidth) {
        WinMaximize, A
    } else {
        WinRestore, A
    }
Return

; Dragging
#LButton::
    MouseGetPos,,, WinUMID
    WinActivate, ahk_id %WinUMID%
    WindowMouseDragMove()
Return
; Resizing
#RButton::
    MouseGetPos,,, WinUMID
    WinActivate, ahk_id %WinUMID%
    WindowMouseDragResize()
Return

