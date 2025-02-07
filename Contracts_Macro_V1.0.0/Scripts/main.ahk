#Requires AutoHotkey v2
#Include %A_ScriptDir%\..\Lib\FindText.ahk
#Include %A_ScriptDir%\..\Lib\OCR-main\Lib\OCR.ahk
#SingleInstance Force
#Warn

CoordMode("Pixel", "Screen")  ; Ensure pixel color coordinates are relative to the screen
CoordMode("Mouse", "Screen")  ; Ensure mouse coordinates are relative to the screen

Unit_Slot_1 := 0
Unit_Slot_2 := 0
Unit_Slot_3 := 0
Unit_Slot_4 := 0
Unit_Slot_5 := 0
Unit_Slot_6 := 0

; Create the main GUI with dark theme
main := Gui("-Caption +AlwaysOnTop")
main.BackColor := "1E1E1E"  ; Dark background color
main.SetFont("s10 norm cFFFFFF", "Segoe UI")  ; White text for contrast

; Add a dark border around the GUI main
border_main := main.Add("Text", "x0 y0 w300 h310 Background333333")  ; Dark gray border
main.Add("Text", "x5 y5 w290 h300 Background1E1E1E")  ; Inner dark background

; Create the options GUI with dark theme
options := Gui("-Caption +AlwaysOnTop")
options.BackColor := "1E1E1E"  ; Dark background color
options.SetFont("s10 norm cFFFFFF", "Segoe UI")  ; White text for contrast

; Create the readme GUI with no title bar or border
readme := Gui("-Caption +AlwaysOnTop")
readme.BackColor := "1E1E1E"  ; Dark background color

; Add a dark border around the GUI readme
border_readme := readme.Add("Text", "x0 y0 w800 h790 Background333333")  ; Dark gray border
readme.Add("Text", "x5 y5 w790 h780 Background1E1E1E")  ; Inner dark background

; Set default font
readme.SetFont("s10 norm", "Segoe UI")

; Add macro version and "Made by Thuy" at the top
readme.SetFont("s16 Bold cFFFFFF", "Segoe UI")  ; White text for contrast
readme.Add("Text", "x30 y20 w740 h40", "Contracts Macro V1.0.0")

readme.SetFont("s12 norm cBBBBBB", "Segoe UI")  ; Light gray text
readme.Add("Text", "x30 y60 w740 h20", "Made by Thuy")

; Add a title
readme.SetFont("s20 Bold cFFFFFF", "Segoe UI")  ; White text for contrast
readme.Add("Text", "x30 y100 w740 h40", "Game Settings:")

; Graphics Settings
readme.SetFont("s14 Bold cDDDDDD", "Segoe UI")  ; Light gray text
readme.Add("Text", "x30 y150 w740 h30", "Graphics Settings:")
readme.SetFont("s10 norm cBBBBBB", "Segoe UI")  ; Slightly lighter gray for body text
readme.Add("Text", "x50 y180 w700 h20", "• Set to 1.")

; Camera Settings
readme.SetFont("s14 Bold cDDDDDD", "Segoe UI")
readme.Add("Text", "x30 y210 w740 h30", "Camera Settings:")
readme.SetFont("s10 norm cBBBBBB", "Segoe UI")
readme.Add("Text", "x50 y240 w700 h20", "• Sensitivity: 0.52")
readme.Add("Text", "x50 y270 w700 h20", "• Mode: Default (Classic)")

; Movement Settings
readme.SetFont("s14 Bold cDDDDDD", "Segoe UI")
readme.Add("Text", "x30 y300 w740 h30", "Movement Settings:")
readme.SetFont("s10 norm cBBBBBB", "Segoe UI")
readme.Add("Text", "x50 y330 w700 h20", "• Mode: Default (Classic)")

; Menu Settings
readme.SetFont("s14 Bold cDDDDDD", "Segoe UI")
readme.Add("Text", "x30 y360 w740 h30", "Menu Settings:")
readme.SetFont("s10 norm cBBBBBB", "Segoe UI")
readme.Add("Text", "x50 y390 w700 h20", "• Roblox Menu: Set to ESC")
readme.Add("Text", "x50 y420 w700 h20", "• Roblox Player Menu: Set to TAB")

; Gameplay Settings
readme.SetFont("s14 Bold cDDDDDD", "Segoe UI")
readme.Add("Text", "x30 y450 w740 h30", "Gameplay Settings:")
readme.SetFont("s10 norm cBBBBBB", "Segoe UI")
readme.Add("Text", "x50 y480 w700 h20", "• Auto-Skip Waves: On")
readme.Add("Text", "x50 y510 w700 h20", "• Disable Auto-Open Upgrade UI: Off")
readme.Add("Text", "x50 y540 w700 h20", "• Show Upgrade UI on Left: On")

; Display Settings
readme.SetFont("s14 Bold cDDDDDD", "Segoe UI")
readme.Add("Text", "x30 y570 w740 h30", "Display Settings:")
readme.SetFont("s10 norm cBBBBBB", "Segoe UI")
readme.Add("Text", "x50 y600 w700 h20", "• Change display to 1920 x 1080 resolution")
readme.Add("Text", "x50 y630 w700 h20", "• Set display scale to 100%")
readme.Add("Text", "x50 y660 w700 h20", "• If you have HDR or Night Mode enabled, turn it off.")

; Checkbox
Checkbox9 := readme.Add("Checkbox", "x30 y690 w300 h30", "Never Show This Again")
Checkbox9.SetFont("s10 norm cDDDDDD", "Segoe UI")  ; Light gray text for checkbox

; Custom Buttons
; Done Button
DoneButton := readme.Add("Text", "x30 y730 w300 h40 Background333333 cFFFFFF Center 0x200", "Done")
DoneButton.SetFont("s10 Bold", "Segoe UI")
DoneButton.OnEvent("Click", (*) => (
    readme.Hide(),
    main.Show("w300 h310 x1610 y50"),
    Unit_GUI_Save()
))

; Close Button
CloseButton := readme.Add("Text", "x470 y730 w300 h40 Background333333 cFFFFFF Center 0x200", "Close Macro")
CloseButton.SetFont("s10 Bold", "Segoe UI")
CloseButton.OnEvent("Click", (*) => (
    Unit_GUI_Save(),
    ExitApp()
))

; Start Button
StartButton := main.Add("Text", "x10 y270 w100 h30 Background333333 cFFFFFF Center 0x200", "Start (Ctrl+F4)")
StartButton.SetFont("s10 Bold", "Segoe UI")
StartButton.OnEvent("Click", (*) => (
    Unit_GUI_Save(),
    Send("{Ctrl Down}{F4}{Ctrl Up}")
))

; Stop Button
StopButton := main.Add("Text", "x120 y270 w100 h30 Background333333 cFFFFFF Center 0x200", "Stop (Ctrl+F3)")
StopButton.SetFont("s10 Bold", "Segoe UI")
StopButton.OnEvent("Click", (*) => (
    Unit_GUI_Save(),
    ExitApp()
))

; Options Button
OptionsButton := main.Add("Text", "x230 y270 w60 h30 Background333333 cFFFFFF Center 0x200", "Options")
OptionsButton.SetFont("s10 Bold", "Segoe UI")
OptionsButton.OnEvent("Click", (*) => (
    OpenOptions(),
    Unit_GUI_Save()
))

main.Add("Text", "x10 y250 w200 h20 cFFFFFF", "Made By Thuy | V1.0.0")

; Add 6 checkboxes with corresponding dropdowns next to them
main.Add("Text", "x10 y10 w150 h20 cFFFFFF", "Enable Slot")
main.Add("Text", "x170 y10 w120 h20 cFFFFFF", "Placement Amount")

Checkbox1 := main.Add("Checkbox", "x10 y30 w190 h20 cFFFFFF Checked", "Unit Slot 1 (Use C.E.O.)")
Dropdown1 := main.Add("DropDownList", "x225 y30 w50 h20 Background333333 cFFFFFF r6", ["1", "2", "3", "4", "5", "6"])

Checkbox2 := main.Add("Checkbox", "x10 y60 w190 h20 cFFFFFF", "Unit Slot 2")
Dropdown2 := main.Add("DropDownList", "x225 y60 w50 h20 Background333333 cFFFFFF r6", ["1", "2", "3", "4", "5", "6"])

Checkbox3 := main.Add("Checkbox", "x10 y90 w190 h20 cFFFFFF", "Unit Slot 3")
Dropdown3 := main.Add("DropDownList", "x225 y90 w50 h20 Background333333 cFFFFFF r6", ["1", "2", "3", "4", "5", "6"])

Checkbox4 := main.Add("Checkbox", "x10 y120 w190 h20 cFFFFFF", "Unit Slot 4")
Dropdown4 := main.Add("DropDownList", "x225 y120 w50 h20 Background333333 cFFFFFF r6", ["1", "2", "3", "4", "5", "6"])

Checkbox5 := main.Add("Checkbox", "x10 y150 w190 h20 cFFFFFF", "Unit Slot 5")
Dropdown5 := main.Add("DropDownList", "x225 y150 w50 h20 Background333333 cFFFFFF r6", ["1", "2", "3", "4", "5", "6"])

Checkbox6 := main.Add("Checkbox", "x10 y180 w190 h20 cFFFFFF Checked", "Unit Slot 6 (Use A Hill Unit)")
Dropdown6 := main.Add("DropDownList", "x225 y180 w50 h20 Background333333 cFFFFFF r6", ["1", "2", "3", "4", "5", "6"])

; Check if the settings file exists
if !FileExist("..\Settings\settings.ini") {
    ; Create a new settings.ini file with default values
    IniWrite("0", "..\Settings\settings.ini", "Show", "Read_Me")

    IniWrite("1", "..\Settings\settings.ini", "Units", "Slot_1")
    IniWrite("0", "..\Settings\settings.ini", "Units", "Slot_2")
    IniWrite("0", "..\Settings\settings.ini", "Units", "Slot_3")
    IniWrite("0", "..\Settings\settings.ini", "Units", "Slot_4")
    IniWrite("0", "..\Settings\settings.ini", "Units", "Slot_5")
    IniWrite("1", "..\Settings\settings.ini", "Units", "Slot_6")

    IniWrite("3", "..\Settings\settings.ini", "Placements", "Dropdown1")
    IniWrite("0", "..\Settings\settings.ini", "Placements", "Dropdown2")
    IniWrite("0", "..\Settings\settings.ini", "Placements", "Dropdown3")
    IniWrite("0", "..\Settings\settings.ini", "Placements", "Dropdown4")
    IniWrite("0", "..\Settings\settings.ini", "Placements", "Dropdown5")
    IniWrite("0", "..\Settings\settings.ini", "Placements", "Dropdown6")
}

; Define the function to open the options tab
OpenOptions() {
    global options

    options := Gui("-Caption +AlwaysOnTop", "Options")
    options.BackColor := "1E1E1E"  ; Dark background color

    ; Add a dark border around the GUI options
    border_options := options.Add("Text", "x0 y0 w300 h310 Background333333")  ; Dark gray border
    options.Add("Text", "x5 y5 w290 h300 Background1E1E1E")  ; Inner dark background

    options.SetFont("s10 norm cFFFFFF", "Segoe UI")  ; White text for contrast

    ; Close_2 Button
    CloseButton_2 := options.Add("Text", "x10 y270 w100 h30 Background333333 cFFFFFF Center 0x200", "Close")
    CloseButton_2.SetFont("s10 Bold", "Segoe UI")
    CloseButton_2.OnEvent("Click", (*) => (
        options.Hide(),
        Unit_GUI_Save()
    ))

    ; Show the GUI
    options.Show("w300 h310 x1610 y50")
}

Checkbox9.Value := IniRead("..\Settings\settings.ini", "Show", "Read_Me")

Checkbox1.Value := IniRead("..\Settings\settings.ini", "Units", "Slot_1")
Checkbox2.Value := IniRead("..\Settings\settings.ini", "Units", "Slot_2")
Checkbox3.Value := IniRead("..\Settings\settings.ini", "Units", "Slot_3")
Checkbox4.Value := IniRead("..\Settings\settings.ini", "Units", "Slot_4")
Checkbox5.Value := IniRead("..\Settings\settings.ini", "Units", "Slot_5")
Checkbox6.Value := IniRead("..\Settings\settings.ini", "Units", "Slot_6")

Dropdown1.Value := IniRead("..\Settings\settings.ini", "Placements", "Dropdown1")
Dropdown2.Value := IniRead("..\Settings\settings.ini", "Placements", "Dropdown2")
Dropdown3.Value := IniRead("..\Settings\settings.ini", "Placements", "Dropdown3")
Dropdown4.Value := IniRead("..\Settings\settings.ini", "Placements", "Dropdown4")
Dropdown5.Value := IniRead("..\Settings\settings.ini", "Placements", "Dropdown5")
Dropdown6.Value := IniRead("..\Settings\settings.ini", "Placements", "Dropdown6")

Unit_GUI_Save() 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6, Checkbox9
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    if (Checkbox1.Value) {
        Unit_Slot_1 := Dropdown1.Value
    } else {
        Unit_Slot_1 := 0
    }
    if (Checkbox2.Value) {
        Unit_Slot_2 := Dropdown2.Value
    } else {
        Unit_Slot_2 := 0
    }
    if (Checkbox3.Value) {
        Unit_Slot_3 := Dropdown3.Value
    } else {
        Unit_Slot_3 := 0
    }
    if (Checkbox4.Value) {
        Unit_Slot_4 := Dropdown4.Value
    } else {
        Unit_Slot_4 := 0
    }
    if (Checkbox5.Value) {
        Unit_Slot_5 := Dropdown5.Value
    } else {
        Unit_Slot_5 := 0
    }
    if (Checkbox6.Value) {
        Unit_Slot_6 := Dropdown6.Value
    } else {
        Unit_Slot_6 := 0
    }

    IniWrite(Checkbox9.Value, "..\Settings\settings.ini", "Show", "Read_Me")

    IniWrite(Checkbox1.Value, "..\Settings\settings.ini", "Units", "Slot_1")
    IniWrite(Checkbox2.Value, "..\Settings\settings.ini", "Units", "Slot_2")
    IniWrite(Checkbox3.Value, "..\Settings\settings.ini", "Units", "Slot_3")
    IniWrite(Checkbox4.Value, "..\Settings\settings.ini", "Units", "Slot_4")
    IniWrite(Checkbox5.Value, "..\Settings\settings.ini", "Units", "Slot_5")
    IniWrite(Checkbox6.Value, "..\Settings\settings.ini", "Units", "Slot_6")

    IniWrite(Dropdown1.Value, "..\Settings\settings.ini", "Placements", "Dropdown1")
    IniWrite(Dropdown2.Value, "..\Settings\settings.ini", "Placements", "Dropdown2")
    IniWrite(Dropdown3.Value, "..\Settings\settings.ini", "Placements", "Dropdown3")
    IniWrite(Dropdown4.Value, "..\Settings\settings.ini", "Placements", "Dropdown4")
    IniWrite(Dropdown5.Value, "..\Settings\settings.ini", "Placements", "Dropdown5")
    IniWrite(Dropdown6.Value, "..\Settings\settings.ini", "Placements", "Dropdown6")

    return
}

; Get the directory of the current script
ScriptDir := A_ScriptDir

return_check := 0
reconnect_check := 0
wrong_map := 0

; Show the GUI based on checkbox value
if Checkbox9.Value == 0 {
    readme.Show("w800 h790")
} else {
    readme.Hide(),
    main.Show("w300 h310 x1610 y50")
}

; Function to send click at specified coordinates
SendClick(x, y)
{
    ; Move the mouse slightly before the main move
    MouseMove(x + 5, y + 5)
    Sleep(100)  ; Short delay to ensure Roblox detects the move
    MouseMove(x, y)  ; Move to the target position
    Sleep(100)  ; Optional delay for stability
    Click("Left", "Down")  ; Press down
    Sleep(50)  ; Hold down for a moment
    Click("Left", "Up")    ; Release
    Sleep(100)  ; Delay after the click
}

; Function to send click at specified coordinates
SendClick_R(x, y)
{
    ; Move the mouse slightly before the main move
    MouseMove(x + 5, y + 5)
    Sleep(100)  ; Short delay to ensure Roblox detects the move
    MouseMove(x, y)  ; Move to the target position
    Sleep(100)  ; Optional delay for stability
    Click("Right", "Down")  ; Press down
    Sleep(50)  ; Hold down for a moment
    Click("Right", "Up")    ; Release
    Sleep(100)  ; Delay after the click
}

Go_Lobby()
{
    SendClick(1714, 20)
    Sleep(200)
    
    SendClick(45, 1055)
    Sleep(200)
    SendClick(960, 310)
    Sleep(200)
    Loop 15 {
        Send("{WheelUp}")
        Sleep(100)
    }
    Loop 7 {
        Send("{WheelDown}")
        Sleep(100)
    }
    Sleep(500)
    SendClick(1195, 753)
    Sleep(200)
    SendClick(1305, 232)
}

Go_Spawn() 
{
    Loop {
        if (ImagesFound_Yes()) {
            break
        }
    }
    Sleep(100)
    SendClick(45, 1055)
    Sleep(200)
    SendClick(960, 310)
    Sleep(200)
    Loop 7 {
        Send("{WheelDown}")
        Sleep(100)
    }
    Sleep(500)
    SendClick(1195, 659)
    Sleep(200)
    SendClick(1305, 232)
    Sleep(200)
    Send("{Tab}")
    Sleep(200)

    Loop 10 {
        Send("{i down}") ; Hold "i" key down
        Sleep(100)
        Send("{i up}") ; Hold "o" key up
    }
    Sleep(500)
    ; Move the mouse down 700 pixels
    MouseMove(960, 600)

    Loop 10 {
        Send("{o down}") ; Hold "o" key down
        Sleep(100)
        Send("{o up}") ; Hold "o" key up
    }
}

Find_Maps()
{
    Loop {
        if (!ImageFound_finding_game_x()) {
            Loop {
                ImageFound_contracts()
                
                if (ImageFound_contracts_x()) {
                    break 
                }
                if (!ImageFound_contracts()) {
                    break 
                }
            }

            SendClick(1278, 737)
        }
        if (ImageFound_unit()) {
            Unknown_Map()
            break
        }
        if (ImageFound_snowy_town()) {
            Snowy_Town()
            break
        }
        if (ImageFound_sand_village()) {
            Sand_Village()
            break
        }
        if (ImageFound_navy_bay()) {
            Navy_Bay()
            break
        }
        if (ImageFound_fiend_city()) {
            Fiend_City()
            break
        }
        if (ImageFound_spirit_world()) {
            Spirit_World()
            break
        }
        if (ImageFound_ant_kingdom()) {
            Ant_Kingdom()
            break
        }
        if (ImageFound_magic_town()) {
            Magic_Town()
            break
        }
        if (ImageFound_haunted_academy()) {
            Haunted_Academy()
            break
        }
        if (ImageFound_magic_hills()) {
            Magic_Hills()
            break
        }
        if (ImageFound_space_center()) {
            Space_Center()
            break
        }
        if (ImageFound_alien_spaceship()) {
            Alien_Spaceship()
            break
        }
        if (ImageFound_fabled_kingdom()) {
            Fabled_Kingdom()
            break
        }
        if (ImageFound_ruined_city()) {
            Ruined_City()
            break
        }
        if (ImageFound_puppet_island()) {
            Puppet_Island()
            break
        }
        if (ImageFound_virtual_dungeon()) {
            Virtual_Dungeon()
            break
        }
        if (ImageFound_snowy_kingdom()) {
            Snowy_Kingdom()
            break
        }
        if (ImageFound_dungeon_throne()) {
            Dungeon_Throne()
            break
        }
        if (ImageFound_mountain_temple()) {
            Mountain_Temple()
            break
        }
        if (ImageFound_rain_village()) {
            Rain_Village()
            break
        }
        if (ImageFound_storm_hideout()) {
            Storm_Hideout()
            break
        }
        if (ImageFound_haunted_mansion()) {
            Haunted_Mansion()
            break
        }
        if (ImageFound_nightmare_train()) {
            Nightmare_Train()
            break
        }
        if (ImageFound_future_city()) {
            Future_City()
            break
        }
        if (ImageFound_walled_city()) {
            Walled_City()
            break
        }
        if (ImageFound_cursed_festival()) {
            Cursed_Festival()
            break
        }
        if (ImageFound_spirit_town()) {
            Spirit_Town()
            break
        }
        if (ImageFound_hellish_city()) {
            Hellish_City()
            break
        }
        if (ImageFound_strange_town()) {
            Strange_Town()
            break
        }
        if (ImageFound_planet_greenie()) {
            Planet_Greenie()
            break
        }
    }
}

