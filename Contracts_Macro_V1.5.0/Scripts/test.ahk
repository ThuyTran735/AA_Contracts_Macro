#Requires AutoHotkey v2.0

Sleep(5000)

Send("{s down}") ; Hold "s" key down
Send("{d down}") ; Hold "d" key down
Sleep(2250)
Send("{s up}") ; Release "s" key up
Send("{d up}") ; Release "d" key up 
Sleep(200)