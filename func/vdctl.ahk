;
; Script: vdctl.ahk
; Author: BeMacized
; Description: Provides functions for communicating with VDCTL over TCP.
;

#Include lib/AHKsock.ahk
_VDCTL_Connect()
Return

global VDCTL_Connected := false
global VDCTL_SocketId := -1

VDCTL_Send(Text)
{
    if (!global VDCTL_Connected) Return
    OutputDebug, % "[VDCTL] " "Sending " Text
    if (i := AHKsock_ForceSend(global VDCTL_SocketId, &Text, StrLen(Text) * 2)) {
        OutputDebug, % "[VDCTL] " "AHKsock_ForceSend failed with return value = " i " and error code = " ErrorLevel " at line " A_LineNumber
    }
}

_VDCTL_Connect()
{
    if (i := AHKsock_Connect("localhost", 27015, "_VDCTL_Receive")) {
        OutputDebug, % "[VDCTL] " "AHKsock_Connect() failed with return value = " i " and ErrorLevel = " ErrorLevel " Retrying..."
        Sleep, 1000
        _VDCTL_Connect()
    }
}

_VDCTL_Receive(sEvent, iSocket = 0, sName = 0, sAddr = 0, sPort = 0, ByRef bData = 0, iLength = 0)
{
    if (sEvent = "CONNECTED") {
        if (_iSocket = -1) {
            global VDCTL_Connected := false
            OutputDebug, % "[VDCTL] " "AHKsock_Connect() failed. Retrying..."
            Sleep, 1000
            _VDCTL_Connect()
        } else {
            OutputDebug, % "[VDCTL] " "Successfully connected!"
            global VDCTL_Connected := true
            global VDCTL_SocketId := iSocket
        }
    } else if (sEvent = "DISCONNECTED") {
        global VDCTL_Connected := false
        OutputDebug, % "[VDCTL] " "The server closed the connection. Retrying..."
        Sleep, 1000
        _VDCTL_Connect()
    }
}