ImageFound_finding_game_x()
{
    x:="|<>**50$39.1s000w0zU00DsC60033XUM00kCM1U0A0q0603U3E0s0s0O03UC03M0C3U0nU0sM0CC03603Us0BU0s3U0s0C0C0301U0k000M03000600A001U00k00M003007000Q01k001k0Q000Q01k007007000k00Q00A001U03000600k000M0A0701U3U0w060s0BU0sC03603XU0kM0CM0C1U0m03UC03E0s0s0O0C03U3M1U0A0nUM00kCC60033UzU00Ds1s000w4"

    if (ok:=FindText(&X, &Y, 1296-150000, 142-150000, 1296+150000, 142+150000, 0, 0, x))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_upgrade_num()
{
    Num5:="|<>**50$117.S1s00000000Dk00TvzzzsTU00000001a0021zy3X6A000000008k00EA0kQMlU0000000160023U63X6A000000008kQ0Fw0wQMlzwDzzxzwz6Tw293wXX6AFnWAMwNi8r1kF8T4QMlU3k1U70DU7U62/0sXX6A0C0A0k1s0w0MFM1YQMlUVVVVwAC273X2/06XX6ACASATXllsswMFMEoQAlXlXlXASCD70329z6XlwACAQANXllssTkFDsoS73U1U1XA0C073y2/66XM0Q0S0AMk1s0w0kFM0oP06U7s1X70DU7U22/0AXC3YTnyAMQNiAr0kFC3YMzsXwTly1zwzyTy2AzkX004M60A00000000Fs0wM00X0k30000000021063004M60s00000000E80kM00r0TS0000000033067007k0z000000000Ts0To"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Num5))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_unit_placed()
{
    X:="|<>**50$28.4U04UzU0zbC07jsQ0sD0s3UQ1kQ1k3XU5U6Q0r0BU6C0Q0kQ1U70s00s1U070300s060700A0M01k1k0C03U1k060C00A1k20MC0Q0kk3s1a0Rk3k3XUD0Q60Q3UA1sA0MBlU0ls"
    Spectate:="|<>**50$40.M00000N000000g000003U000006000000M000001U07zU0601k3k0M0Q01k1U7003U60k7s30M60uk61Uk7dUA660sX0MMk3X40lU087E1600U100Mk3UQ0lVUC1k6630SS0kM60tk61UA1y0k60M00C0M0M01U1U0w0s0600Ty00M000001U000006000000Q000003E000009U00001X00000AU"
    First:="|<>**50$60.000y0000007zzz000000TzzzU000z0TzzXU001zUw013U003zUs013U003Vks01XzwTnVss01yzzzzVQsTzzzzzzVysTtXX7UC0CsTx303060Cs0B3030C07s0B3067y0Cs0B31y7zVys0B33T0RVwsTt33z07VMsTz33Zk7VwsTr33by7VwsQ733jD7UCsQ733i06UCsQ733i0CkCQw3bbjUTwSTs3zz7zyzwDs1zz1zsTs3U0QQ0TU3UU"
    Attack:="|<>**50$33.0T3q7sQ0101A00s0C00C01001U0800Q01s07008s0k000kA00033U01U"

    if (ok:=FindText(&X, &Y, 550-150000, 353-150000, 550+150000, 353+150000, 0, 0, X)) || (ok:=FindText(&X, &Y, 503-150000, 389-150000, 503+150000, 389+150000, 0, 0, Spectate)) || (ok:=FindText(&X, &Y, 91-150000, 660-150000, 91+150000, 660+150000, 0, 0, First)) || (ok:=FindText(&X, &Y, 108-150000, 301-150000, 108+150000, 301+150000, 0, 0, Attack))
    {
        return true
    }
    else
    {
        return false
    }
}

; Function to check if both images are found on the screen within the specified region
ImagesFound_Return()
{
    Return_To_Lobby:="|<>**50$266.00000000000000000000000000003s0000Q003U0000000000000000000000000000000001z0000Tk03y000001zzk0000000000000000000000000ss000CC01lk00000zzz0000Ds000000000000Tk00000A600031U0MA00000A00s0003z0000000000007y0000031U000kM0630000030070001Uk0000000000031U00000kM000A601Uk00000k00M000MA000000000000kM00000A600031U0MA00000A00700061000000000000A20000031U000kM063000003000k001UE0000000000030U00000kM000A601Uk00000kDUA7zUs7lw1yDbsyTU01kDUDy00A60Tw31z0MDs0y0zA7y1bvwS1zzUzzzzzzy00w3wDrs031UTjkkTw63zUzkDv1VUPU3g01sAMD1UQ61k0M03b0700kMC0CA63lUkSQA67kMM7k0D00C363k0710C0600PU0s0A6701n00CM01q1VUw661k01k03UlUQ01k01k1U07k07031XU0Ck01a00BUMkD1zUQ00Q00sAM700Q00A0M01M00k0kMk01g00BU01s3A3kTk60E300C361k07001U600Q0060A6M00D003M00P0q1g003UT0y1zUlUQ1rk20M1w3z0Q1U31a0s3k20S0E3s7UP000kDkDUTMAM70zg3s60D0zUDkA0kN0TUQ3s7UT0q0k6U"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Return_To_Lobby))
    {
        return true
    }
    else
    {
        return false
    }
}

; Function to check if both images are found on the screen within the specified region
ImagesFound_Return_2()
{
    Return_To_Lobby:="|<>**50$266.00000000000000000000000000003s0000Q003U0000000000000000000000000000000001z0000Tk03y000001zzk0000000000000000000000000ss000CC01lk00000zzz0000Ds000000000000Tk00000A600031U0MA00000A00s0003z0000000000007y0000031U000kM0630000030070001Uk0000000000031U00000kM000A601Uk00000k00M000MA000000000000kM00000A600031U0MA00000A00700061000000000000A20000031U000kM063000003000k001UE0000000000030U00000kM000A601Uk00000kDUA7zUs7lw1yDbsyTU01kDUDy00A60Tw31z0MDs0y0zA7y1bvwS1zzUzzzzzzy00w3wDrs031UTjkkTw63zUzkDv1VUPU3g01sAMD1UQ61k0M03b0700kMC0CA63lUkSQA67kMM7k0D00C363k0710C0600PU0s0A6701n00CM01q1VUw661k01k03UlUQ01k01k1U07k07031XU0Ck01a00BUMkD1zUQ00Q00sAM700Q00A0M01M00k0kMk01g00BU01s3A3kTk60E300C361k07001U600Q0060A6M00D003M00P0q1g003UT0y1zUlUQ1rk20M1w3z0Q1U31a0s3k20S0E3s7UP000kDkDUTMAM70zg3s60D0zUDkA0kN0TUQ3s7UT0q0k6U"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Return_To_Lobby))
    {
        Loop 4 {
            SendClick(X, Y)
            Sleep(500)
        }
        return true
    }
    else
    {
        return false
    }
}

ImageFound_retry()
{
    Retry:="|<>**50$108.Dzy000000000000000Tzzk00003w00000000s01s00007y00000000k00Q0000A700000000k0060000A300000000k0030000A300000000k003U000A300000000k001U000A300000000k7k1UDy0Q3sD3sD03skDw0kzzVw3yzzyzU7wkDy0nk3nU07kw7lkCCkA60r00v003UM3UkA3kA70y00T003U030MQ3kA60w00D003U030QM3kDy0s007003U03UAM3kDw0k007003U03UCk6k001k3s7U07U77k7k6k001k7M3w3zUDyk3UCk003UDs3Q3tUAsM3UAk006U007A31UM0M10QU"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Retry))
    {
        SendClick(X,Y)
        return true
    }
    else
    {
        return false
    }
}

ImageFound_next_room()
{
    NextRoom:="|<>**50$209.Dk07s0000000000007zz000000000000000zk0Ts00000000TU00Tzzk00000000000003Uk1Uk00000001zU01k03k000000000000060k30k000000063U03001k0000000000000A1kA1U0000000A3006000k0000000000000M1UM300000000M600A000k0000000000000k1Uk600000000kA00M001k0000000000001U1VUA00000001UM00k001U000000000000303X0M1zk1k0w70y01UDU30Ts00Ts0D3s3k60360kDzsDs3wy1z030zk33zw03zw1zzwTsA03A1Vs1sssCDU06061zk6S0S0S0S73kzkwM07M3700tUssC0060A31UBk0C1k0CA30S0Qk07k6Q00y0vUQ00A0M63UT00C700CM40M0NU06UBk00w0y0M00M0kA60g00CQ00Ck0000P0070P000s0s1k00k1UTw1k00Ak00BU0000q1UC0w001s0U3U01U30zk3000D000D00000w3UA1M1w3M00DU0606000C0A0S0A0S00001s7082k7M3s00ns7w0A000Q1y0w1y0w1s1s3U"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, NextRoom))
    {
        SendClick(X,Y)
        return true
    }
    else
    {
        return false
    }
}

ImageFound_contracts()
{
    Contracts:="|<>**50$23.i001s07X007q801cw01UA030A060AUB0FUn0Vle31wO000r001U003000A"
    Contracts2:="|<>**50$68.zk007U0007UAC003s0003s01U00m0000m06TxzwzzzTwzrzXmS39mSC3VbkQ3UkM71UkEMX4MwQ1WMwqSQnbDDCNzD1zbAtnnnaTnsU"

    if (ok:=FindText(&X, &Y, 68-150000, 693-150000, 68+150000, 693+150000, 0, 0, Contracts)) || (ok:=FindText(&X, &Y, 71-150000, 718-150000, 71+150000, 718+150000, 0, 0, Contracts2))
    {
        SendClick(X,Y)
        return true
    }
    else
    {
        return false
    }
}

ImageFound_contracts_x()
{
    Contracts_X:="|<>**50$55.0y00000DU1zk0000Ts1kQ0000Q71k70000Q1lk1k000Q0Qk0Q000Q06k06000Q01s01U00A00s00M00A00S00600A00D003U0A007k00s0C006M00C0C0076003UC0031U00kC0030M00A600306003600303U00q00300s00S003U0C007003U03U00003U00s00003U00A00003U00300001U000k0001U000A0001U00030001U0000k001U0000Q001U00007001k00003000M000030006000030001U00030000M000300006000300003U003U0000s003U0000C003U00003U03U01k00s03U00s00A01U00q00301U00lU00k1U00kM00A1U00kC0031U00s3U00lk00s0s00Qk00s0A006k00M03001s00M00k00s00M00A00S00M00300D00Q001k07k0Q000Q06Q0Q00070770Q0001k71kQ0000Q70Tw00007z03s00001y1"

    if (ok:=FindText(&X, &Y, 1502-150000, 205-150000, 1502+150000, 205+150000, 0, 0, Contracts_X))
    {
        SendClick(X,Y)
        return true
    }
    else
    {
        return false
    }
}

ImageFound_cancel()
{
    Cancel:="|<>**50$148.00000000000000000000007y000D0000000000000000000ss00Dzs0000000000000000030k07k3s000000000000000008301s01s00000000000000000UA0C001k000000000000000020k1k003U0000000000000000830C000600000000000000000UA1U000M000000000000000020kC0001U0000000000000000830k060A00000000000000000UA603z0k3yDsTlz003zk07zs20kM0wDC0zzznzzz00y7s1w3s831070Dk70Q3A3UC0701kS01kUAA0s000k0E4U80A1k03XU03W0kk30006000G000M6006Q0078330M000k0018000kk009U00AUA81U0060004U0036000g000G0kU6000M000G0006M006k001c320E00300018000P000S0DU7UA81U00A0S04U3s0w0T3M1r0S0kk6000k3w0G0Tk3k3zxU7w1s330M0030MM181XUC0MTa0zU7UAA0k0081VU4UA60s1U0E000O0kk3U00U660G0kM3U6010001c31070Dn0MM1831UC0MD4000AUA60D1ng0z04UA60w0nyM1zzW0kM0Dy7k1s0G0kM3k1wRUDzw81sk0D0D0001831UD000y0TzsU7nU000S0004UA60q001g0TVW0360001s000G0kM3M002k003804C0006k001831UAk00/U00Ak0EQ000tU004UA60nU01a000n010s0077000G0kM37006A003A041s01sD0A3831UAD01kQ00QM0k1w0S0DbwQsw3XUD0S0w07Uw301zzU0TxzVzU7y0DzU0zzw1zs00Tk000000000000000Ty0008"

    if (ok:=FindText(&X, &Y, 1132-150000, 695-150000, 1132+150000, 695+150000, 0, 0, Cancel))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_unit()
{
    Unit:="|<>**50$93.00000C0003U0000000001U000A000000000080000U0000000003000060000000000M0000k000000000600003000000000TU0000Tk0000007zk00000Tz00003zw00000001zy00zz00000000007zsS00000000000003n000000000000006k00000000000000S000000000000003k00000000000000S000000000000003M00000000000000nU0000000000000CC00000000000003Us0000000000000s3U000000000000C0C0000000000003U0s000000000000s03U00000000000C00C000000000003U00s00000000000s003U0000000000C000C00000000003U000s0000000000s0003U000000000C00006000000000300000s000000000s00001U00000000C000006000000003000000s00000000s000001U0000000A000000A00000001U000001U0000000A000000A00000001U000001U0000000A000000800000000U000001000000004000000M00000000k000003000000006000000M00000000k000002000000002000000E00000000E000002000000002000000k00006000M00000600003y003000000zk000zs008000zU7z000D7bw1000Dy0Tw001kRzk8001Uk63U00C3jT1000A60kA00DkRUsA001Uk61k03a3A31U00A60kC01kssUMA001Uk21zbs3zI3sU00A60EDzy0DjUTZzs1Uk21zzy3yw3zzjkA60EC30skQ01i071Uk21kE3a3U05U0MA60EC00CkQ00s031Uk21k00q3U0700MA60EC003kQ00sDa1Uk61k20S3w3z1zUA60kC1w3kTUTs1w1UE61kBkS3A2301kA30kC361kNUEA031UMA3kMkC3A21k0M41nUS361kNUE7010k7s3kMkC3A3tzU86000q361kMU7Mz10M00CkMkC340D0k83U01a361kMk1k010C00MkMkC360C00M0s0C6363kMM1s0703k7UssMz71sPs3k07zs3y3yTk7z7zw4"

    if (ok:=FindText(&X, &Y, 97-150000, 469-150000, 97+150000, 469+150000, 0, 0, Unit))
    {
        return true
    }
    else
    {
        return false
    }
}

ImagesFound_Yes()
{
    Yes:="|<>**50$39.60M0003s7k000tVb0006CMM000kn300063kzs7sMS7znznVVs7s7A8S0S0Mk3U1U770sAATkMD3lUy1Vs0C0sA/01s31VMTzsMA93vrX1Vg0A0MA9k1U31n70T1k7sTyTw0A0T0y4"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Yes))
    {
        return true
    }
    else
    {
        SendClick(971, 930)
        return false
    }
}

ImagesFound_Yes_2()
{
    Yes:="|<>**50$39.60M0003s7k000tVb0006CMM000kn300063kzs7sMS7znznVVs7s7A8S0S0Mk3U1U770sAATkMD3lUy1Vs0C0sA/01s31VMTzsMA93vrX1Vg0A0MA9k1U31n70T1k7sTyTw0A0T0y4"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Yes))
    {
        SendClick(X, Y)
        SendClick(X, Y)
        SendClick(X, Y)
        return true
    }
    else
    {
        return false
    }
}

ImagesFound_Yes_3()
{
    Yes:="|<>**50$39.60M0003s7k000tVb0006CMM000kn300063kzs7sMS7znznVVs7s7A8S0S0Mk3U1U770sAATkMD3lUy1Vs0C0sA/01s31VMTzsMA93vrX1Vg0A0MA9k1U31n70T1k7sTyTw0A0T0y4"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Yes))
    {
        return true
    }
    else
    {
        return false
    }
}

; Function to check if both images are found on the screen within the specified region
ImageFound_unit_maxed()
{
    Maxed:="|<>**50$81.Dw00Ts00000003zk07zU0000000zz01zy000000070s0C1k0000000s3U3UC000000070S0w1k0000000s1sD0C00000007073k1k31sD07Us0QQ0C7zzny1z703rU1lzzzzsTws0Ds0CT7kr7bXr00q01rU42kTsCs03U0Ds00Q1y1r00Q01i003U7U7s400EBU00Q0M1r0k061s002k00Ss601kD0A0L007b0s0C1s7s2Q01sU"

    Max_:="|<>**50$47.y1z3wDkSC366MMlkAAAMMkr0AkMklUw0DUn0lUkUS1a1VV30M3M1VU6816lX3UMM6D3331ksAS66A1lkss06k1Xnlk0DVV6zX3wC7UA367wMT0M6AMMln4k4MUNb3D0Dz0zw3k"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Maxed)) && (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Max_))
    {
        SendClick(552, 354)
        return true
    }
    else
    {
        return false
    }
}

ImageFound_mansion()
{
    Mansion1:="|<>**50$329.00000003y3s00003s0000000000000000000000000007k0000000000000000TyTw0000Tw000000000000000000000000000zs000000000zU00003UAkM0000UM000000000zU00Ds0000000000010k000000003bU0000C090E00010EDk0000003rU01ts0000000000020U000000004100000M0G0U00060Uzs00000041U030k00000000000A1000000000M200001U0Y10000A130k000000M3U0A0U00000000000M2000000000k40000201820000M261U000000k300k1000000000000k4000000001U80000A02E40000EAA10000001U303U2000000000000UM0000000030E0000M0Qss0000ssM20000003030604000000000001lk0000000060U0000k7lzU0000zUk40000006070M08000000000001z000000000A100001U8000000001U81sED00A061U0E000000000zU0003y000000M2TvzUD0TryDxzk7yT0TjsVzU0M06700U7yznzTw0DzwDw0zzUDxzk0k4kS3Uk01g6MD1kA6k01sM31U0k06A010wD1a3kQ1s0QMA3U3UMD1k1U90E1l001E4U80sE5001UMC1U1U0Ck023U41c20C300AU8A01kU80s30K001a002U/000lUC0020sM3U300D004A003k00AA00P0Ek01n000k60g001g0050K000n0Q0040tk7E600A008k007U00AE00q0X001a000kA1M001s00+0g000q0s0081n0C0A00800H000D000AU01g1A001g000ls2k003k00I1M001g1k00M1y0M0M20060a000S000N0S6M2M001s001kk5U002k01c2k001M2U01s1w1k0k600Q1M000w000G1zwk5U003k001VU/07U7w1zE5U3k3k5w1zk3k301UC00s2k3k1s0w0o1zlU/0DU7U3k330K0TUAM20U/0Dk7U8M20k3UC030Q03k5UDk3k3w1c07n0I0tU70Dk760g1X0Mk410K0lUD0Ek41U60M060g0BU+0Mk7UAM3M03a0c31UC0zUCA1M230FU820g11UC0VU81U41k0A1A0P0I1VUD0EM2k01g1E630Q1XUAM2k460X0E41M230Q130E1U0300M2A1a0c330S0Uk4k03M2UA60s370Mk5U8A160U82k460s260U300C00k4M6A1E3C0w11U8k03k50AA1k6C0lU/0EM2A10E5U8A1k4A10300Q01U8QQM2k7s1s230Hw07U/0Rk3UAQ1X0K0Uk4M20U/0EM3U8M3s600k030ETlk5U303k460jzUD0K0T0D0Ms360g11U8k410K0Uk70Ek0M603U060Uz3U/0007UAA1MTUS0g000S0lk6A1M230FU820g11UC0VU0E40600A10070H000D0MM3UC0w1A001g1XUAM2k460X0E41M230Q1100UA0Q00M200C0a000S0kk6001s3M003M370Ek5U8A160U82k460s23010Q0k00k440Q16000w1VUA002k6s00Ck6C0UU90EM2A10E4U8A1E47020M3U00U800s26001c330Q00AUAs00tUAQ110G0UkAM60U90EM6U87041U60010E01kA70A2E461w00l0Mw03X0EM633a70ksMQ1Un3UMRVk7UM30Q0033U01ks7VwAks67S07X3ky0y73UMQ3y7w1zUzk1z3y0zlz03zUA0k003y003zU3zTkzUDwDzz7z0TzU3y0zk000000000000000000000M1U000000300000000007zk7w0Ds000000000000000000000000000k70000000000000000007k0000000000000000000000000000000030A000000000000000000000000000000000000000000000000000060s000000000000000000000000000000000000000000000000000081U0000000000000000000000000000000000000000000000000000k700000000000000000000000000000000000000000000000000001UA00000000000000000000000000000000000000000000000000001Us00000240000000000000000000000000000000000000000000001nk00000000000000000000000000000000000000000000000000001z00000000E000000000000000000000000000000000000000000001s000000000000000000000000000000008"
    Mansion2:="|<>**75$324.00000003s3U00003U00000000000000000000000000070000000000000000TyTw0000Ts000000000000000000000000000zk00000000Tk00001k2EA0000EA000000000TU007s000000000000UM00000000ss00003U2E40000E43w0000000ss00AA000000000000U800000000U80000302E40000E47C0000000UA00M6000000000000U800000000U80000602E40000E4430000000U400k2000000000000U800000000U80000402E40000E4A10000000U601U2000000000000U800000000U80000402E40000E4A10000000U30102000000000000U800000000U80000A06MA0000MAA10000000U1U302000000000000kM00000000U80000A1wDs0000DsA10000000U0U602000000000000Tk00000000U80000A1000000000A10D00000U0kA020000000003s0000Dk00000U8zjw0w1yDsTry0Dtw1yzU3y00U0MM020Tvy7xzU0zzUTk1wy0Try0U9Uw71U03MAkS3UMBU03kk6300U0AM021kC3A7Us1U0skM7070kS3UU90E1V001E4U80kE50010EC1U0U04k023041820A300AU8A01kU80kU9000l001E4U00ME50010MA0U0U07U0260018006600AU8M00kU00MU9000N001E4U00AE50010AA0k0U03002A0018003400AU8k00MU00AU9000B001E4U006E500106M1U0U00002M0018001Y008U9U00AU006U9000B001E4U006E5001U6M1U0U800E2M0018001Y1sMU90004U006U90005003E4U002E5003U3k3U0UA00E2E0018000Y3jkU90006U003U90707s1yE4U3U3E5s1zk3k300UC00k2k1k180s0o0z0U/0DU2U3U3U90Bk6A10E4U6s3E4A10M1k700UC01k2U7s181i0o03kU+0Mk2U6s3U"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Mansion1)) || (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Mansion2))
    {
        Loop 5 {
            SendClick(X, Y)
            Sleep(500)
        }
        return true
    }
    else
    {
        return false
    }
}

ImageFound_next()
{
    Next:="|<>**50$94.Dk07k00000000001zU0zk00000000y0C3063000000007y0k60M600000000kM30Q10M000000030kA0k41U0000000A30k1UE600000000kA30310M000000030kA0C41U7z0703kQ3sk0ME61zz1z0TbkDv00l0MS0SCC3Xs01g03Y1XU0QkQQ7003k07E6Q00y0vUQ00D00B0PU01s1w0k00w00Q1g003U3U7003kA1k7U00D040Q00D0s30K0T0q003s01g3U41M3g1w00Nw3ykD0050Tk6s031kDW"
    Gem:="|<>**50$63.7U0001zU000g00bzy7400Bk0lk00C801rkEs000QE0w68Q0001kU71kD00003W0gQ7U0010747n3k00000S07Ms000000s0OQ0000U0103q0000200M02k000080300IU000EU0E00V000740200A2101iE0E010AE0Mt0200c0m06340E01AG01U00600M0E0M000U020W06000400E4E1U000c021208000A00kME30101006620k100+00UUE41003E04861k0N0O01U0kS078600A0630En0o0101U0S6M4U08Tw0SUp1U01000SAAcA00CTw71Vb1804QTss8NsM000sPnX3+2000VVr7MNEk0013byS6C41c0277wkmlUT007DDs4I8Ds004D7VWXFvU000C7AgmAC0000QAB6Xkk0000sEtYCQ0000kw390rs0000ky383k00000sTm0Q000000MQ00000000008004"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Next)) || (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Gem))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_next_2()
{
    Next:="|<>**50$94.Dk07k00000000001zU0zk00000000y0C3063000000007y0k60M600000000kM30Q10M000000030kA0k41U0000000A30k1UE600000000kA30310M000000030kA0C41U7z0703kQ3sk0ME61zz1z0TbkDv00l0MS0SCC3Xs01g03Y1XU0QkQQ7003k07E6Q00y0vUQ00D00B0PU01s1w0k00w00Q1g003U3U7003kA1k7U00D040Q00D0s30K0T0q003s01g3U41M3g1w00Nw3ykD0050Tk6s031kDW"
    Gem:="|<>**50$63.7U0001zU000g00bzy7400Bk0lk00C801rkEs000QE0w68Q0001kU71kD00003W0gQ7U0010747n3k00000S07Ms000000s0OQ0000U0103q0000200M02k000080300IU000EU0E00V000740200A2101iE0E010AE0Mt0200c0m06340E01AG01U00600M0E0M000U020W06000400E4E1U000c021208000A00kME30101006620k100+00UUE41003E04861k0N0O01U0kS078600A0630En0o0101U0S6M4U08Tw0SUp1U01000SAAcA00CTw71Vb1804QTss8NsM000sPnX3+2000VVr7MNEk0013byS6C41c0277wkmlUT007DDs4I8Ds004D7VWXFvU000C7AgmAC0000QAB6Xkk0000sEtYCQ0000kw390rs0000ky383k00000sTm0Q000000MQ00000000008004"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Next)) || (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Gem))
    {
        Loop 3 {
            SendClick(769, 744)
            Sleep(500)
        }
        return true
    }
    else
    {
        return false
    }
}

ImageFound_ability()
{
    Off:="|<>**50$35.0z0Dzw7zUkw8Q1X1kFU1a30a01cS7AD1kwSEz3007X3600D66400SA4AC3wMMsSDMNlkgMEz3VMkkMB2lVk0O5X1k1Y/61kCAqA0zsTbkU"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Off))
    {
        SendClick(X,Y)
        return true
    }
    else
    {
        return false
    }
}

ImageFound_hill_unit()
{
    Hill:="|<>**50$19.k00M00A00600300xU0Gk0NE0Ac06Q03201V00nU0NE0Ac02I01u001"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Hill))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_hybrid_unit()
{
    Hybrid:="|<>**25$15.Q0700U0400U0400U7o0mU6I0mU6Q0kU640nU6I0mU6o0yU0400U"

    if (ok:=FindText(&X, &Y, 0, 0, 1920, 1080, 0, 0, Hybrid))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_snowy_town()
{
    Text:="|<>**50$199.00000000000000000000003zzzzzzzzz000000000000000000000003k00000001k00000000000000000000001U00000000A00000000000000000000001U00000000200000000000000000000000k00000000100000000000000000000000M000000000k00000000000000000000008000000000M00000000000000000000004000000000A00000000000000000000002000000000600000000000000000000001U00000000300000000000000000000000k000000001000000000000000000000008000000001U00000000000000000000007000000001k00000000000000000000001zzzk03zzzk00000000000000000000000000801U00000000000000000000000000000400k0000000000000007k000700000000200M0000Tw00Tk00zk0Tw000Dy0000000100A0000w300QS00sC0Q3000A3k0000000U060000M0k0M1U0k1ks0k00A0Q0000000E030000k080M0M0E0Qs0A006030000000801U000s060M060M06M0600600k000000400k001k0308030801s01U0300M000000200M001k00kA00UA00w00k03004000000100A001k00M600M600Q00A01U020000000U06001U0042004200D00301U010000000E03001k00330033007U01U0k01U000000801U00k001VU01V002M00M0E00U000000400k00k000EU00FU03A00A0M00k000000200M00k000Ak00Ak01X0030800M000000100A00M0U06E006E01VU00UA00M0000000U060080E01s001M00kM00M400A0000000E0300A0800w000w00E400660040000000801U040600A000Q00M300330060000000400k020300600060080k00n0020000000200M0300k03000300A0M009U030000000100A01U0M00000000606007U0100000000U0600k0400000000201001k01U0000000E0300E0300000000300k00k00k0000000801U0800U0000000100A00800k0000000400k0400M00000001U0600000M0000000200M0200A00000000k01U0000M0000000100A0100200000000k00E0000A00000000U0600U01U0000000M00A0000400000000E0300E00E000E00080030000600000000801U0A00A000A000A001U000200000000400k0600600060006000M000300000000200M01001U007U00600040001U0000000100A00U00k003k00300030001U00000000U0600M00800180010000k000k00000000E03004006001a001U000M000k00000000801U03003000X000U0006000M00000000400k00U00k00kU00k0001000800000000200M00M00M00MM00M0000k00A00000000100A00600400840080000A004000000000U06001U0300A300A00006006000000000E03000k00U061U0400001002000000000801U00A00M020E0600001U03000000000400k003U0A030A0300000U01U00000000300M000s0303030300000k01U000000001U08000700k3U1k300000M00k000000000M0A0001U0Q3U0Q300000M00E00000000070Q0000003z003z00000A00M0000000001zw00000000000000000A00800000000000000000000000000000600A000000000000000000000000000002004000000000000000000000000000003006000000000000000000000000000001003000000000000000000000000000001U03000000000000000000000000000000k01U00000000000000000000000000000k00U00000000000000000000000000000M00k00000000000000000000000000000800E00000000000000000000000000000A00M00000000000000000000000000000600800000000000000000000000000000300A000000000000000000000000000001U06000000000000000000000000000000E06000000000000000000000000000000A030000000000000000000000000000003U30000000000000000000000000000000w3U0000000000000000000000000000007zU0000000000000000000000000000000T0000000000000000001"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_sand_village()
{
    Text:="|<>**50$199.00000000000000000000000000000000y00000000007zs000000000000000Tz07zk00000000070C000000000000000w0s700000000000601U00000000000000M0A300000000000300k0000Dw000003zUM0330000000000010080000S3000003UwA01VU00000000000U040000Q0k00001U7600Ek00000000000E020000s0A00001U0v008E000000000008010000M0600000k0B004800000000000400U000M0100000k03U02400000000000200E000A00k0000M01s01200000000000100800040080000800Q00V000000000000U0400030060000A00S00kU00000000000E020001U010000400D00ME000000000008010000E00k0006004k08800000000000400U000A00M0003006Q0Q400000000000200E000600600030037zw20000000000010080001U030001U030701000000000000U040000k00k001U01U000U00000000000E020000A00M000k01U000E0000000000080100006004000k00k000800zk00000Dw400U0001U03000M00k3zU403szU0000zzm00E0000k00U00800M7vw201U0w0001s0D0080000A00M00A00M6031000070003U03U040000600400400A200kU0000k003U00E0200001U0300600A300ME0000C00300000100000k01U020061U04800003003000000U0000A00M030060k02400000k03000000E0000600A01U030E01200000A03000000800001U0301U030800V00000303000000400000k01U0k01U400EU00001U1U00000200000A00M0k01U2008E00000M1U00000100000600A0M00k100480000040U000000U00001U020800k0U0240000030k000000E00000k01UA00M0E012000001UE000000800000A00E400M0800V000000EM000000400000600A600A0400EU0Ds00AA007w002000001U02200A02008E0AC00640077001000000k01X006010048001U0320060k00U00000A00lU0600U024000M00V0060A00E00000600BU0300E012000400FU0606008000001006k0300800V0002008k0301004000000k01k01U0400EU001004M0100k02000000800s00U02008E000U02A00U0M01000000600800k010048000M01600M0A00U00000100000E00U024000800X00A0400E000000k0000M00E012000400FU030600800000080000800800V0003008E00k600400000060000A00400EU001004800Q6002000000100004002008E000U026003y0010000000k00060010048000M0130000000U00000080002000U026000800UU000000E00000060003000E013000400EM000000800000010001000800VU002008A00000040000000k001U00400EE0010043000000200000008000U0020088000U020U00000100000006000k0010044000E010M000000U0000001000E000U023000800U6000000E0000000k00M000E011U00600E1U00000800000008008000800UE0030080M0000040000000600A000400EA001U04060000020000000100400030083000k0201U0080100000000k060001U0A1k0080300Q00C01U0000000A060000E060Q00603003U0TU0k00000003060000A0603U01k7U00T1ww3k00000000sC00003UD00z00Dz0001zk7zU00000000Dy00000zy001k"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_navy_bay()
{
    Text:="|<>**50$199.00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000zzzzzU000000000000000000000000001k0000y000000000000000000000000001U00001k00000000000000000000000000U00000A00000000000000000000000000k000003U0000000000000000000000000M000000s00000000000000000000000008000000C000000000000000000000000040000003000000000000000000000000020000000U0000000000000000000000001000000000000000000000000000000000U00000000000000000000000000000000E0000000000000000000000000000000080000000000000000000000000000000040000000000000000000000000000000020000000000000000000000000000000010000000000000DU0001s00T0000Q00000U03zzk07s1zs0Ts0003z01zk000zs0000E0100Q03zXsT0s600030s1kA000kD0000800U06000vU1Uk1U003063U3000k1k000400E010007U0Mk0M00301XU0k00E0A000200800U001U04k0A001U0NU0M00M03000100400E000E02k03001U07U0600A01U000U0200M000001M01U00k03k0300A00E000E010Ds000000c00M00k00k00k06008000800US0000000I00A00M00w00806004000400EM0000000/00300M00S006030060002008M00000005U01U0A00BU01U10020001004A00000002M00M0A00Ak00k1U030000U02400000001A00A06006A00A0U01U000E01200000000X0030600660020k01U000800V00000000FU01U20021U01UE00k000400EU00000008M00M30030E00MM00E0002008M000Dk004400410030A00AA00M0001004A000AC00230031U01U3003A0080000U02200003U010k00UU01U1U00a00A0000E011k0000k00UM00Mk00k0M00O0040000800UDw000A00E6004E00k040070060000400E03U0060081003M00E030030030000200800E0010040k00c00M00k00U030000100400A000U020A00Q00M00M00001U0000U02002000E010600400A00600000U0000E01001000M00U1U0000A00100000k0000800U00U00M00E0E00004000k0000E0000400E00k00Q0080A00006000A0000M0000200800E0MQ00402000060006000080000100400M0Ds00201U00030001U000A00000U03zzs00000100M00030000E000400000E00000000000U0A0001U000A000600000800000000000E030001U0003000300000400000000000800U000U0001U00100000200000000000400M000k0000M001U00001000000000002006000k00004000U00000U00000000001003000M00003000k00000E00000000000U00k00M00000k00E00000800000000000E00800800000M00M00000400000000000800600A0000040080000020000000U000400100400000600A000001U000000k0E02000k06000002006000000k000001k0Q03000A060000030060000008000001U0y03000306000001U030000006000003U7ls7U000k6000001U010000001k0000T0zUDz0000Dy000000k01U000000Dzzzzw00000000000000000E00U00000000000000000000000000000M00k00000000000000000000000000000800E00000000000000000000000000000A00M00000000000000000000000000000400A00000000000000000000000000000600A000000000000000000000000000003006000000000000000000000000000001002000000000000000000000000000001U03000000000000000000000000000000U01000000000000000000000000000000k01U00000000000000000000000000000M00U00000000000000000000000000000A00k00000000000000000000000000000600M00000000000000000000000000000100M000000000000000000000000000000k0A000000000000000000000000000000C0A0000000000000000000000000000001k60000000000000000000000000000000Ty00000000000000000000000000000001w0000000000000004"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))    
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_fiend_city()
{
    Text:="|<>**50$199.0000000000001zy00000000000000DzU00000000000001k3U0000000000000S0Q00000000000001U0M000000007w000A0600000000000000k0A00000001zzw00A01U0000000000000E0200000007k07k0600k00000000000008010000000T000T030080000000000000400U000000w0001s1U040000000000000200E000001s0000C0U0200000000000001008000001k00001kE0100000000000000U04000003U00000QA00U0000000000000E02000003U000003600E0000000000000801000003U000001X00M0000000000000400U000030000000FU0A0000000000000200E0000300000008M04000000000000010080000300000004C0C00000000000000U0400003000000023zy00000000000000E0200001U000000303k0000000000000080100001U0000001U0000000000000000400U0000U000Tk01U0000000000000000200E0000k001zz00k0000Dy0Dw000003z10080000E003k1s0k1zk0z7kzDs0000DzwU040000M00700C0k3zy1w0As0D0000S03k0200008007001lk301VU03k01k000w00s010000A006000Dk100MU01k00A000s00400U0006006000001U0Ak00k003U00k00000E0002006000000k02M000000k00k0000080001003000000M01A000000A00k0000040001U03000000800Y000000300k0000020000k01000000400G0000000k0k0000010000M01U0000020090000000M0M000000U000800k000001004U00000060M000000E000400E000000U02M00000010800000080002008000000E01A0000000kA00000040001004000000800a0000000M400000020000U02000000400FU0000004600000010000E010000002008s007y0033001z000U000800U0000010047U073U01V001lk00E000400E000000U0200060M00kU01UA008000200A000000E01000606008E01U30040001U06000000800U00301004M01U1U020000k01000000400E00100U02A00k0E010000M00k000002008000U0E01600E0A00U000400M000001004000E0A00X0080600E0002006000000U0200080600FU06030080001U01U00000E01000403008k03010040000E00s000S0800U00201U04M00k1U020000A00C001zk400E00100k02400Q1U0100006001k01kQ2008000U0M0120071U00U0001000S03U61004000E0A00VU00zU00E0000k003sDU1UU0200080600Ek000000800008000Dy00ME01000403008800000040000600000004800U00201U046000000200001U0000003400E00100k023000000100000k0000000W008000U0E010k000000U0000A0000000F004000E0800U8000000E0000300000008U0200080600E6000000800000k0000004E010004030081U00000400000A0000002800U00201U040M000002000003U000003400E00100k0206000001000000s0000032008000U0M0101U00000U0000060000071U04000k0A01U0M00200E000001k000070k06000M0200k07003U0M000000C0000C0803000M01U0k00s07s0Q0000001k000S0603020s00S1s007kTD0w0000000D001s01k7U1zs003zk000zw1zs00000001z0TU00Tz00000000000000000000000001zw0000000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_spirit_world()
{
    Text:="|<>**50$199.00003zs0000000000000000000000000000007U7000000000000000000000000000000301U00000000000000000000000000000300M00000000007z0001z0001zs0000001U0A0000000000T1k003ls001kD0000000k0200Ts000000Q0M0030C000k1k000000M0101zzU00000M0600301U00k0A000000A00U0k0s00000M0300300E00M03000000400E0k0A00000A00U01U0A00801U0000030080E0200000400M00U0600A00k000001U04080100000200A00k0100600M000000k060400U00001U0200M00k0200A000000M030200E00000k01U0800M030060000006010100A00000800k0A00401U020000003U3U0U060000060080600300U030000000zzU0E0300000300602001U0k01U0000001w00801000000U0303000E0M00U0000000000400U00000M00U1U00A0800k0000000000200E00000A00M0U0060A00M0000000000100800000200A0k001060080003zs0Tw0TU07zU0001U020M000k200A01y70T0zzUTk03zw0000k01U8000M300603li01kk0MM000030000800kA00041U0207US00ME06800000k0006008600030U03070A006M03A00000M000300620001Uk01UC00003A01a0000040000U0330000EM01UC00001a00H0000020000M00VU000A800kC00000G0090000010000A00MU0006A00EA00000N004U00000U000200Ak0001600MC00000AU02E00000E0001U02M0000m00A6000006E0180000080000k01c0000P0046000002800a0000040000800w00005U066000003400H0000060000600C00003U033000001W009U000030000300600801k011000001V004M0000300000U0300A00M01VU001z1UU02C00007U0000M00U0700800kU001lzUE011y00Tz00000400003U0400EE001U00800U1008000000300003E0000MM00FU00400E0U040000001U0001g0000AA00MU0020080E020000000E0000a00004600ME00100408010000000A0000l00006200A8000U020400U00000060000Mk000310044000E010200E000000100008M00010U022000800U10080000000k000A40001UE011000400E0U040000000M000630000k800UU0020080E020000000400021U000E400ME00100408010000000300030E000M200A8000U020400k0000001U001UA000A1U034000E010200M0000000E000U600040k00W000800U10040000000A000k1000608001000400E0U03y0000006000M0k00204000U0020080E003k00000100080M00103000E00100408000A000000k00A04001U0U008000U02060003000000M00603000U0M004000E01030001U00000400201U00k04002000800U1U000k00000300300E00M03001000400E0E0008000001U01U0A00800k00U0020080A0004000000E00U0200A00A00E001004020002000000A00k01006006008000U0201U001000000200M00k02001U04000M0100M001U000001U0800803000Q06000A01U06000k000000k0A00601U00703000200k01k00E000000A0A00301U000s30001U0k00S00M00000030C000s1U000D3U000Q1s003w0s0000000sS000D3U0001t00007zk000Dzs0000000Dw0001zU0000DU"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_ant_kingdom()
{
    Text:="|<>**50$196.000000000000000000000000000000DzU000000000000000000000000000003k3U000000000000000000000000001w0A060000000000000000000000zs000Qw1U0A000000000000000000000D1s003UM600k0000000000003z0000001U0k00M0kM010000000000001yTU00000401U0301V004000000000000607000000k0200Q03400E000000000000k0A00000300801U06E01000000000000200E00000A00U0A009004000000000000801000000U0201U00a00E000000000000U040000020080A002M03000000000000200E00000800U1U009U0A000000000000801000000U020A001X00U000000000000U040000020081k004C0C000000000000200E00000800U6000kTzk000000000000801000000U020k0060000000000000000U040000020086000k000000000000000200E00000800Uk0060000000000000000801000000U026000s00080007z07y000DU07zU0002008k00700zUU001wT3szU03y00TzU000800a000s0T7n000A06Q07U0M000030000U02k0030301Y000U0D00701000006000200D000M0803M00600s0060A00000M000800s00301U0AU00M03000C0k00000U000U03000M0600H001U00000M3000002000200800300E01A004000000k8000008000800000M01004M00E000001UU00000U000U0000700400FU0100000032000002000200000s00E013004000000A8000008000800007001004A00E000000Mk00000U000U0000s00400EM010000000X000006000200007000E011U040000003A00000M00080000s001004300E000000AM000030000U0003000400EA010000000Fk0000w00020000C000E010M04001z001Vy00Tz000080000Q0010041U0E00QC0060801000000U0000s00400E3010030A00M0U0400000200001k00E010A040080M00U200E00000800003U010040M0E01U0U020801000000U0000700400E1U1004020080U0400000200000C00E01030400E0800U200E00000800U00Q010040A0E0100U020801000000U03000s0400E0E1004020080U0400000200C001k0E0101U400E0800U200E00000800g003U1004020E0100U020801000000U02k0070400E0A1004020080U06000002009U00C0E0100E400E0800U200M00000800X000M100401UE0100U020800U00000U026000k400E021004020080U03y00002008A001UE0100A400E0800U2000S0000800UM003100400EE0100U0208000A0000U020k006400E01V004020080U000E00020081U00AE01002400E0800U30001U000800U6000F00400AE0100U020400060000U020A001Y00M00l004020080E000800020080M002E01U01400E0800U1U000U000800U0k009006004E0100U020200020000U0201U00Y00Q00F004030080A0008000200803002E01E01600E0A00U0M001U000A00U0600NU05U0AM0300k0200k0060000k0200A03600m01UU0A0100M01k00E000100M00s0M803A0C301U0603003k030000603001U30k0MM3U70Q00C0w003w0s0000C0w003UM1k70ts0DzU00Dz0001zz00000Tz0007703zs1y00000000000000000000000007k0002"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_magic_town()
{
    Text:="|<>**50$199.0000000000zy0000000000000000000000000000001s1k000000000000000000000000000000k0M000000000000000000000000000000k0600000000000Dzzzzzzzzs000000000M0300000000000Q00000000C000000000A00U00000000008000000001000000000400E0000000000A0000000000000000002008000000000060000000000000000001004000000000020000000000000000000U02000000000010000000000000000000M0100000000000U000000000000000000A01U0000000000E000000000000000000600k0000000000A0000000000000000001U0E000000000060000000000000000000s0s000000000010000000008000000000Dzs00000000000s00000000A00000000000000000000000Dzzy00Tzzw00000000000000000000000000100A000000000000000000000000000000U06000000000000000000000000000000E030008000Ts1zs07z0001zzk00000000801U007001yDVkD0Drs003s0z00000000400k001U03k0RU0kA06007001s0000000200M000M03U03U0M401U0C000C0000000100A000407000k04600k0A0001k0000000U0600020700000230080Q0000Q0000000E030001060000011U040Q000060000000801U008U6000000UU020Q00001U000000400k00AE7000000EE010Q00000E000000200M00A830000008800UA000008000000100A006430000004400EA0000040000000U06006230000002200840000060000000E0300611U000001100460000030000000801U030UU000000UU0220000030000000400k010Ek000000EE013000001U000000200M01U8E0070008800V000001U000000100A00U4800Ts004400EU00Tk1U0000000U0600E2A00Q70022008k00sC1k0000000E0300M1600Q1U011004M00s3lk0000000801U0A0W00A0M00UU02800M0TU0000000400k040F00A0400EE01400M0000000000200M0208U0603008800W00A0000000000100A0104E0201U04400F00400000000000U0600U2801U0k022008U0200000000000E0300E1400k0E011004E0100000000000801U080W00A0M00UU02800k0000000000400k040FU030M00EE01400807U0000000200M0208k01kQ008800X0060Dw0000000100A01U4800Ds004400FU01kQ700000000U0600k24001k0022008E00Tw0k0000000E0300813000000110048001k0A0000000801U040UU000000UU0260000060000000400k030EM000000EE011000001U000000200M00U8A0000008800Uk00000M000000100A00M430000004400E800000A0000000U0600420k000002200860000020000000E0300310M00000110041U000010000000801U00kU6000000UU020k00000U000000400k00AE1U00000EE010A00000k000000200M00680Q000008800U3U0000k000000100A001407000U04600E0s0000s0000000U06000200k00k02300M060000s0000000M02000300D01s010U0A01k001k0000000A010003001yDY00UM0A00C001k0000000301U003U007y600E70S001s07U00000000s3U001003k030081zw000Dzz000000000DzU000007y030040000000700000000000000000063U30020000000000000000000000000060Q3U0300000000000000000000000000603zU01U00000000000000000000000003006000U00000000000000000000000003000000k00000000000000000000000001U00000M00000000000000000000000000U00000M00000000000000000000000000E00000800000000000000000000000000800000A00000000000000000000000000400000A00000000000000000000000000300000A000000000000000000000000000k0000A000000000000000000000000000C0000A0000000000000000000000000003U000Q0000000000000000000000000000Q000s00000000000000000000000000003k01s00000000000000000000000000000TUDU000000000000000000000000000000zy000000000000000000000000000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_haunted_academy()
{
    Text:="|<>**50$199.0000000000000zz0000000000000000000000000000000s1k000000000000000000000000000000k0A000000000000000000000000000000M06000000007w0000000000000000000080100000000D7U0000000000000000000400U0000000C0M0000000000000000000200E0000000C06000000000000000000010080000000601U0000000000000000000U040000000600k0000000000000000000E020000000300A0000000000000000000801000000030060000000000000000000400U0000001U010000000000000000000200E0000001U00k00000000000000000010080000000k0080000000000000000000U040000000k0060000000000000000000E020000000M001000000000000000000080100000008000k000000000000000000400U000000A0008000000000000000000200E00000040006000000000Ty0000000100800000060001000000007zzw00001zUU0400000020000k00003s0D007U0007zyE020000003000080000DU0Q000Q000D01s010000001000060000Q00s0007000S00Q00U000001U00010000s00s0000k00Q00200E000000U0000k000k00k0000A00M000008000000k00008001k00k0000300M000004000000E00006001k00k00000k0M000002000000M00001001U00k00000M0M000001000000800000k00U00k0000060M000000U00000A00800800k00M0000010A000000E00000600600600k00M000000kA000000800000600700100E00A000000M40000004000003002k00k0M004000s00460000002000003003800M08002001zU0220000001000001U0160060A000003Us01X0000000U00001U01V00304000003UA00lU00zU00E00000k00Uk00U2001U030200MU00ss00800000k00k800M3001U01U300AE00k600400000M00E60041U01U00zzU06800k1U0200000M00Tz0030U01U0000003A00k0k0100000A0000000UE01U0000001600M0800U0000A0000000M800k0000000X0080600E0000600000004400E0000000lU0403008000020000000320080000000Ek0301U040000300000000V0040000000MM01U0U020000100000000MU030000000s400M0k0100001U00000004E00U000001s20060k00U0000U00000003A00M007zzzk1003Uk00E0000k00000000W00700300000k00Tk0080000E00000000N001k00k03s0M00000040000M000000004U00400C0D704000000200008000000003M002001zw1U300000010000A00DzzzU00Y001000000M1U000000U000400A000M00P000k0000060M000000E00060060004005U00800000304000000800020060003003M006000000U3000000400030030000U00a001U00000E0k0000020001U010000M00H000E0000080A0000010000U01U0004008k00A00000403000000U000E00U0003004A00300000200k00000E000A00k0000U023U00s0000300A001008000600E0000M030M00C00001U03U01k0A0001U0M000040307001k0003U00Q03w060000Q0M000030300s00C00070003sDbUS00007UA00000k7007U01w00y0000Dy0zw00000wQ00000AS000z007zzk000000000000003s000003w0000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_magic_hills()
{
    Text:="|<>**50$197.000000001zw000000000000000000000200000000D0C000000000000000000000Q00000000M0A000000000000000000000k00000001U0A000000000003zU0003zk300000000300M00000000000S3k000D1s600000000600E00000000001U0k000k0MA00000000800U0000000000200k00300EE00000000E0100000000000A00U00600kU00000000U0200000000000M01000801V00000000100400000000000k02000E03200000000300800000000001004000U02600000000600k00000000002008001004A00000000A01U0000000000400E002008M00000000A0200000000000800U00400EM00000000Q0Q00000000000E01000800Us00000000Tzk00000000000U02000E010k0000000000000000000001004000U0200000000000000000000000200800100400000000000000000000000400E00200800000000000000000000000800U00400E000Dy0zw03zU000Tzs00000E01000800U003wT7US0Tjk007k1y00000U02000E010k0S03g061U0k00s00C00001004000U02301k01k0A200k0700070000200800100440C001U08A01U0M00030000400E002008M0s00000EM0103U0003U000800U00400Ek3000000Uk020C000030000E01000800V0A00000110040s000030000U03zzzk0120s00000220083U000020001007zzzU0241U000004400E60000040002000000004860000008800UM0000080004000000008EM000000EE010U00000k000800000000EUk000000UU023000001U000E00000000V10000001100440000060000U000000012600000022008M00000A000100000000248003U004400EU00000k00020000000048E00zk008800V000zU300004000000008FU03Us00EE0160071kC0000800000000EX00C0k00UU02A00Q1ss0000E00000000V400M0k011004E00k0z00000U000000012801U0U022008U03000000010000000024E0301U04400F0060000000200Dzzz0048U0403008800W0080000000400E002008F00A0600EE01400E0000000800U00400EW00M0800UU02800U0000000E01000800V400M0k011004E01U0000000U02000E012A00M30022008U0100w00001004000U024M00sA004400FU0307y000020080010048E00Tk008800X003UsC0000400E002008EU00C000EE012003zU60000800U00400EVU000000UU024000s060000E01000800V100000011004A00000A0000U02000E012300000022008800000A0001004000U02460000004400EM00000A0002008001004860000008800UE00000M000400E002008E6000000EE010k00000E000800U00400EUA000000UU020k00000U000E01000800V0A00000110041U000010000U02000E0120A00000220081U000060001004000U0240C000004400E1U0000M000200800100480C001008A00U1k0001k000600E00200ME0600600EM0300k00070000A00U00400kk07U0w00UE0600s000s0000803000A010U03wT8010k0M00Q003U0000M0A000A061U00zkk020s3k00D00w00000Q1k000C0s1U1s01U040zy0007zz000000Dz0000Dz010Dw0600800000000000000000000000000kQ0M00E000000000000000000000000030C1k01U0000000000000000000000000A07y00300000000000000000000000000M00k00400000000000000000000000001U00000M00000000000000000000000003000000k0000000000000000000000000400000300000000000000000000000000800000400000000000000000000000000E00000M00000000000000000000000000U00001U00000000000000000000000001U00006000000000000000000000000001U0000M000000000000000000000000001k0001U000000000000000000000000001k000C0000000000000000000000000000s001k0000000000000000000000000000S00D00000000000000000000000000000Dk7k000000000000000000000000000001zw0000000000000000000000000001"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_space_center()
{
    Text:="|<>**50$199.00000000000000000000000DU0000000000000000000000000000007zzk00000000000000000000000000000T00T00000000000000000000000000001w000w0000000000000000000000000003k00070000000000000000000000000007U0000s00000000000000000000000000700000700000000000000000000000000C000001k0000000000000000000000000C000000A0000000000000000000000000C00000060000000000000000000000000A00000010000000000000000000000000A0000000U000000000000000000000000A0000000E000000000000000000000000A0000000800000000000000000000000060000000400000000000000000000000060000000600000000000000000000000020001z0060000000000000000zw00000030007vw030007z0007zz0000Dzzs000001000C07U3001zXz00DU3w000S00D000001U00Q00s3003k01k0Q007U00s000s00000U00Q007700700000s000s01k000C00000k00M000z00C00000k000701k0001U0000M00M000000C00001k0001k1U0000M0000800M000000A00001k0000M1U000060000400A000000A00001k000061U00001U000600A000000A00001k000011U00000E0003004000000A00000k00000VU00000A0001U06000000A00000k00000Ek0000020000U03000000600000E00000Mk000001U000E01000000600000M00000AM000000k000800U00000300000800000AM001k008000400E000003000C0A000006A003z0040002008000001U00Ts400000640071k030001004000000U00sC2001z0620070M01U000U02000000E00k31003Us730060400k000E01000000M00k0UU03U771U030600M000800k00000A00M0k001U1y0U01zz00A000600M00000400Dzk001U000E0000004000300400000200000000k000800000020000U0300000100000000E000400000010000E01U00000U0000000800020000001U000800M00000E0000000400010000000U0006006000008000000030000U000000k0001001U001s400000000U0S0E000001k0000U00s003j200000400M0zkA000003k0000M0070071lU000020071kQ600DzzzU00004001s0C0Mk01zzz001zk31006000000003000DUy06800k00U00700kU01U07k00000U000zs01Y00A00s000008M00Q0SC00000M0000000H003U3o000006A003zs30000060000000BU00Tz3000001W000000k0000100000002E00000U00000lU00000A00000k0000001A00000M000008E00000600000A0000000W000006000004A0000010000030000000FU000030000023000000U00000k0000008M00000k000030U00000E00000C000000A400000A000030M000008000003U00000A3000003U0003U6000004000000M00000A0k00000M0003U1k00006000000700000Q0C000007000700Q000030000000s0000s03U00000s007003U0007000000070001k00Q000007U0S000Q000C00000000w007U003U00000zzs0003s03w000000003w1y0000T00A000000000Dzzk0000000007zk00001zzx"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_alien_spaceship()
{
    Text:="|<>**50$199.s000000000000000000000000000000007000000000000000000000000000000001U0000000000000000000000Dzs0000000M0000000000000000000000zUTk000000A0000000000000000000001s00T00000020000000000000000000003U001s00000100000000000000000000030000C000000U00000000000000000000300001U00000E00000000000000000000300000M000008000000000000000000003000006000004000000000000000000003000001U00006000000000000000000003000000k00003000000000000000000001U00000800001000000000000000000001U00000400003U00000000000000000000k00000600007U00000000000000000000E00000300000000000000000000000000M00000300000000000000000000000000A00Dw01U0000000000000000000000000600C701U000000001zw00000000000000200A0s1U0000A000Dzzs003zU3zU0000010040C1U07z0DU00S00D007lwDny000000U0201zU0DXswM00s000s0603C03k00000E0100D00A0Ds601k000C0200w00Q00000800k0000401k301k0001U300Q00300000600A0000600k1U1U0000M1U0A000s00003003k00030000E1U000060k00000C00001U00TU001U00081U00001UE00000300000E000zU00U00041U00000k8000000k0000A0001y00E00021U00000A4000000A0000600003k0800010k000002200000060000100000D040000Uk000001V0000001U0000k00001k20000EM000000kU000000E0000A00000A100008M001k008E000000A000070000030U0004A003z0048000000600001k00000kE000240071k034000000100000Q00000M8000120070M01W001zU00k00003U000064003UX0060400l001ks00M00000w000012003UFU030600MU01U600A000007k0000l00308U03zz00AE01U1U02000000S0000MU0304E0000006800k0k010000001w0004E01U280000002400E0800U0000007s002800U14000000120080400E0000000D001400E0W0000001V0040300800007s00s00W0080F0000000UU0201U040000CD00A00F00608U000000kE0100k020000C1k03008U0304E000001k800U0M010000A0Q01U04E00k2A000003k400E0A00U000A0300k02800A1600DzzzU20080600E000600k0k014003UX0060000100403008000600A0M00W000EEU01U0Dk0U0201U040002003Us00F00008M00Q0SC0E0100k020001000Tk00MU0004A003zs3U800U0M010000U000000AE00022000000k400E0A00U000M0000004800011U00000A20080600E000A000000640000UE0000061004030080003000000320000EA0000010U0201U040001U0000031000083000000UE0100k020000M0000030U00040k00000E800U0M0100006000001UE00020M000008400E0A00U0001U00001U800010600000430080600E0000M00001U40001U1k000061U0A0300M0000700003U200M0k0Q000030E0600U0A00001k0003U100D0k03U00070A0600M0A00000C000D00U06xs00Q000D03UC007US000001s00S00E037k003s03y00zy000zw000000Ds7w00801U0000Dzzk0000000000000000TzU00400k00000000000000000000000000000200M00000000000000000000000000000100A000000000000000000000000000000U06000000000000000000000000000000E03000000000000000000000000000000801U00000000000000000000000000000400k00000000000000000000000000000200M00000000000000000000000000000100A000000000000000000000000000000U06000000000000000000000000000000E03000000000000000000000000000000801U00000000000000000000000000000400k00000000000000000000000000000300M000000000000000000000000000001U0A4"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_fabled_kingdom()
{
    Text:="|<>**50$199.000000000007zs0000000000000Tz00000000000000070C0000000000000s0s00000000000000601U0000000003s0M0A00000000000000300k0000Dy000770M030000000000000010080000S3k0070kA01U00000000000000U040000M0A0060A600E00000000000000E020000803006032008000000000000008010000A00U0700l00400000000000000400U000600E0300AU0200000000000000200E000200803002E01000000000000001008000100403001A00U00000000000000U040000U0203000a00k00000000000000E020000E0103000H00M000000000000008010000800U3000Mk0800000000000000400U000400E30008Q0Q00000000000000200E00020081U00A7zw00000000000000100800010041U00A000000000000000000U040000U021U00A000000000000000000E020000E011U00A000000003zk00000008010000800VU00C00000000zzzU0000Dw400U000400FU00C01z00Tw1s00w0000zzm00E0002009U00C07lw0w7XU003U001s0D0080001005U00606030k0N0000s003U03U040000U02k0060200UE0500006003U00E020000E01k0060300MM03U0001U030000010000800k00601U04A01U0000M03000000U000400E00600U0240000000603000000E000200000600E01200000003030000008000100000600800V00000000k300000040000U0000C00400EU000000081U0000020000E0000C002008E000000061U000001000080000C0010048000000030U000000U00040000C000U02400007000Uk000000E00020000C000E0120000Dw00EE0000008000100006000800V0000Q700AM00000040000U0003U00400EU000Q1U06A007w0020000E0000s002008E000M0E0340077001000080000C0010048000A0M01W0060k00U000400003U00U0240087zw00l0060A00E000200000M00E01200400000NU0606008000100000600800V006000008k03010040000U00001U0400EU02000004M0100k020000E01000M02008E01000006A00U0M010000800k00601004800U00002600M0A00U000400Q001U0U02400E00003300A0400E000200/000M0E012008000071U03060080001005U00C0800V0040000D0E00k60040000U02M003U400EU020zzzy0800Q60020000E016000k2008E010M00006003y0010000800VU00A1004800U600T030000000U000400EM0030U02400E1k1ss0U000000E00020086000kE0120080DzUC0M000000800010041U00A800V004000030A00000040000U020M003400EU0200000k300000020000E010A000W008E0100000M0U0000010000800U3000N004800U000040M000000U000400E0k004U02400E0000206000000E00020080A002E0120080000101U000008000100403001800V00400000U0M0000040000U0200k00Y00EU0200000E060000020000M0100A00m008E0100000M01U008010000A00U0300lU0AA01U0000A00Q00C01U000200k01U0kE06200a0000Q003U0TU0k0001U0k00M0kA061U0lk000w000T1ww3k0000Q1s0070k3U60Q1kDU0Dk0001zk7zU00003zk001lk0zy03zU0zzz00000000000000000000DU0000000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_ruined_city()
{
    Text:="|<>**50$199.0000000000000000zz000000000000007U000000000000000s1k000000000000060000000000000000k0A000000001w00060000000000000000M0600000000zzy006000000000000000080100000003s03s030000000000000000400U000000DU007U1U000000000000000200E000000S0000w0U0000000000000001008000000w000070E0000000000000000U04000000s00000s80000000000000000E02000001k00000C40000000000000000801000001k000001X0000000000000000400U00001k000000lU000000000000000200E00001U0000008k000000000000000100800001U0000004A0000000000000000U0400001U000000270000000000000000E0200001U00000011w00000000000000080100000k0000000U0000000000000000400U0000k0000000k0000000000000000200E0000E000Ds00k0000000Ty000000010080000M000zzU0M0000007zzw00001zUU0400008001s0w0M0w0000D007U0007zyE020000A003U070M1zU000Q000Q000D01s0100004003U00ss1Us000s0007000S00Q00U00060030007s0U6000s0000k00Q00200E0003003000000k1k00k0000A00M0000080001003000000M0Q00k0000300M0000040000U01U00000A0600k00000k0M0000020000k01U00000401U0k00000M0M0000010000M00U00000200M0k0000060M000000U000A00k00000100A0M0000010A000000E000400M000000U030M000000kA00000080002008000000E00UA000000M400000040001004000000800MA000s004600000020000U02000000400A6001zU02200000010000E0100000020022003Us01X0000000U000800U000001001V003UA00lU00zU00E000400E000000U00lU030200MU00ss0080002008000000E00Mk01U300AE00k60040001U060000008004E01zzU06M00k1U020000k03000000400280000003A00k0k010000M00U00000200140000001600M0800U000A00M000001000W0000000X0080600E000200A000000U00F0000000lU04030080001003000000E008U000000Ek0301U040000k00k000008004E000000MM01U0U020000800Q000D040028000000sA00M0k0100006007000zs20016000001s200C0k00U0003000s00sC1000X007zzzk1003Uk00E0000U00D01k30U00FU0300000k00Tk0080000M001w7k0kE008E00k07s0M0010004000040007z00A8004A00C0D7040000002000030000000240026001zw1k3000000100000k0000001W0011000000M1U000000U0000M0000000F000Uk0000060M000000E0000600000008U00E800000304000000800001U0000004E0086000000U3000000400000M000000280041U00000E0k000002000006000000140020M0000080A000001000001k000001W0010A00000403000000U00000Q000001V000U300000200k00000E000003000003Uk00k0s0000300A001008000000s00003UM00M0C00001U03U01k0A0000007000070400M01k0003U00Q03w0C0000000s000C0330w00C0007U003sDbUS00000007U00w00tzs001w01z0000Ty0zw00000000zUDk00D000007zzs000000000000000000zy0000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_puppet_island()
{
    Text:="|<>**50$199.00000000000000000000000000000000TU0000000000000000000000000000000Q00000000000000000000000000000000A00000000000000000000003zk0000000A00000000000000000000007Uw0000000600000000000000Dw0000006030000000300000000000000zDk00000200k000000100000000000000M0Q00000300M0000000U0000000000000M06000001U040000000E0000000000000801000000k02000000080000000000000400U00000M01000000040000000000000200E00000800U00000020000000000000100800000400E000000100000000000000U040000020080000000U0000000000000E020000010040000000E0000000000000801000000U02000000080000000000000400U00000E01000000040000000000000200E00000800U00000020000000000000100800000400E000000100000000Tz0000U04000002008007zU00UDU00003zzy00Dk03zk000100401zzz00E7y00007U03k0Ds01zy0000U0203k01w0801k000C000C0A00001U000E01070003U400C000Q0003U400000M000800U70000Q2003U00Q0000M600000A000400E6000061000M00M0000630000020002008600001UU00600M00001VU000010001004300000kE001U0M00000MU00000U000U02300000M8000M0M00000AE00000E000E011U0000A400060M0000038000008000800UU00004200030A000000Y000004000400EE0000610000kA000000P0000020002008M000020U00086000000BU000030001004A01zk30E00066000Q002k00001U000U02600kS30800033000zk01A00001U000E01300M1z040000l001kQ00r00003k000800VU0DU0020s00MU01k600Mz00DzU000400EE01zU010C00Ak01U100A0U040000020088000y00U1U02M00k1U060E0200000100440001s0E0k01800zzk030801000000U0230000D080A00Y0000001U400U00000E011U0001k40200G0000000U200E00000800UE0000A2010090000000E100800000400EA00003100U04U000000M0U04000002008300001UU0k02E00000080E020000010041k0000ME0M018000000A0801000000U020Q0000A80M00Y000000Q0400U00000E0107U000240M00H000000w0200M00000800U0w000120s00NU03zzzs0100A00000400E07U000l0E00Ak01U00000U020000020083yz000MU0004800M03w00E01z0000100433lz00AM0006600707XU08001s0000U0230S1k06A00023000zy0s0400060000E011U3kM03600030U00000A030001U000800VU0Ds01X00030M00000301U000k000400EU00000UU001U4000001U0k000M0002008k00000EE001U3000000E0800040001004E0000088001U0k0000080600020000U02800000A6001U0A0000040100010000E0140000063001U0600000200k000U000800W0000060U01U01U0000100A000k000600FU000020M03U00Q00001U03000M0003008Q000030607U00700000k00s0080000U0A70000703UT0000s0001k00D00A0000M0A0w000D00zw000070003k001y0Q000070S07U00y006000000y00zU0007zw00001zw00TUTs0000000003zzw00000000000000000zy0000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_virtual_dungeon()
{
    Text:="|<>**50$199.000000000000zzU000000000000000000000000000000s0s000000000000000000000000000000M0A000000000000000000000000000000M03000003zzzzk0000000000000000000A01U00003k001zU000000000000000000600E0000300001w000000000000000000300800001000007U00000000000000000100400001U00000w000000000000000000U0200000k000007000000000000000000E0100000M000000s00000000000000000800U0000A000000C00000000000000000400E000040000003U00000000000000002008000020000000M00000000000000001004000010000000600000000000000000U0200000U0000001U0000000000000000E0100000E0000000M0000000000000000800U000080000000A0000000000000000400E0000400000003000000000000000020080000200000000k000000000000000100400001007zw000M00000zw0007y0Ty0U0200000U0207U0060Dy01sDU00zzsyDkE0100000E0100Q0030S3k1U0k01s0Cs0M800U0000800U07000kM0A0U0A01k01s06400E0000400E00k00M8030k0601U00M0120080000200800A004A01UM0103U00400V00400001004003003600EA00U3U00000EU0200000U02000k01X008600E1U000008E0100000E01000M00l00430081U000004800U0000800U006008U021U041U000002400E0000400E003004E010k021U000001200800002008000U02800UM010k000000V00400001004000M01400EA00Uk000000EU0200000U02000A00W008600EE0000008E0100000E01000600F0043008M0000004800U0000800U003008U021U04A0000002400E0000400E001U04E010k024007w001200800002008000k02800UM0160073U00V00400001004000M01400EA00X0060s00EU0200000U02000800W008600FU060A008E0100000E01000A00F0043008U0303004800U0000800U006008U021U04E0101U02400E0000400E00600AE010k02800U0E01200800002008003006800UM01400k0800V00400001004003002400E800W0080400EU0200000U020030033008400F00606008E0100000E01003001VU062008U0306004800U0000800U07000Uk030004M00k7002400E0000400E07000kM00k002A00C70012008000020080S000M400C0012003y000V00600001007zw000M2003k00VU000000Ek03y0000U000000081U00000Ek0000008M003U000E0000000A0k00000880000004A000E00080000000A08000004600000026000A00040000000A060000021000000110006000200000006030000010k000000UU00100010000000600k00000UA000000EE000U000U000000600800000E30000008A000E000E00000060060000081k000004600080008000000C001U000040Q000002100040006000000C000M00E02070000010k0020003000000Q000600M0301k00400UA0030001U00000Q0001U0A01U0C00700k7001U000E00000s0000Q0301U03k0DU0k1s00U000A00003k00007U0w3k00T1wS1s0Dk1k0003k000zU00000z07zU001zs3zk00zzk0000Tzzzw0000003zU"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_snowy_kingdom()
{
    Text:="|<>**50$199.000000000000000000000000000000000U00000000000000000000000000000001k000000000000000000000000000007k0k000000000000000000000000Ty000CS0k000000000000000000000000w7U00C1UM000000000000000000000000k0M00A0MA000000000000000000000000E0600A066000000000000000000000000M0300C01W000000000000000000000000A00U0600N000000000000000000000000600E06004k00000000000000000000000200806002M00000000000000000000000100406001A000000000000000000000000U0206000a000000000000000000000000E0106000lU00000000000000000000000800U7000Ms00000000000000000000000400E7000MA0000000000000000000000020083000M00000000000000000000000010043000M0000000000000000000000000U023000M00000000000000DU000C00000E013000Q000zs00TU01zU0zs000Tw0000800X000Q001s600sw01kQ0s6000M7U000400H000Q0A1k1U0k301U3Vk1U00M0s000200/U00Q0A1U0E0k0k0U0tk0M00A060001007U00Q041U0A0k0A0k0Ak0A00A01U000U03U00Q060k060E060E03k0300600k000E01U00Q030E01UM010M01s01U06008000800U00Q01Y800kA00kA00s00M03004000400000Q00W60084008400S00603002000200000Q00FX0066006600D00301U03000100000Q008MU0330032004k00k0U010000U0000Q0044M00V000X006M00M0k01U000E0000Q0023A00NU00NU0360060E00k00080000Q0010X00AU00AU0330010M00k00040000Q000UNU03k002k01Uk00k800M00020000A000EAE01s001s00U800AA00M00010000700082A00M000s00k6006600A0000U0001k0041600A000A00E1U01a0040000E0000Q0020lU06000600M0k00H00600008000070010Mk00000000A0A00B0020000400001k00UA800000000402003U030000200000Q00E2600000000601U01U01U00010000070081100000000200M00E01U0000U02001k040Uk0000000300A00000k0000E01U00Q020kM00000001U0300000k0000800s007010M400000000U00U0000M0000400S001k0UA300000000k00M000080000200/U00Q0E60U000U000E0060000A00001004k0070820M000M000M0030000400000U02A001k410A000A000A000k000600000E013000M21U2000D000A0008000300000800Uk00610k1U007U0060006000300000400EA001UUE0E002E0020001U001U000020083000MEM0A003A0030000k001U000010040k006880600160010000A000k00000U020Q0014A01U01V001U0002000E00000E0106000mA00k00kk00k0001U00M00000800U1U009400800E800E0000M00800000400E0M004W00600M600M0000A00A00000200806002E00100A30080000200400000100401U018000k040U0A00003006000000k0200M01a000M060M0600001003000000M0100601X000606060600001U03000000401U03U1UU001U703U600000k01U00000301U00k1UM000s700s600000k00U000000s3k00C1U60007y007y00000M00k0000007zU003XU100000000000000M00E000000000000T0000000000000000A00M00000000000000000000000000000400800000000000000000000000000000600A000000000000000000000000000002006000000000000000000000000000003006000000000000000000000000000001U03000000000000000000000000000001U01000000000000000000000000000000k01U00000000000000000000000000000E00U00000000000000000000000000000M00k00000000000000000000000000000A00E00000000000000000000000000000600M00000000000000000000000000000300A000000000000000000000000000000U0A000000000000000000000000000000M060000000000000000000000000000007060000000000000000000000000000000s70000000000000000000000000000000Dz00000000000000000000000000000000y000000000000000008"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_dungeon_throne()
{
    Text:="|<>**50$199.000000000000000000000000000000001U00000000000000000000000000000003k00000000000000000000000000000001U0000000000000000000003zzzzzzzzz1U0000000000000000000003k00000001kk0000000000000000000001U00000000AM0000000000000000000001U000000002A0000000000000000000000k000000001a0000000000000000000000M000000000m00000000000000000000008000000000N00000000000000000000004000000000AU00000000000000000000020000000006E0000000000000000000001U00000000380000000000000000000000k000000001400000000000000000000008000000001W00000000000000000000007000000001l00000000000000000000001zzzk03zzzkU0000000000000000000000000801U000E0000000000000000000000000400k000800000Ty000000000000000000200M000400003y7w000Dy0Dy000000000100A000200007U07U00T7kzDs000000000U0600012000D000w00M0As0D000000000E030000VU00C000700803k01k00000000801U000EM00Q0000s0A01k00A00000000400k0008600Q0000C0600k003U0000000200M00041U0Q00003U3000000k0000000100A00020M0M00000s1000000A00000000U0600010A0Q00000A0U00000300000000E030000U30A0000030E000000k0000000801U000E0UA000000k8000000M0000000400k00080MA0000008400000060000000200M00040A60000006200000010000000100A0002022000000110000000k0000000U0600010130000000kU000000M0000000E030000U0l000zU00ME00000040000000801U000E0MU00sQ0048007y0030000000400k00080Ak00k300240073U01U000000200M000406M00k0k01W0060M00k000000100A000203A00k0A00l006060080000000U06000101Y00M0600MU03010040000000E030000U0W0080100AE0100U020000000801U000E0F00400U02800U0E010000000400k00080MU0200E01400E0A00U000000200M000408E0100801W0080600E000000100A00020A800k0A00l004030080000000U0600010Q400M0400MU0201U040000000E030000Uw30060600AE0100k020000000801U000Es1U01UC004800U0M010000000400k000800E00QS002400E0A00U000000200M0004A08003w00320080600E000000100A00023U60000001V004030080000000U0600010s10000000UU0201U040000000E030000UA0k000000kE0100k020000000801U000E308000000E800U0M010000000400k00081U6000000M400E0A00U000000200M00040E1U00000M20080600E000000100A0002080M00000M1004030080000000U060001040A00000A0U0201U040000000E030000U20300000A0E0100k020000000801U000E100s0000Q0A00U0M010000000400k000A1U0C0000Q0600k0A01U000000300M00060k01k000s0100M0200k0000001U0800011k00S000s00k0M01U0k0000000M0A0000nk003k03k00C0s00S1s0000000D0Q0000DU000TkzU003zs003zk00000001zw0000300000zw00000000000000000000000000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_mountain_temple()
{
    Text:="|<>**50$199.0000000007zk000000000000000000000000000000D0S000000000000000000000000000000603000000000000000000000000000000600k000000000001zzzzzzzzw00000000300M000000000001s00000000000000001U04000000000000k00000000000000000k02000000000000k00000000000000000M01000000000000M00000000000000000A00U00000000000A00000000000000000600E000000000004000000000000000003008000000000002000000000000000001U0A000000000001U00000000000000000k06000000000000k00000000000000000A02000000000000M000000000000000007070000000000004000000000000000001zz0000000000003U000000000000000003s0000000000000zzzs01zzy000000000000000000000000000400k00000000000000000000000000000200M00000000000000000000000000000100A000001zU7zU0zs07z07z0000000000U0600400DzyDXw1zz0DXsTbw000000000E0300300S03i061U0kA06Q07U00000000801U00k0Q00S01UU0A401s00s00000000400k00M0M00600Ek06600s00600000000200M0040s001008M03300M001k0000000100A0020s000004A00VU00000Q00000000U060010M000002400EU00000600000000E03000UM0000012008E000001U0000000801U00EM000000V0048000000M0000000400k008M000000EU024000000A0000000200M004A0000008E01200000030000000100A00KA0000004800V0000000U0000000U0600/40000002400EU000000M0000000E0300D600000012008E000000A0000000801U07X0000000V004800000020000000400k021001z000EU024003z001U000000200M011U01ks008E012003Vk00k000000100A01Uk01UC004800V0030A00M0000000U0600kM01U3002400EU03030040000000E0300M800k0k012008E01U1U020000000801U08400E0M00V004800U0E010000000400k0420080400EU02400E0800U000000200M02100A02008E0120080600E000000100A010U0201004800V004030080000000U0600UE01U1U02400EU0201U040000000E0300E800k1U012008E0100k020000000801U08600A1k00V004800U0M010000000400k063003Vk00EU02400E0A00U000000200M030U00zU008E0120080600E000000100A01UM0000004800V004030080000000U0600EA0000002400EU0201U040000000E0300A200000012008E0100k020000000801U071U000000V004800U0M010000000400k01UE000000EU02400E0A00U000000200M00kA0000008E0120080600E000000100A00830000004800V004030080000000U060040k000002400EU0201U040000000E030020Q0000012008E0100k020000000801U0107000000V004800U0M010000000400k00U1k00000Ek02600E0A00U000000200M00E0Q001008M03300M0600k0000001U0A00003U01k0A401UU0A0100M0000000k0400000w03w0A301UM0A00k0M0000000A06000007kT7US0s3k70Q00D0w00000007UC000000Ty0zw0DzU1zw001zs00000000zy000U"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_rain_village()
{
    Text:="|<>**50$199.0003zs000000000000000000000007zk1U007U700000000000000000000000D0C1k00301U00000000000000000000006030k00300M0000000000003z000000zs600kk001U0A0000000000007Uk00000sD300MM000k0200000000000070A00000M1lU04A000M01000000000000C0300000M0Ck026000A00U00000000000601U0000A03E012000400E00000000000600M0000A00w00V000300800000000000300A0000600S00EU001U0400000000000100200002007008E000k06000000000000k01U0003007U0A8000M03000000000000M00E0001003k064000601000000000000400A0001U01A0220003U3U0000000000030060000k01b0710000zzU000000000001U01U000k00lzz0U0001w0000000000000M00k000M00k1s0E000000000000000000A00A000M00M00080000000000000000003006000A00M00040000000000000000001U01U00A00A00023zk0Tw03zU3zU000000M00k00600A0zs17ly0zzU7lwDny000000A0080020061zz0X030k0M603C03k0000030060030061U0kF00kE06200w00Q000001U010010030U0A8008M03300Q003000000M00k01U030k064004A01VU0A000s00000A00M00U01UM012002600Ek00000C00000300600k01UA00V0012008E000003000001U0300M00k400EU00V0048000000k00000M00k0M00k2008E00EU024000000A00000A00M0A00M10048008E01200000060000030060A00M0U024004800V0000001U00001U030600A0E012002400EU000000E00000M00U200A0800V0012008E000000A00000A00M30060400EU00V00480000006000003004100602008E00EU0240000001000001U031U03010048008E012001zU00k00000M00UU0300U024004800V001ks00M00000A00Mk01U0E012002400EU01U600A00000300AM01U0800V0012008E01U1U02000001U03M00k0400EU00V004800k0k01000000M01g00k02008E00EU02400E0800U00000A00Q00M010048008E0120080400E00000200C00M00U024004800V00403008000001U0200A00E012002400EU0201U04000000E0000400800V0012008E0100k02000000A0000600400EU00V004800U0M01000000200002002008E00EU02400E0A00U000001U00030010048008E0120080600E000000E0001000U024004800V00403008000000A0001U00E012002400EU0201U0400000020000U00800VU012008E0100k020000001U000k00400Ek00V004800U0M010000000E000E002008M00EU02400E0A00U000000A000M001004A008E0120080400E00000020008000U022004800V004020080000001U00A000E011002400EU0201U040000000E004000800Uk012008E0100U020000000A006000400EM00V004800U0M01000000020020002008400EU02400E0A00U0000001U0300010043008M0130080600E0000000E010000k020U04A01VU0A0300M0000000A01U000M030M06200kE0600U0A0000000301U000401U6061U0kA0600M0A00000001k1k000301U3kD0Q1s3UC007US00000000C3U0000s3k0Ty07zk0zy000zw000000003zU0000DzU0U"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_storm_hideout()
{
    Text:="|<>**50$199.000000000000000000000000000zy0000000000000000000000000000001s1k000000000000000000000000000000k0M000000000000000000000zw0000zw0k06000000000000000000001sD0001w7UM03000000000000000000001U0k000k0MA00U00000000000000000000U0A000k06600E00000000000000000000k06000M03300800000000000000000000M01000801V00400000000000000000000A00U00400kk0200000000000000000000600E00200MM01000000000000000000002008001004A01U00000000000000000001004000U02600k00000000000000000000U02000E011U0E00000000000000000000E01000800Us0s00000000000000000000800U00400EDzs00000000000000000000400E0020080T0000000000000000000002008001004000000000000000000000001004000U02000000000000000000000000U02000E010000000C07z0Dy007z000000E01000800U7z0000zkDXsS7s0T3s00000800U00400EDzs003wQA06M0C0w0700000400E002008A06007U6401s01ks01k00002008001004401U0D01a00s00Qk00A00001004000U02600k0C00n00M006k00300000U02000E01300M0A00NU08001k000k0000E01000800VU040A004U00000E000A0000800zzzw00EU020A006E00000000060000400Tzzy008E010A0038000000000100002000000004800UA001Y0000000000k0001000000002400E6000W000000000080000U0000000120086000l000000000040000E00000000V0042000MU00000000030000800000000EU023000ME0000000001U0004000000008E011000M80000000000E0002000000004800VU00s4007s003s0080001000000002400Ek0002007C00360040000U000000012008E00E100230031U020000E00000000V004800M0U030k01UE010000800000000EU02A00M0E01UM00UA00U0004000000008E01600M0800U400E600E000200Dzzz004800X00A0400E200810080001004000U02400FU040200810040U040000U02000E012008k02010040U020E020000E01000800V004M01U0U020E0108010000800U00400EU02A00k0E010800U400U000400E002008E01600A0800U400E200E0002008001004800V0070400E200810080001004000U02400EU01U200810040U040000U02000E012008M00010040U020E020000E01000800V004A0000U020E0108010000800U00400EU0220000E010800U400U000400E002008E011U000800U400E200E0002008001004800Uk000400E200810080001004000U02400EA000200810040U040000U02000E012008200010040U020E020000E01000800V0041U000U020E0108010000800U00400EU020M000E010800U400U000400E002008E0106000800U400k200E0003008001004800U1U00600E200M10080001U04000U06600E0M00300M1U0A0U040000k06000M03300M06000U0A0k040M060000803000A010U0A01k00M0A0A060A030000603000301UM0A00C0070S07UC03k700001s7U000s3U70S001w01zw00zy00Ty00000Dz0000DzU1zw000DU"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_haunted_mansion()
{
    Text:="|<>**50$199.000000000000000003zw0000000000000000000000000000003U7000000000000000000000000000000300k000000000000000000000000000001U0M00007z000000000000000000000000U040000Dns000000zk000000000000000E020000A06000001zz0000000000000008010000401U00001U1k00000000000000400U000600M00001U0M00000000000000200E000300600001U040000000000000010080001U0300000k02000000000000000U040000k00k0000k01000000000000000E020000E00A0000k00U00000000000000801000080030000k00E00000000000000400U0004001k000s00800000000000000200E0002000M000M00400000000000000100800010006000M002000000000000000U040000U001U00M001000000000000000E020000E000s00Q000U0000000000000080100008000A00A000E00003zs0000000400U0004000300A000Dz000Tzzk00007y200E00020000k0A0007zs00w00S0000Tzt00800010000A0A00000601k001k000w07U040000U000606000001U3U000Q001s01k020000E0001U6000000k3U0003001k00801000080000M60000008300000k01U00000U00040000660000004300000A01U00000E00020000330000002300000301U000008000100000n00000013000001U1U0000040000U0000D0000000X000000M1U0000020000E000030000000FU0000040k0000010000800U01U0100009U0000030k000000U000400E00000U000Ak000001UE000000E000200A00000k0006k003U00EM0000008000100700000s0006M007y008800000040000U02k0000o000D800C3U06A00000020000E01M0000O00zy400C0k036003y0010000800a0000N00E0600A0801W003XU00U000400FU000MU08030060A00l0030M00E0002008k000AE0401007zy00MU03060080001004A000A80200U000000Ak03030040000U023000A40100E0000004M01U0U020000E010k00A200U080000002A00U0M010000800UM006100E040000003600E0A00U000400E60060U08020000001300A0600E00020081U060E04010000001VU060200800010040M07080200U000003Uk01U30040000U020A030401U0M000007U800s30020000E0103030200k0A00Tzzz0400C30010000800U0s7010080600A00003001z000U000400E07z00U07w100300TU1U004000E000200800000E007Uk00s0wQ0E00000080001004000008000MM007zk70A00000040000U0200000400064000001U600000020000E0100000200033000000M1U0000010000800U000010001Uk00000A0E000000U000400E00000U000EM0000020A000000E000200800000E00086000001030000008000100400000800041U00000U0k0000040000U0200000500020k00000E0A0000020000E01000002k0030A000008030000010000A00U00001A001U3U0000A00k00400U000600k00000nU00U0s0000600C00700k000100M00000Mw00k070000C001k0Dk0s0000k0M0000047s1k00s000S000DUyS1s0000D0s0000000Tzk007k07w0001zs3zk00001zs0000000000000TzzU0000000000000000000000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_nightmare_train()
{
    Text:="|<>**50$199.000000000000000000000000zzzzzzzzzU00000000000000000000000w00000000E00000000000000000000000M00000000000000000000000000000000M00000000000000000000000000000000A000000000000000000000000000000006000000000000000000000000000000002000000000000000000000000000000001000000000000000000000000000000000k00000000000000000000000000000000M00000000000000000000000000000000A000000000000000000000000000000002000000000000000000000000000000001k00000000000000000000000000000000Tzzw00zzzk00000000000000000000000000200M00000000000000000000000000000100A000000000000000000Tz0000000000U060000zk3zk0Tw0zy003zzy000000000E030007zz7ly0yDVk7k07U03k00000000801U01j01r030k0PU0Q0C000C00000000400k01i00D00kE07U060Q0003U0000000200M00Y003008M03001UQ0000M0000000100A00k000U04A00000kM0000600000000U0600M000002600000MM00001U0000000E0300A0000012000004M00000M0000000801U04000000V000006M00000A0000000400k02000000EU00003M0000030000000200M010000008E00001g000000U000000100A00U000004800000g000000M0000000U0600E000002400000q000000A0000000E03008000001200000S000Q0020000000801U04000000V00000P000zk010000000400k02000000EU00TkN001kQ00k000000200M0100zU008E00QTsU01k600M000000100A00U0sQ004800M00k01U100A0000000U0600E0k7002400M00M00k1U060000000E030080k1U01200800800zzk030000000801U040M0M00V0040040000001U000000400k02080A00EU020020000000U000000200M010402008E010010000000E000000100A00U601004800U00U000000M0000000U0600E100U02400E00E00000080000000E030080k0k012008008000000A0000000801U040M0k00V004004000000Q0000000400k02060s00EU02003000000w0000000200M0101ks008E01001U03zzzs0000000100A00U0Tk004800U00k01U00000000000U0600E000002400E00800M03w00000000E03008000001200800600707XU0000000801U04000000V004003000zy0s0000000400k02000000EU02000U00000A0000000200M010000008E01000M0000030000000100A00U000004800U006000001U0000000U0600E000002400E003000000E0000000E030080000012008000k0000080000000801U04000000V004000A0000040000000400k02000000EU0200060000020000000200M010000008M010001U000010000000100A00m000U04A01U000Q00001U0000000k0600Nk00s06600k000700000k0000000M0200AS01y061U0k0000s0001k00000006030033sDXkD0Q1s000070003k00000003k7000kDz0Ty07zk00000y00zU00000000Tz0008000000000000003zzw000000000000002"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_future_city()
{
    Text:="|<>**50$199.000000000000000000000000000001zw0000000000000000000000000000003U3U0000000000000000000000000C0001U0k000000000000000000000000DzzU00U0A000000000000000000000000y00y00k06000000000000000000000003k001s0M01000000000000000000000007U000C0800U0000000000000000000000700001k400E0000000000000000000000C00000C20080000000000000000000000Q000003V0040000000000000000000000Q000000MU020000000000000000000000M000000AM010000000000000000000000M0000002A01U000000000000000000000M0000001300U000000000000000000000M0000000Vk1k000000000000000000000M0000000ETzk000000000000000000000A00000008000000000000000000000000A0000000A00000000000000000000000040003y00A0000000000000001zk0000006000Drs060000Dy03zU7zU00Tszk000002000Q0D0607w047U7kwC0S00w00S000003000s01k60T7kA0M603Q03U1k001k00001000s00CC0M0AA06200s00E3U000A00001U00k001w0802403300M00A3U000300000k00k00000A01a00VU00006300000k0000E00k00000600H00EU00001300000A0000800E000002009008E00000X0000030000A00M000001004U04800000n000000U0006008000000U02E02400000P000000M000300A000000E01801200000BU0000040001006000000800Y00V000005U0000030000U02000000400G00EU00006k000000U000E010000002009U08E00003k003U00E000800U000001004k04800003M007y008000400E000000U02A024003y3800C3U040002008000000E017012003Xz400C0k030001004000000800UU0V00300600A0801U000U02000000400E00EU030030060A00k000E010000002008008E01001003zw00M000A00k000001004004800U00U00000080006008000000U02002400E00E00000040001006000000E01001200800800000020000U01000000800U00V00400400000030000E00k00000400E00EU0200200000010000A00A000002008008E010010000001U00020030003k1004004800U00U000001U0001000k007C0U02002400E00M000007U0000k00A00C3UE01001200800A00Tzzz000008003U0Q0k800U00V00400200A000000006000S1w0A400E00EU0200100300DU000010001zk032008008E01000k00s0wQ00000k0000000V004004800U00M007zk600000A0000000MU02002400E004000001U0000200000004E010012008003000000M00001U0000002800U00V004000U00000A00000M0000001400E00EU02000M0000020000060000000W008008E010006000001000001U000000F004004800U001000000U00000M000000MU02002400E000k00000E000007000000ME010012008000A000008000000k00000M800U00VU0A0003U0000A000000C00000s600k00kE060000s000060000001k0001k100M00kA06000070000C0000000C0003U0k0M01k3UC00000s000Q00000001s00D00C0M1zk0zy000007k03s000000007s1w003zs000000000000Tzz0000000000DzU000000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_walled_city()
{
    Text:="|<>**50$199.s000000000000000TzU00000000000003i000000000000000Q0s00000000000007VU00000000000000M06000000000z00030k00000000000000A0300000000Tzz0030800000000000000400U0000001w01w01U400000000000000200E0000007k007k0k2000000000000001008000000D0000S0M1000000000000000U04000000S00003UA0U00000000000000E02000000Q00000Q40E00000000000000801000000s00000730800000000000000400U00000s000000lU400000000000000200E00000s000000Mk200000000000000100800000k0000004M1000000000000000U0400000k000000260U00000000000000E0200000k00000013UE0000000000000080100000k0000000Uw800000000000000400U0000M0000000k0400000000000000200E0000M0000000M02000000000000001008000080007w00M0100000Dz00000000U040000A000Tjk0A00U0003zjy00000zkE0200004000s0S0A0ME0007U03k0003yz80100006001k03UA0w8000C000C0007U0w00U0002001k00QQ0k4000Q0003U00C00C00E0003001U003w0E2000Q0000M00C0010080001U01U00000M1000M0000600A0000060000U01U00000A0U00M00001U0A0000020000E00U0000060E00M00000M0A0000010000M00k0000020800M0000040A000000U000A00E0000010400M0000030A000000E000600M000000U200A000000U60000008000200A000000E100A000000M60000004000100400000080U06000000A200000020000U0200000040E06000Q002300000010000E0100000020803000zk0110000000U000800U0000010401001kQ00lU000000E000400E000000U200U01k600Mk00Tk0080002008000000E100k01U100AE00QQ004000100400000080U0M00k1U06800M30020000U0300000040E0800Tzk03400M0k010000M01U00000208040000001600M0M00U000A00E00000104020000000X00A0400E000200A000000U2010000000FU04030080001002000000E100U000000Mk0201U040000U01U0000080U0E0000008M01U0k020000M00M0000040E08000000AA00k0E01000040060007U20804000000Q600A0M00U0002001U00Tw10403000000w10030M00E0001U00Q00Q70U301U03zzzs0U01kM0080000E007U0s1UE0zUE01U0000M00Ds0040000A000w3s0M801w800M01w0A0000002000020003zU064007600707XU2000000100001U00000012001X000zy0k1U000000U0000M0000000l000EU00000A0k000000E0000400000008U00AM0000030A00000080000300000004E0064000001U2000000400000k000000280013000000E1U00000200000A00000014000Uk0000080M0000010000030000000W000EA00000406000000U00000k000000l000M600000201U00000E00000C000000kU00A1U0000100M000008000001U00001kE0040Q00001U06000U04000000Q00001kA0060700000k01k00s060000003U0003U200700s0001k00C01y030000000Q000701XUD0070003U001w7nkD00000003k00S00Qzy000y00T00007z0Ty00000000Dk7s007000003zzw000000000000000000Tz0000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_cursed_festival()
{
    Text:="|<>**50$199.000000001zy0000000000000000000000000000001k3U000000000000000000000000000001U0M000000000000000000000000000000k0A00003zzzzzzy000000000000000000E0200007U000003U00000000000000000801000060000000M00000000000000000400U00030000000600000000000000000200E0003000000030000000000000000010080001U0000001U00000000000000000U040000k0000000E00000000000000000E020000M0000000800000000000000000801000080000000400000000000000000400U00040000000200000000000000000200E000200000001000000000000000001008000100000001U00000000000000000U040000U0000000k00000000000000000E020000E0000000M00000000000000000801000080000000M00000000000000000400U00040000000s000000000Q0000000200E000200Dzzzzs00Tz00000Ds00003z100800010040000003zzy0001sD0000DzwU040000U020000007U03k003k0s000S03k020000E01000000C000C00700C000w00s010000800U00000Q0003U07001U00s00400U000400E00000Q0000M06000M00k00000E000200800000M0000606000600k0000080001007zzz00M00001U30001U0k0000040000U00001s0M00000M30000k0k0000020000E0000060M00000A1U000A0k000001000080000010M0000030U00020M000000U0004000000kA000000UE0001UM000000E0002000000MA000000MM0000k800000080001000000A6000000AA00008A00000040000U0000066000Q002603004400000020000E0000013000zk01301k036000000100008000001V001kQ00lU0M01X001z000U0004000000kU01k600ME0400l001lk00E0002000000Mk01U100A80600MU01UA0080001000000AM00k1U0640700AE01U30040000U000004800zzk03300006M01U1U020000E00000640000001VU0002A00k0E010000800000C20000000UM0001600E0A00U000400Tzzy10000000EA0001X0080600E00020080000U000000M30000VU060300800010040000E00000081k000kk03010040000U0200008000000A0Q001kM00k1U020000E0100004000000Q07U03k400Q1U010000800U0003000000w00wzzU20071U00U000400E0001U03zzzs007U001U00zU00E00020080000k01U00003ykDk0k002000800010040000800M03w033kSC0800000040000U020000600707XU30Ts3U600000020000E0100003000zy0s1U200k300000010000800U0000U00000A1U000A0k000000U000400E0000M0000030U000608000000E000200800006000001Uk0001060000008000100400003000000EM0000U1U0000040000U0200000k00000880000E0M0000020000E0100000A000004400008060000010000A00U0000600000230000401U00000U000600E00001U000011U000600M00200E000300800000Q00001UQ0003007003U0M0000U0A00000700000k70007000s07s0Q0000M0A000000s0001k0w00D0007kTD0w000070S00000070003k07U3y0000zw1zs00001zw0000000y00zU00Tzk000000000000000000000003zzw0000k"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_spirit_town()
{
    Text:="|<>**50$199.007zk000000000000000000000000000000D0C000000000000000000000000000000603000000000000000000000000000000600k0000000001zzzzzzzzz0000000000300M0000000003k00000001k0000000001U0400zk000001000000000A0000000000k0203wz000001U0000000020000000000E0101U1k00000k0000000010000000000800U1U0M00000E000000000k000000000600E0U04000008000000000M00000000030080E02000004000000000A0000000001U0A080100000200000000060000000000k060400U00001U0000000020000000000A020200E00000k000000001000000000070701008000008000000001U0000000001zz00U04000007000000001k00000000000000E02000001zzzk03zzzk00000000000000801000000000801U00000000000000000400U00000000400k00000000000000000200E00000000200M00001zs0000Dk0zs0T00Dz0000000100A0000DsTk003sS1yz0zU07zs0000000U060000S00S00D03VU0kk000060000000E030000s001k0C00kU0AE00001U000000801U000s000Q0A00Ak06M00000k000000400k001k0003UA006M01A000008000000200M001k0000s6003A00a000004000000100A001U0000C2000Y00G0000020000000U06001U00003V000m0090000010000000E03001U00000kk00N004U00000U000000801U00k00000AM00AU02E00000E000000400k00k0000034004E01A000008000000200M00k000000X006800a00000A000000100A00M000000NU03400H0000060000000U060080000004E032008k000060000000E0300A0000003A031004Q0000D0000000801U04001y001W0z0U023w00zy0000000400k02003Vk00FU00E010200E00000000200M030030A008E00800U100800000000100A01U0303006A00400E0U04000000000U0600U0300U0360020080E02000000000E0300E01U0M01V0010040801000000000801U0800U0400Ek00U020400U00000000400k0400E02008800E010200E00000000200M0200801004600800U100800000000100A0100400U02300400E0U04000000000U0600U0300k030U020080E02000000000E0300E01U0E01UM010040801U00000000801U0A00M0M00k400U020400k00000000400k060060M00E300E010200800000000200M01001ks0081U0800U1007w0000000100A00U00Dk00A0E0400E0U007U0000000U0600M00000060A020080E000M0000000E03004000000202010040800040000000801U0300000030100U020600030000000400k00U0000010000E01010000U000000200M00M000001U000800U0U000E000000100A006000001U000400E0M00080000000U06001000001U00020080400040000000E03000k00000k00010040300020000000801U00A00000k0000k0200k0030000000400k003U0001k0000M0300A001U000000300E000s0001k0000401U03000U0000001U0800060001U0000301U00w00k0000000M0A0001k003U00000s3k007k1k000000060Q0000D00D000000DzU000Tzk00000001zw00001y1y0000000000000000000000000000003zk0000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_hellish_city()
{
    Text:="|<>**50$197.7zk00000001zw0000000000000000000yw0s0000000D0C0000000000000000007VU0k0000000M0A00000000000007w000A600k0000001U0A0000000000007zzk00kA01U000000300M000000000001w01w01UM010000000600E00000000000T000T030k020000000A00U00000000003k0007U61U040000000E0100000000000S00003U820080000000U0200000000001k00001kE600E00000010040000000000C000001kkA00U00000020080000000000s000000lUM030000000400E0000000003U000001X0k060000000800U000000000A000000160k080000000E010000000000k000000261k1k0000000U02000000000300000004C1zz00000001004000000000A00000008DkDU00000002008000000000M0000000k0U000000000400E000000001U0000001U00000000000800U0000000020001z00600000003zk00E01000000000A000Tzk0A00Dy003zzy00U023z0000000E003k1s0k1tzz00S00DU1004zzk000001U00Q00s30Dq0303U003k200/U1s000002001k00QQ0k8030C0000s400Q00Q00000A006000Dk10k060k0000k800k00A00000M00M0000061U0A300000kE01000A00000U01U00000A3008600001UU00000A00001003000000M400EM000031000000A0000600A000000U800Uk000062000000A0000A00E0000010E0110000084000000A0000M01U0000020U02200000k8000000M0000U0300000041004A000010E000000M000100400000082008M03zU60U000000k0002008000000E400Ek063sM10000000k000400E000000U800VU0A0zU20000001U000800U0000010E01300T000400000010000E0100000020U02200Dw008003y0020000U02000000410044000T00E00SC00600010040000008200880003k0U01k600A000200A000000E400EM0001s10030600M000600M000000U800Uk0000s200A0A00E000A00E0000010E010U0000M400E0800U000M00k0000020U021U0000M800U0E010000E01U00000410041U0000kE0100k020000U01U00000820083U0000kU0201U040001U01U00000E400E3U0001V004030080001003U001s0U800U3k000120080600E0003003U00Tw10E0101s0002400E0A00U0006001k01kQ20U0200w0006800U0M0100004001s0C0M410041zTU00AE0100k020000A000y3s0M8200867Xy00MU0201U0400008000Dy00ME400EM3kC00l004030080000M0000000EU800Uk1sA01W0080600E0000M0000000l0E01300Tk03400E0A00U0000k0000000W0U024000006800U0M0100000k000000141004M000008E0100k0200000k000000282008k00000EU0201U0400000k0000004E400F000001V0040300800000k0000008U800W00000320080600E00000s000000l0E01400000A400E0A00U00000s00000320k02A00000EA00U0M01000000M00000Q61U0AC00001UM0300k06000000Q00001kA100MC0000C0E0600U0A000000C0000C08301U7U001s0k0M01U0k00000070001s0M3UD03k00T00s3k01k7U0000003k00S00Q3zs00zUzk00zy001zw00000001z0TU00T000007zk0000000000000000007zk0001"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_strange_town()
{
    Text:="|<>**50$199.00000000000000000000000Dzzzzzzzzs00000000000000000000000Q000000006000000000000000000000008000000001U0000000000000000000000A000000000E00000000000000000000006000000000800000000000000000000002000000000400000000000000000000001000000000200000000000000000000000U00000000100000000000000000000000E000000000U0000000000000000000000A000000000E00000000000000000000006000000000800000000000000000000001000000000A00000000000000000000000s00000000C00000000000000000000000Dzzy00Tzzw00000000000000000000000000100A000000000000000000000000000000U060000000000000000007z0000000000E030001000001zU7zU001zXz000000000801U000y00007sy70w003k01s00000000400k0003k000D01q03007000700000000200M0000Q000C00C01U0C0000k0000000100A00003000Q00300E0C0000A00000000U06000A0s00Q0000080A0000300000000E03000C0A00M0000040A00000k0000000801U00A0300M0000020A00000A0000000400k00A00k0Q0000010A0000020000000200M00400A0A000000UA000001U000000100A0060060A000000E6000000E0000000U06006001UA00000086000000A0000000E03002000E60000004300000020000000801U03000A200000023000C0010000000400k010006300000011U00Ts00U000000200M01U0011000Q000UU00sC00E000000100A00U000UU01zU00EE00s300A0000000U0600E000Mk01kQ008M00k0U060000000E0300M000AM01k6004A00M0k030000000801U0A0U02800k1U02400Dzs01U000000400k040E01400E0E0120000000U000000200M020800W00M0A00V0000000E000000100A010400F0080600EU00000080000000U0600U2008U0603008E000000A0000000E0300E1004E0301004800000040000000801U080U02800k1U02400000060000000400k040E01600A1U01200000060000000200M020800X0071U00VU00000S0000000100A01U400EU00zU00Ek01zzzw00000000U0600E2008E0070008800k00000000000E030081004A0000004400A00y00000000801U040U02200000023003U3lk0000000400k030E011U0000011U00Tz0M0000000200M00U800Uk000000UE0000060000000100A00M400EA000000EA000001U0000000U060042008300000082000000k0000000E0300310041U0000041U0000080000000801U00kU020M0000020M0000040000000400k008E0106000001040000020000000200M006A00U1k00000U30000010000000100A001a00E0Q00200E0k00000U0000000U04000T008030030080C00000k0000000M020006U0A00s07U0403U0000M0000000A010000M0A007kyE0200Q0000s0000000301U00070S000TsM01003U001k00000000k3U0000zw00D00A00U00T00DU00000000Dz000000000Ts0A00E001zzw00000000000000000000MC0A00800000000000000000000000000M1kC00A00000000000000000000000000M0Dw00600000000000000000000000000A00E00200000000000000000000000000A000003000000000000000000000000004000001000000000000000000000000002000001U00000000000000000000000001000000U00000000000000000000000000U00000k00000000000000000000000000E00000k00000000000000000000000000A00000k00000000000000000000000000300000k000000000000000000000000000s0000k000000000000000000000000000C0001k0000000000000000000000000001k003U0000000000000000000000000000D007U00000000000000000000000000001y0y0000000000000000000000000000003zs0000000000000000000000002"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_planet_greenie()
{
    Text:="|<>**50$199.00000000000000000001zzU00000000000000000000000000000Ds1z00000000000000000000000000000S001s00000000000000000Dw000000000s000700000000000000000zDk00000001k0000s0000000000000000M0Q00000003U0000C0000000000000000M0600000003U00001k00000000000000080100000003000000A000000000000000400U00000030000003000000000000000200E00000030000001U00000000000000100800000030000000E000000000000000U04000000300000008000000000000000E02000000300000004000000000000000801000000300000006000000000000000400U000001U0000003000000000000000200E000001U00000030000000000000001008000001U001zs01U000000000Dz0000U04000000k007UD01U000000003zjy007k03zk0000k00700s1U0Dy0Ty007U03k0Ds01zy0000M00C0073U0S3ks1s0C000C0A00001U000800C001zU0M0Bk0C040003U400000M000A00C000000803U010A0000M600000A000600C000000A01U00kC0000630000020002006000000600000MA00001VU0000100010060000002000004A00000MU00000U001U0301zzzs1000002A000004E00000E000k0303s00T0U00003A0000038000008000M01U1U000kE00001g000000Y000004000800U1U000A800000q000000O000002000400E0k0006400000K000000BU0000300020080M0001200000P000Q002k00001U001004080000V00000D000zk01A00001U000U02040000EU0000BU01kQ00r00003k000E010200008E00DsAU01k600Mz00DzU000800U1U0004800CDwE01U100A0U0400000400E0k0002400A00M00k1U060E0200000200A0M0001200A00A00Tzk030801000001U02060000V00400400000010400U00000k01U1zw00EU020020000000U200E00000800k0Dy008E010010000000E100800000400A001004800U00U000000M0U04000003002000U02400E00E00000080E02000001U01U00E012008008000000A0801000000E00M00800V004004000000Q0400U00000A00600400EU02002000000w0200M000006001k02008E01001U03zzzs0100A000001U00C01004800U00k01U00000U02000000k003k7U02400E00800M01w00E01z00000A000Dz001200800400707XU08001s0000600000000V004003000zy0k04000600001U0000000EU02001U00000A02000100000M00000008E01000E00000301U000k0000400000004800U00A000001U0E00080000300000002400E002000000E08000400000k00000032008001U00000806000200000A00000031004000M0000040100010000030000001UU02000400000200k000U00000s000001UE01000300000100A000k00000C000003U800U000k00001U03000M000001k00003U600E000C00000k00k008000000Q000070100M0003s0001k00D00A0000003U000C00k0M0000L0003U001w0Q0000000S000w00C0s00000y00T00007zw00000001y0Ts003zs000003zzw0000000000000003zy00000000001"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

; Function to search for a specific pixel color
SearchPixelColor(color, x1, y1, x2, y2)
{
    if PixelSearch(&Px, &Py, x1, y1, x2, y2, color, 10) {
        return true
    } else {
        return false
    }
}

Place_Upgrade_Units() {
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    x_coord := 750
    y_coord := 670

    Loop {
        if !ImagesFound_Yes_3() {
            if (Unit_Slot_1 != 0) {
                if (Unit_Slot_1 >= 1) {
                    Loop {
                        if ImagesFound_Return() || ImageFound_next() {
                            break
                        }
                        Send("{1}") 
                        SendClick(x_coord, y_coord)
                        Send("{q}") 
                        Sleep(100)
                        if ImageFound_unit_placed() {
                            Upgrade_Maxed()
                            break
                        } else {
                            x_coord := x_coord + 25
                        }
                        if ImagesFound_Return() || ImageFound_next() {
                            break
                        }
                        if x_coord >= 1700 {
                            x_coord := 500
                            y_coord := y_coord - 75
                        }
                        if y_coord <= 250 {
                            y_coord := 900
                        }
                    }
                    if (Unit_Slot_1 >= 2) {
                        Loop {
                            if ImagesFound_Return() || ImageFound_next() {
                                break
                            }
                            Send("{1}") 
                            SendClick(x_coord, y_coord)
                            Send("{q}") 
                            Sleep(100)
                            if ImageFound_unit_placed() {
                                Upgrade_Maxed()
                                break
                            } else {
                                x_coord := x_coord + 25
                            }
                            if ImagesFound_Return() || ImageFound_next() {
                                break
                            }
                            if x_coord >= 1700 {
                                x_coord := 500
                                y_coord := y_coord - 75
                            }
                            if y_coord <= 370 {
                                y_coord := 900
                            }
                        }
                        if (Unit_Slot_1 >= 3) {
                            Loop {
                                if ImagesFound_Return() || ImageFound_next() {
                                    break
                                }
                                Send("{1}") 
                                SendClick(x_coord, y_coord)
                                Send("{q}") 
                                Sleep(100)
                                if ImageFound_unit_placed() {
                                    Upgrade_Maxed()
                                    break
                                } else {
                                    x_coord := x_coord + 25
                                }
                                if ImagesFound_Return() || ImageFound_next() {
                                    break
                                }
                                if x_coord >= 1700 {
                                    x_coord := 500
                                    y_coord := y_coord - 75
                                }
                                if y_coord <= 370 {
                                    y_coord := 900
                                }
                            }
                            if (Unit_Slot_1 >= 4) {
                                Loop {
                                    if ImagesFound_Return() || ImageFound_next() {
                                        break
                                    }
                                    Send("{1}") 
                                    SendClick(x_coord, y_coord)
                                    Send("{q}") 
                                    Sleep(100)
                                    if ImageFound_unit_placed() {
                                        Upgrade_Maxed()
                                        break
                                    } else {
                                        x_coord := x_coord + 25
                                    }
                                    if ImagesFound_Return() || ImageFound_next() {
                                        break
                                    }
                                    if x_coord >= 1700 {
                                        x_coord := 500
                                        y_coord := y_coord - 75
                                    }
                                    if y_coord <= 370 {
                                        y_coord := 900
                                    }
                                }
                                if (Unit_Slot_1 >= 5) {
                                    Loop {
                                        if ImagesFound_Return() || ImageFound_next() {
                                            break
                                        }
                                        Send("{1}") 
                                        SendClick(x_coord, y_coord)
                                        Send("{q}") 
                                        Sleep(100)
                                        if ImageFound_unit_placed() {
                                            Upgrade_Maxed()
                                            break
                                        } else {
                                            x_coord := x_coord + 25
                                        }
                                        if ImagesFound_Return() || ImageFound_next() {
                                            break
                                        }
                                        if x_coord >= 1700 {
                                            x_coord := 500
                                            y_coord := y_coord - 75
                                        }
                                        if y_coord <= 370 {
                                            y_coord := 900
                                        }
                                    }
                                    if (Unit_Slot_1 >= 6) {
                                        Loop {
                                            if ImagesFound_Return() || ImageFound_next() {
                                                break
                                            }
                                            Send("{1}") 
                                            SendClick(x_coord, y_coord)
                                            Send("{q}") 
                                            Sleep(100)
                                            if ImageFound_unit_placed() {
                                                Upgrade_Maxed()
                                                break
                                            } else {
                                                x_coord := x_coord + 25
                                            }
                                            if ImagesFound_Return() || ImageFound_next() {
                                                break
                                            }
                                            if x_coord >= 1700 {
                                                x_coord := 500
                                                y_coord := y_coord - 75
                                            }
                                            if y_coord <= 370 {
                                                y_coord := 900
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if (Unit_Slot_2 != 0) {
                if (Unit_Slot_2 >= 1) {
                    Loop {
                        if ImagesFound_Return() || ImageFound_next() {
                            break
                        }
                        Send("{2}") 
                        SendClick(x_coord, y_coord)
                        Send("{q}") 
                        Sleep(100)
                        if ImageFound_unit_placed() {
                            Upgrade_Maxed()
                            break
                        } else {
                            x_coord := x_coord + 25
                        }
                        if ImagesFound_Return() || ImageFound_next() {
                            break
                        }
                        if x_coord >= 1700 {
                            x_coord := 500
                            y_coord := y_coord - 75
                        }
                        if y_coord <= 370 {
                            y_coord := 900
                        }
                    }
                    if (Unit_Slot_2 >= 2) {
                        Loop {
                            if ImagesFound_Return() || ImageFound_next() {
                                break
                            }
                            Send("{2}") 
                            SendClick(x_coord, y_coord)
                            Send("{q}") 
                            Sleep(100)
                            if ImageFound_unit_placed() {
                                Upgrade_Maxed()
                                break
                            } else {
                                x_coord := x_coord + 25
                            }
                            if ImagesFound_Return() || ImageFound_next() {
                                break
                            }
                            if x_coord >= 1700 {
                                x_coord := 500
                                y_coord := y_coord - 75
                            }
                            if y_coord <= 370 {
                                y_coord := 900
                            }
                        }
                        if (Unit_Slot_2 >= 3) {
                            Loop {
                                if ImagesFound_Return() || ImageFound_next() {
                                    break
                                }
                                Send("{2}") 
                                SendClick(x_coord, y_coord)
                                Send("{q}") 
                                Sleep(100)
                                if ImageFound_unit_placed() {
                                    Upgrade_Maxed()
                                    break
                                } else {
                                    x_coord := x_coord + 25
                                }
                                if ImagesFound_Return() || ImageFound_next() {
                                    break
                                }
                                if x_coord >= 1700 {
                                    x_coord := 500
                                    y_coord := y_coord - 75
                                }
                                if y_coord <= 370 {
                                    y_coord := 900
                                }
                            }
                            if (Unit_Slot_2 >= 4) {
                                Loop {
                                    if ImagesFound_Return() || ImageFound_next() {
                                        break
                                    }
                                    Send("{2}") 
                                    SendClick(x_coord, y_coord)
                                    Send("{q}") 
                                    Sleep(100)
                                    if ImageFound_unit_placed() {
                                        Upgrade_Maxed()
                                        break
                                    } else {
                                        x_coord := x_coord + 25
                                    }
                                    if ImagesFound_Return() || ImageFound_next() {
                                        break
                                    }
                                    if x_coord >= 1700 {
                                        x_coord := 500
                                        y_coord := y_coord - 75
                                    }
                                    if y_coord <= 370 {
                                        y_coord := 900
                                    }
                                }
                                if (Unit_Slot_2 >= 5) {
                                    Loop {
                                        if ImagesFound_Return() || ImageFound_next() {
                                            break
                                        }
                                        Send("{2}") 
                                        SendClick(x_coord, y_coord)
                                        Send("{q}") 
                                        Sleep(100)
                                        if ImageFound_unit_placed() {
                                            Upgrade_Maxed()
                                            break
                                        } else {
                                            x_coord := x_coord + 25
                                        }
                                        if ImagesFound_Return() || ImageFound_next() {
                                            break
                                        }
                                        if x_coord >= 1700 {
                                            x_coord := 500
                                            y_coord := y_coord - 75
                                        }
                                        if y_coord <= 370 {
                                            y_coord := 900
                                        }
                                    }
                                    if (Unit_Slot_2 >= 6) {
                                        Loop {
                                            if ImagesFound_Return() || ImageFound_next() {
                                                break
                                            }
                                            Send("{2}") 
                                            SendClick(x_coord, y_coord)
                                            Send("{q}") 
                                            Sleep(100)
                                            if ImageFound_unit_placed() {
                                                Upgrade_Maxed()
                                                break
                                            } else {
                                                x_coord := x_coord + 25
                                            }
                                            if ImagesFound_Return() || ImageFound_next() {
                                                break
                                            }
                                            if x_coord >= 1700 {
                                                x_coord := 500
                                                y_coord := y_coord - 75
                                            }
                                            if y_coord <= 370 {
                                                y_coord := 900
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if (Unit_Slot_3 != 0) {
                if (Unit_Slot_3 >= 1) {
                    Loop {
                        if ImagesFound_Return() || ImageFound_next() {
                            break
                        }
                        Send("{3}") 
                        SendClick(x_coord, y_coord)
                        Send("{q}") 
                        Sleep(100)
                        if ImageFound_unit_placed() {
                            Upgrade_Maxed()
                            break
                        } else {
                            x_coord := x_coord + 25
                        }
                        if ImagesFound_Return() || ImageFound_next() {
                            break
                        }
                        if x_coord >= 1700 {
                            x_coord := 500
                            y_coord := y_coord - 75
                        }
                        if y_coord <= 370 {
                            y_coord := 900
                        }
                    }
                    if (Unit_Slot_3 >= 2) {
                        Loop {
                            if ImagesFound_Return() || ImageFound_next() {
                                break
                            }
                            Send("{3}") 
                            SendClick(x_coord, y_coord)
                            Send("{q}") 
                            Sleep(100)
                            if ImageFound_unit_placed() {
                                Upgrade_Maxed()
                                break
                            } else {
                                x_coord := x_coord + 25
                            }
                            if ImagesFound_Return() || ImageFound_next() {
                                break
                            }
                            if x_coord >= 1700 {
                                x_coord := 500
                                y_coord := y_coord - 75
                            }
                            if y_coord <= 370 {
                                y_coord := 900
                            }
                        }
                        if (Unit_Slot_3 >= 3) {
                            Loop {
                                if ImagesFound_Return() || ImageFound_next() {
                                    break
                                }
                                Send("{3}") 
                                SendClick(x_coord, y_coord)
                                Send("{q}") 
                                Sleep(100)
                                if ImageFound_unit_placed() {
                                    Upgrade_Maxed()
                                    break
                                } else {
                                    x_coord := x_coord + 25
                                }
                                if ImagesFound_Return() || ImageFound_next() {
                                    break
                                }
                                if x_coord >= 1700 {
                                    x_coord := 500
                                    y_coord := y_coord - 75
                                }
                                if y_coord <= 370 {
                                    y_coord := 900
                                }
                            }
                            if (Unit_Slot_3 >= 4) {
                                Loop {
                                    if ImagesFound_Return() || ImageFound_next() {
                                        break
                                    }
                                    Send("{3}") 
                                    SendClick(x_coord, y_coord)
                                    Send("{q}") 
                                    Sleep(100)
                                    if ImageFound_unit_placed() {
                                        Upgrade_Maxed()
                                        break
                                    } else {
                                        x_coord := x_coord + 25
                                    }
                                    if ImagesFound_Return() || ImageFound_next() {
                                        break
                                    }
                                    if x_coord >= 1700 {
                                        x_coord := 500
                                        y_coord := y_coord - 75
                                    }
                                    if y_coord <= 370 {
                                        y_coord := 900
                                    }
                                }
                                if (Unit_Slot_3 >= 5) {
                                    Loop {
                                        if ImagesFound_Return() || ImageFound_next() {
                                            break
                                        }
                                        Send("{3}") 
                                        SendClick(x_coord, y_coord)
                                        Send("{q}") 
                                        Sleep(100)
                                        if ImageFound_unit_placed() {
                                            Upgrade_Maxed()
                                            break
                                        } else {
                                            x_coord := x_coord + 25
                                        }
                                        if ImagesFound_Return() || ImageFound_next() {
                                            break
                                        }
                                        if x_coord >= 1700 {
                                            x_coord := 500
                                            y_coord := y_coord - 75
                                        }
                                        if y_coord <= 370 {
                                            y_coord := 900
                                        }
                                    }
                                    if (Unit_Slot_3 >= 6) {
                                        Loop {
                                            if ImagesFound_Return() || ImageFound_next() {
                                                break
                                            }
                                            Send("{3}") 
                                            SendClick(x_coord, y_coord)
                                            Send("{q}") 
                                            Sleep(100)
                                            if ImageFound_unit_placed() {
                                                Upgrade_Maxed()
                                                break
                                            } else {
                                                x_coord := x_coord + 25
                                            }
                                            if ImagesFound_Return() || ImageFound_next() {
                                                break
                                            }
                                            if x_coord >= 1700 {
                                                x_coord := 500
                                                y_coord := y_coord - 75
                                            }
                                            if y_coord <= 370 {
                                                y_coord := 900
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if (Unit_Slot_4 != 0) {
                if (Unit_Slot_4 >= 1) {
                    Loop {
                        if ImagesFound_Return() || ImageFound_next() {
                            break
                        }
                        Send("{4}") 
                        SendClick(x_coord, y_coord)
                        Send("{q}") 
                        Sleep(100)
                        if ImageFound_unit_placed() {
                            Upgrade_Maxed()
                            break
                        } else {
                            x_coord := x_coord + 25
                        }
                        if ImagesFound_Return() || ImageFound_next() {
                            break
                        }
                        if x_coord >= 1700 {
                            x_coord := 500
                            y_coord := y_coord - 75
                        }
                        if y_coord <= 370 {
                            y_coord := 900
                        }
                    }
                    if (Unit_Slot_4 >= 2) {
                        Loop {
                            if ImagesFound_Return() || ImageFound_next() {
                                break
                            }
                            Send("{4}") 
                            SendClick(x_coord, y_coord)
                            Send("{q}") 
                            Sleep(100)
                            if ImageFound_unit_placed() {
                                Upgrade_Maxed()
                                break
                            } else {
                                x_coord := x_coord + 25
                            }
                            if ImagesFound_Return() || ImageFound_next() {
                                break
                            }
                            if x_coord >= 1700 {
                                x_coord := 500
                                y_coord := y_coord - 75
                            }
                            if y_coord <= 370 {
                                y_coord := 900
                            }
                        }
                        if (Unit_Slot_4 >= 3) {
                            Loop {
                                if ImagesFound_Return() || ImageFound_next() {
                                    break
                                }
                                Send("{4}") 
                                SendClick(x_coord, y_coord)
                                Send("{q}") 
                                Sleep(100)
                                if ImageFound_unit_placed() {
                                    Upgrade_Maxed()
                                    break
                                } else {
                                    x_coord := x_coord + 25
                                }
                                if ImagesFound_Return() || ImageFound_next() {
                                    break
                                }
                                if x_coord >= 1700 {
                                    x_coord := 500
                                    y_coord := y_coord - 75
                                }
                                if y_coord <= 370 {
                                    y_coord := 900
                                }
                            }
                            if (Unit_Slot_4 >= 4) {
                                Loop {
                                    if ImagesFound_Return() || ImageFound_next() {
                                        break
                                    }
                                    Send("{4}") 
                                    SendClick(x_coord, y_coord)
                                    Send("{q}") 
                                    Sleep(100)
                                    if ImageFound_unit_placed() {
                                        Upgrade_Maxed()
                                        break
                                    } else {
                                        x_coord := x_coord + 25
                                    }
                                    if ImagesFound_Return() || ImageFound_next() {
                                        break
                                    }
                                    if x_coord >= 1700 {
                                        x_coord := 500
                                        y_coord := y_coord - 75
                                    }
                                    if y_coord <= 370 {
                                        y_coord := 900
                                    }
                                }
                                if (Unit_Slot_4 >= 5) {
                                    Loop {
                                        if ImagesFound_Return() || ImageFound_next() {
                                            break
                                        }
                                        Send("{4}") 
                                        SendClick(x_coord, y_coord)
                                        Send("{q}") 
                                        Sleep(100)
                                        if ImageFound_unit_placed() {
                                            Upgrade_Maxed()
                                            break
                                        } else {
                                            x_coord := x_coord + 25
                                        }
                                        if ImagesFound_Return() || ImageFound_next() {
                                            break
                                        }
                                        if x_coord >= 1700 {
                                            x_coord := 500
                                            y_coord := y_coord - 75
                                        }
                                        if y_coord <= 370 {
                                            y_coord := 900
                                        }
                                    }
                                    if (Unit_Slot_4 >= 6) {
                                        Loop {
                                            if ImagesFound_Return() || ImageFound_next() {
                                                break
                                            }
                                            Send("{4}") 
                                            SendClick(x_coord, y_coord)
                                            Send("{q}") 
                                            Sleep(100)
                                            if ImageFound_unit_placed() {
                                                Upgrade_Maxed()
                                                break
                                            } else {
                                                x_coord := x_coord + 25
                                            }
                                            if ImagesFound_Return() || ImageFound_next() {
                                                break
                                            }
                                            if x_coord >= 1700 {
                                                x_coord := 500
                                                y_coord := y_coord - 75
                                            }
                                            if y_coord <= 370 {
                                                y_coord := 900
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if (Unit_Slot_5 != 0) {
                if (Unit_Slot_5 >= 1) {
                    Loop {
                        if ImagesFound_Return() || ImageFound_next() {
                            break
                        }
                        Send("{5}") 
                        SendClick(x_coord, y_coord)
                        Send("{q}") 
                        Sleep(100)
                        if ImageFound_unit_placed() {
                            Upgrade_Maxed()
                            break
                        } else {
                            x_coord := x_coord + 25
                        }
                        if ImagesFound_Return() || ImageFound_next() {
                            break
                        }
                        if x_coord >= 1700 {
                            x_coord := 500
                            y_coord := y_coord - 75
                        }
                        if y_coord <= 370 {
                            y_coord := 900
                        }
                    }
                    if (Unit_Slot_5 >= 2) {
                        Loop {
                            if ImagesFound_Return() || ImageFound_next() {
                                break
                            }
                            Send("{5}") 
                            SendClick(x_coord, y_coord)
                            Send("{q}") 
                            Sleep(100)
                            if ImageFound_unit_placed() {
                                Upgrade_Maxed()
                                break
                            } else {
                                x_coord := x_coord + 25
                            }
                            if ImagesFound_Return() || ImageFound_next() {
                                break
                            }
                            if x_coord >= 1700 {
                                x_coord := 500
                                y_coord := y_coord - 75
                            }
                            if y_coord <= 370 {
                                y_coord := 900
                            }
                        }
                        if (Unit_Slot_5 >= 3) {
                            Loop {
                                if ImagesFound_Return() || ImageFound_next() {
                                    break
                                }
                                Send("{5}") 
                                SendClick(x_coord, y_coord)
                                Send("{q}") 
                                Sleep(100)
                                if ImageFound_unit_placed() {
                                    Upgrade_Maxed()
                                    break
                                } else {
                                    x_coord := x_coord + 25
                                }
                                if ImagesFound_Return() || ImageFound_next() {
                                    break
                                }
                                if x_coord >= 1700 {
                                    x_coord := 500
                                    y_coord := y_coord - 75
                                }
                                if y_coord <= 370 {
                                    y_coord := 900
                                }
                            }
                            if (Unit_Slot_5 >= 4) {
                                Loop {
                                    if ImagesFound_Return() || ImageFound_next() {
                                        break
                                    }
                                    Send("{5}") 
                                    SendClick(x_coord, y_coord)
                                    Send("{q}") 
                                    Sleep(100)
                                    if ImageFound_unit_placed() {
                                        Upgrade_Maxed()
                                        break
                                    } else {
                                        x_coord := x_coord + 25
                                    }
                                    if ImagesFound_Return() || ImageFound_next() {
                                        break
                                    }
                                    if x_coord >= 1700 {
                                        x_coord := 500
                                        y_coord := y_coord - 75
                                    }
                                    if y_coord <= 370 {
                                        y_coord := 900
                                    }
                                }
                                if (Unit_Slot_5 >= 5) {
                                    Loop {
                                        if ImagesFound_Return() || ImageFound_next() {
                                            break
                                        }
                                        Send("{5}") 
                                        SendClick(x_coord, y_coord)
                                        Send("{q}") 
                                        Sleep(100)
                                        if ImageFound_unit_placed() {
                                            Upgrade_Maxed()
                                            break
                                        } else {
                                            x_coord := x_coord + 25
                                        }
                                        if ImagesFound_Return() || ImageFound_next() {
                                            break
                                        }
                                        if x_coord >= 1700 {
                                            x_coord := 500
                                            y_coord := y_coord - 75
                                        }
                                        if y_coord <= 370 {
                                            y_coord := 900
                                        }
                                    }
                                    if (Unit_Slot_5 >= 6) {
                                        Loop {
                                            if ImagesFound_Return() || ImageFound_next() {
                                                break
                                            }
                                            Send("{5}") 
                                            SendClick(x_coord, y_coord)
                                            Send("{q}") 
                                            Sleep(100)
                                            if ImageFound_unit_placed() {
                                                Upgrade_Maxed()
                                                break
                                            } else {
                                                x_coord := x_coord + 25
                                            }
                                            if ImagesFound_Return() || ImageFound_next() {
                                                break
                                            }
                                            if x_coord >= 1700 {
                                                x_coord := 500
                                                y_coord := y_coord - 75
                                            }
                                            if y_coord <= 370 {
                                                y_coord := 900
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if (Unit_Slot_6 != 0) {
                if (Unit_Slot_6 >= 1) {
                    Loop {
                        if ImagesFound_Return() || ImageFound_next() {
                            break
                        }
                        Send("{6}") 
                        SendClick(x_coord, y_coord)
                        Send("{q}") 
                        Sleep(100)
                        if ImageFound_unit_placed() {
                            Upgrade_Maxed()
                            break
                        } else {
                            x_coord := x_coord + 25
                        }
                        if ImagesFound_Return() || ImageFound_next() {
                            break
                        }
                        if x_coord >= 1700 {
                            x_coord := 500
                            y_coord := y_coord - 75
                        }
                        if y_coord <= 370 {
                            y_coord := 900
                        }
                    }
                    if (Unit_Slot_6 >= 2) {
                        Loop {
                            if ImagesFound_Return() || ImageFound_next() {
                                break
                            }
                            Send("{6}") 
                            SendClick(x_coord, y_coord)
                            Send("{q}") 
                            Sleep(100)
                            if ImageFound_unit_placed() {
                                Upgrade_Maxed()
                                break
                            } else {
                                x_coord := x_coord + 25
                            }
                            if ImagesFound_Return() || ImageFound_next() {
                                break
                            }
                            if x_coord >= 1700 {
                                x_coord := 500
                                y_coord := y_coord - 75
                            }
                            if y_coord <= 370 {
                                y_coord := 900
                            }
                        }
                        if (Unit_Slot_6 >= 3) {
                            Loop {
                                if ImagesFound_Return() || ImageFound_next() {
                                    break
                                }
                                Send("{6}") 
                                SendClick(x_coord, y_coord)
                                Send("{q}") 
                                Sleep(100)
                                if ImageFound_unit_placed() {
                                    Upgrade_Maxed()
                                    break
                                } else {
                                    x_coord := x_coord + 25
                                }
                                if ImagesFound_Return() || ImageFound_next() {
                                    break
                                }
                                if x_coord >= 1700 {
                                    x_coord := 500
                                    y_coord := y_coord - 75
                                }
                                if y_coord <= 370 {
                                    y_coord := 900
                                }
                            }
                            if (Unit_Slot_6 >= 4) {
                                Loop {
                                    if ImagesFound_Return() || ImageFound_next() {
                                        break
                                    }
                                    Send("{6}") 
                                    SendClick(x_coord, y_coord)
                                    Send("{q}") 
                                    Sleep(100)
                                    if ImageFound_unit_placed() {
                                        Upgrade_Maxed()
                                        break
                                    } else {
                                        x_coord := x_coord + 25
                                    }
                                    if ImagesFound_Return() || ImageFound_next() {
                                        break
                                    }
                                    if x_coord >= 1700 {
                                        x_coord := 500
                                        y_coord := y_coord - 75
                                    }
                                    if y_coord <= 370 {
                                        y_coord := 900
                                    }
                                }
                                if (Unit_Slot_6 >= 5) {
                                    Loop {
                                        if ImagesFound_Return() || ImageFound_next() {
                                            break
                                        }
                                        Send("{6}") 
                                        SendClick(x_coord, y_coord)
                                        Send("{q}") 
                                        Sleep(100)
                                        if ImageFound_unit_placed() {
                                            Upgrade_Maxed()
                                            break
                                        } else {
                                            x_coord := x_coord + 25
                                        }
                                        if ImagesFound_Return() || ImageFound_next() {
                                            break
                                        }
                                        if x_coord >= 1700 {
                                            x_coord := 500
                                            y_coord := y_coord - 75
                                        }
                                        if y_coord <= 370 {
                                            y_coord := 900
                                        }
                                    }
                                    if (Unit_Slot_6 >= 6) {
                                        Loop {
                                            if ImagesFound_Return() || ImageFound_next() {
                                                break
                                            }
                                            Send("{6}") 
                                            SendClick(x_coord, y_coord)
                                            Send("{q}") 
                                            Sleep(100)
                                            if ImageFound_unit_placed() {
                                                Upgrade_Maxed()
                                                break
                                            } else {
                                                x_coord := x_coord + 25
                                            }
                                            if ImagesFound_Return() || ImageFound_next() {
                                                break
                                            }
                                            if x_coord >= 1700 {
                                                x_coord := 500
                                                y_coord := y_coord - 75
                                            }
                                            if y_coord <= 370 {
                                                y_coord := 900
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        if ImagesFound_Return() || ImageFound_next() {
            break
        }
    }
    Loop {
        ImageFound_next_2()
        if (ImagesFound_Return_2()) {
            break 
        }
    }
}

Upgrade_Maxed() {
    Loop {
        Sleep(1000)
        if ImageFound_unit_maxed() {
            break
        }
        if ImageFound_upgrade_num() {
            SendClick(552, 354)
            break
        }
        if ImagesFound_Return() || ImageFound_next() {
            break
        }
        Send("{r}") 
        Sleep(1000)
    }
}

Unknown_Map()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(1000)

    Go_Lobby()
}

Snowy_Town()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{Space down}") ; Hold "Space" key down
    Send("{a down}") ; Hold "a" key down
    Sleep(1000)
    Send("{a up}") ; Hold "a" key up
    Send("{Space up}") ; Hold "Space" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(900)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(1500)
    Send("{a up}") ; Hold "a" key up
    Sleep(200) ; Made by @thuy__ on Discord
 
    Send("{s down}") ; Hold "s" key down
    Sleep(1000)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(1000)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(450)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(3500)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(500)
    Send("{w up}") ; Hold "w" key up

    if (!ImagesFound_Yes_2()) {
        Sleep(5500)
    }

    Place_Upgrade_Units()
}

Sand_Village()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(500)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(1750)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(200)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(900)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(150)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(250)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(2250)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(1000)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(150)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(1500)
    Send("{d up}") ; Hold "d" key up
    Sleep(200) ; Made by @thuy__ on Discord

    if (!ImagesFound_Yes_2()) {
        Sleep(8000)
    }

    Place_Upgrade_Units()
}

Navy_Bay()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(250)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    if (!ImagesFound_Yes_2()) {
        Sleep(16000)
    }

    Place_Upgrade_Units()
}

Fiend_City()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(100)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(3500)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(1000)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    if (!ImagesFound_Yes_2()) {
        Sleep(11500) 
    } ; Made by @thuy__ on Discord

    Place_Upgrade_Units()
}

Spirit_World()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(600)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{a down}") ; Hold "a" key down
    Sleep(3000)
    Send("{s up}") ; Hold "s" key up
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(2500)
    Send("{a up}") ; Hold "a" key up
    Sleep(200) ; Made by @thuy__ on Discord

    Send("{s down}") ; Hold "s" key down
    Sleep(2000)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{d down}") ; Hold "d" key down
    Sleep(2000)
    Send("{s up}") ; Hold "s" key up
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(750)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(250)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    if (!ImagesFound_Yes_2()) {
        Sleep(2000)
    }

    Place_Upgrade_Units()
}

Ant_Kingdom()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200) ; Made by @thuy__ on Discord

    Send("{w down}") ; Hold "w" key down
    Send("{d down}") ; Hold "d" key down
    Sleep(3250)
    Send("{w up}") ; Hold "w" key up
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(2000)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(2200)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(500)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{d down}") ; Hold "d" key down
    Sleep(1500)
    Send("{s up}") ; Hold "s" key up
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(1000)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(2000)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{d down}") ; Hold "d" key down
    Sleep(1000)
    Send("{s up}") ; Hold "s" key up
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(1000)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xA0FF00, 1277, 560, 1442, 573)) {
        SendClick(1714, 20)

        Sleep(200)
        if (!ImagesFound_Yes_2()) {
            Sleep(2000)
        }

        Place_Upgrade_Units()
    } else {
        Go_Lobby()
    }
}

Magic_Town()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(3000)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(1300)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(5000)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    if (!ImagesFound_Yes_2()) { ; Made by @thuy__ on Discord
        Sleep(7500)
    }

    Place_Upgrade_Units()
}

Haunted_Academy()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn() 
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xB3FA3A, 1326, 591, 1515, 615)) {
        SendClick(1714, 20)

        Send("{a down}") ; Hold "a" key down
        Sleep(4000)
        Send("{a up}") ; Hold "a" key up
        Sleep(200)
    
        if (!ImagesFound_Yes_2()) {
            Sleep(13500)
        }

        Place_Upgrade_Units()
    } else {
        Go_Lobby()
    }
}

Magic_Hills()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn() ; Made by @thuy__ on Discord
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(500)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(2000)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{d down}") ; Hold "d" key down
    Sleep(1000)
    Send("{s up}") ; Hold "s" key up
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(1000)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(250)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(3000)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(1500)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xB6FF00, 1036, 541, 1116, 570)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{d down}") ; Hold "d" key down
        Sleep(2750)
        Send("{d up}") ; Hold "d" key up
        Sleep(200) ; Made by @thuy__ on Discord

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(1000)
        Send("{s up}") ; Hold "s" key up
        Send("{d up}") ; Hold "d" key up
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Sleep(1250)
        Send("{s up}") ; Hold "s" key up
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(1400)
        Send("{s up}") ; Hold "s" key up
        Send("{d up}") ; Hold "d" key up
        Sleep(200)

        Sleep(200)
        Send("{d down}") ; Hold "d" key down
        Sleep(750)
        Send("{d up}") ; Hold "d" key up
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(2300)
        Send("{s up}") ; Hold "s" key up
        Send("{d up}") ; Hold "d" key up
        Sleep(200)

        Sleep(200)
        Send("{d down}") ; Hold "d" key down
        Sleep(2250)
        Send("{d up}") ; Hold "d" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(1000)
        Send("{w up}") ; Hold "w" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(3000)
        Send("{w up}") ; Hold "w" key up
        Send("{d up}") ; Hold "d" key up 
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(50)
        }

        Place_Upgrade_Units()
    } else {
        Go_Lobby()
    }
}

Space_Center()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(2250)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Sleep(200)
    Send("{d down}") ; Hold "d" key down
    Sleep(1500)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xDCFF00, 1506, 991, 1532, 1070)) {
        SendClick(1714, 20)

        if (!ImagesFound_Yes_2()) {
            Sleep(12500)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby()
    }
}

Alien_Spaceship() 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x62FF0C, 415, 850, 494, 772)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{d down}") ; Hold "d" key down
        Sleep(500)
        Send("{d up}") ; Hold "d" key up
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(3000)
        Send("{s up}") ; Hold "s" key up
        Send("{d up}") ; Hold "d" key up 
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(12000) ; Made by @thuy__ on Discord
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby()
    }
}

Fabled_Kingdom()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(100)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Send("{d down}") ; Hold "d" key down
    Sleep(900)
    Send("{w up}") ; Hold "w" key up
    Send("{d up}") ; Hold "d" key up 
    Sleep(200)

    SendClick(1714, 20) ; Made by @thuy__ on Discord

    if (SearchPixelColor(0x8FFF00, 1033, 510, 1148, 529)) {
        SendClick(1714, 20) 

        Sleep(200)
        Send("{d down}") ; Hold "d" key down
        Sleep(1250)
        Send("{d up}") ; Hold "d" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(800)
        Send("{w up}") ; Hold "w" key up
        Sleep(200)

        Send("{a down}") ; Hold "a" key down
        Sleep(300)
        Send("{a up}") ; Hold "a" key up
        Sleep(200)

        Send("{Space down}") ; Hold "Space" key down
        Send("{w down}") ; Hold "w" key down
        Sleep(500)
        Send("{w up}") ; Hold "w" key up
        Send("{Space up}") ; Hold "Space" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(2000)
        Send("{w up}") ; Hold "w" key up
        Sleep(200)

        Send("{a down}") ; Hold "a" key down
        Sleep(500)
        Send("{a up}") ; Hold "a" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(8500)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby()
    }
}

Ruined_City()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6 ; Made by @thuy__ on Discord
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Send("{s down}") ; Hold "s" key down
    Sleep(900)
    Send("{a up}") ; Hold "a" key up
    Send("{s up}") ; Hold "s" key up 
    Sleep(200)
    
    Send("{s down}") ; Hold "s" key down
    Sleep(400)
    Send("{s up}") ; Hold "s" key up 
    Sleep(200)
    
    Send("{a down}") ; Hold "a" key down
    Sleep(3250)
    Send("{a up}") ; Hold "a" key up 
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x89FF00, 1110, 563, 1185, 579)) {
        SendClick(1714, 20)

        Sleep(200)

        if (!ImagesFound_Yes_2()) { ; Made by @thuy__ on Discord
            Sleep(12500)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby()
    }
}

Puppet_Island()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(2000)
    Send("{s up}") ; Hold "s" key up 
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{d down}") ; Hold "d" key down
    Sleep(1250)
    Send("{s up}") ; Hold "s" key up
    Send("{d up}") ; Hold "d" key up 
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xA4FF00, 1375, 554, 1482, 596)) {
        SendClick(1714, 20) ; Made by @thuy__ on Discord

        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(11500)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby()
    }
}

Virtual_Dungeon()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(2500)
    Send("{s up}") ; Hold "s" key up 
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x82FE03, 620, 556, 710, 533)) {
        SendClick(1714, 20)

        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(13000)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby()
    }
}

Snowy_Kingdom()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{a down}") ; Hold "a" key down
    Sleep(750)
    Send("{s up}") ; Release "s" key up
    Send("{a up}") ; Release "a" key up 
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(1650)
    Send("{s up}") ; Release "s" key up 
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{a down}") ; Hold "a" key down
    Sleep(4000)
    Send("{s up}") ; Release "s" key up
    Send("{a up}") ; Release "a" key up 
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x86FF83, 437, 699, 637, 717)) {
        SendClick(1714, 20)

        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(9000)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby() 
    }
}

Dungeon_Throne()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xA5FB24, 733, 699, 754, 555)) {
        SendClick(1714, 20)

        Sleep(200)

        Send("{a down}") ; Hold "a" key down
        Send("{s down}") ; Hold "s" key down
        Sleep(1500)
        Send("{a up}") ; Release "a" key up
        Send("{s up}") ; Release "s" key up 
        Sleep(200) ; Made by @thuy__ on Discord

        Send("{a down}") ; Hold "a" key down
        Sleep(3500)
        Send("{a up}") ; Release "a" key up 
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(2750)
        Send("{w up}") ; Release "w" key up 
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(3500)
        Send("{w up}") ; Release "w" key up
        Send("{d up}") ; Release "d" key up 
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(2000)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(6500)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby() 
    }
}

Mountain_Temple()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(1500)
    Send("{w up}") ; Release "w" key up 
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(750)
    Send("{d up}") ; Release "d" key up
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xC1FF2F, 1118, 671, 1226, 664)) {
        SendClick(1714, 20)

        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(14000)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby() 
    }
}

Rain_Village()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x95FF00, 548, 666, 870, 683)) {
        SendClick(1714, 20)

        Send("{d down}") ; Hold "d" key down
        Sleep(2000)
        Send("{d up}") ; Release "d" key up 
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(500)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(13500)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby() 
    }
}

Storm_Hideout()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x98F901 || 0xEDF800, 1784, 799, 1911, 834)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{s down}") ; Hold "s" key down
        Sleep(1900)
        Send("{s up}") ; Release "s" key up 
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(500)
        Send("{s up}") ; Release "s" key up
        Send("{d up}") ; Release "d" key up 
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(100)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(200)
        Send("{s up}") ; Release "s" key up
        Send("{d up}") ; Release "d" key up 
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(400)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(700)
        Send("{s up}") ; Release "s" key up
        Send("{d up}") ; Release "d" key up 
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Sleep(900)
        Send("{s up}") ; Release "s" key up 
        Sleep(200) ; Made by @thuy__ on Discord

        Send("{a down}") ; Hold "a" key down
        Sleep(1000)
        Send("{a up}") ; Release "a" key up 
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{a down}") ; Hold "a" key down
        Sleep(1500)
        Send("{s up}") ; Release "s" key up
        Send("{a up}") ; Release "a" key up 
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(7000)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby() 
    }
}

Haunted_Mansion()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x73E60B, 1382, 730, 1507, 658)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{s down}") ; Hold "s" key down
        Sleep(500)
        Send("{s up}") ; Release "s" key up
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(1750)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(2500)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        Send("{a down}") ; Hold "a" key down
        Sleep(1000)
        Send("{a up}") ; Release "a" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(500)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(9000)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby() 
    }
}

Nightmare_Train()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x2CFF0E, 1734, 653, 1915, 647)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{d down}") ; Hold "d" key down
        Sleep(5500)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(2500)
        Send("{s up}") ; Release "s" key up
        Send("{d up}") ; Release "d" key up 
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(2000)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(2000)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(3500)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby() 
    }
}

Future_City()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(3000)
    Send("{s up}") ; Release "s" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(350)
    Send("{a up}") ; Release "a" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(1500)
    Send("{s up}") ; Release "s" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(700)
    Send("{a up}") ; Release "a" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(1900)
    Send("{s up}") ; Release "s" key up
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xFFFF00, 918, 721, 1092, 767)) {
        SendClick(1714, 20)

        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(9000)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby() 
    }
}

Walled_City()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xC2F600, 208, 676, 252, 768)) {
        SendClick(1714, 20)

        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(17000)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby() 
    }
}

Cursed_Festival()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(1800)
    Send("{d up}") ; Release "d" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(1500)
    Send("{s up}") ; Release "s" key up
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xCAFF2C, 25, 785, 388, 802)) {
        SendClick(1714, 20)

        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(12500)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby() 
    }
}

Spirit_Town()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x95FF00, 1211, 642, 1611, 661)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{w down}") ; Hold "w" key down
        Sleep(3000)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(2500)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(10500)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby() 
    }
}

Hellish_City()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x89FF00, 1381, 345, 1500, 195)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{w down}") ; Hold "w" key down
        Sleep(1000)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(2500)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(1200)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(600)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(10500)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby() 
    }
}

Strange_Town()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xE9FF7A, 785, 658, 806, 501)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{a down}") ; Hold "a" key down
        Sleep(750)
        Send("{a up}") ; Release "a" key up
        Sleep(200)
        
        Send("{w down}") ; Hold "w" key down
        Sleep(750)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(14500)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby() 
    }
}

Planet_Greenie()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x96FF42, 1484, 814, 1515, 1060)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{s down}") ; Hold "s" key down
        Sleep(750)
        Send("{s up}") ; Release "s" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(15500)
        } 

        Place_Upgrade_Units()
    } else {
        Go_Lobby() 
    }
}

; Hotkey to trigger the pixel color check and clicking loop
^F4:: ; Ctrl+F4 to start the pixel scan and clicking loop
{
    Unit_GUI_Save() 

    Loop {

        Loop {
            ImageFound_contracts()
            
            if (ImageFound_contracts_x()) {
                break 
            }
        }

        Loop {
            Loop {
                SendClick(1278, 737)

                if (ImageFound_cancel()) {
                    break 
                }
            }

            ; Define the coordinates of the two points (top-left and bottom-right)
            x1 := 645  ; Top-left X coordinate
            y1 := 465  ; Top-left Y coordinate
            x2 := 1274  ; Bottom-right X coordinate
            y2 := 557  ; Bottom-right Y coordinate

            ; Calculate width and height of the region
            w := x2 - x1
            h := y2 - y1

            ; Use OCR to extract text from the defined region
            ocrResult := OCR.FromRect(x1, y1, w, h)

            ; Get the recognized text
            recognizedText := ocrResult.Text

            Loop 3 {
                SendClick(960, 607)
            }

            ; Type out the recognized text
            SendText(recognizedText)

            Loop 3 {
                SendClick(781, 697)
            }
            if !SearchPixelColor(0xFF494C, 402, 808, 928, 838) {
                break
            }
        }

        Find_Maps()
    }
}
        
; Stop button to close the script
^F3:: ; Ctrl+F3 to stop the script
{
    Unit_GUI_Save()
    ExitApp
}