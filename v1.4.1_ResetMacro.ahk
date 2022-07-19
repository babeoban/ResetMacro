; By canhvjp
; Version v1.4
#NoEnv

; Macro setting
global minecraftFolder := "D:\MultiMC\instances\mc1\.minecraft"
global fullscreen := False 
global wideResets := True 
global widthMultiplier := 2.5 
global coop := False 

; Minecraft Setting
global lowDistance := 0
global renderDistance := 16
global entityDistance := 500
global FOV := 95 ; For quake pro put 110
global mouseSensitivity := 130
global worldPreviewResetKey := "h" ; [KEEP THIS LOWER CASE] world preview reset key (default: h) 

; Delays
global maxLoops := 50 
global beforeFreezeDelay := 500 
global beforePauseDelay := 500 
SetKeyDelay, 0

; Code below! Do not config

IfWinNotExist, Minecraft
{
	MsgBox, Your minecraft have not launched, please launch minecraft and start script again!
	ExitApp
}

IfNotExist, %minecraftFolder% 
{
    MsgBox, You have not set your Minecraft instance folder!
    ExitApp
}

if (wideResets) {
      newHeight := Floor(A_ScreenHeight / widthMultiplier)
      WinRestore, ahk_exe javaw.exe
      WinMove, ahk_exe javaw.exe,,0,0,%A_ScreenWidth%,%newHeight%
    }
WinSet, AlwaysOnTop, On, ahk_exe javaw.exe
WinSet, AlwaysOnTop, Off, ahk_exe javaw.exe
Loop {
WinGetTitle, title, ahk_exe javaw.exe
   if (InStr(title, "-"))
		{
		sleep 70
		if (wideResets) {
			  WinMaximize, ahk_exe javaw.exe
		 }
		 if (fullscreen) 
		 {
		 ControlSend,, {Blind}{F11}, ahk_exe javaw.exe
		 }
		break
		WinActivate, Minecraft
		Click, Right
		}
   else 
	   {
	   sleep 70
	   continue
	   }
}

LeavePreview() {
WinGetTitle, title, ahk_exe javaw.exe
if (InStr(title, "-"))
  ControlSend,, {Blind}{Shift down}{Esc}{Tab}{Shift up}{Enter}{%worldPreviewResetKey%}, ahk_exe javaw.exe
else
  ControlSend,, {Blind}{%worldPreviewResetKey%}, ahk_exe javaw.exe

while (True) {
  numLines := 0
  Loop, Read, %minecraftFolder%\logs\latest.log
  {
    numLines += 1
  }
  preview := False
  Loop, Read, %minecraftFolder%\logs\latest.log
  {
    if ((numLines - A_Index) < 1)
    {
      if (InStr(A_LoopReadLine, "Starting Preview")) {
        preview := True
        previewStarted := A_NowUTC
        break
      }
    }
    if (A_NowUTC - started > 2 && (numLines - A_Index) < 5)
    {
      FileAppend, %A_LoopReadLine%`n, log.log
      if (InStr(A_LoopReadLine, "Starting Preview")) {
        preview := True
        previewStarted := A_NowUTC
        break
      }
      else if (InStr(A_LoopReadLine, "Loaded 0") || (InStr(A_LoopReadLine, "Saving chunks for level 'ServerLevel") && InStr(A_LoopReadLine, "minecraft:the_end"))) {
        ControlSend,, {Blind}{Esc}{Shift down}{Tab}{Shift up}{Enter}{%worldPreviewResetKey%}, ahk_exe javaw.exe
        break
      }
    }
  }
  if (preview)
    break
}
ControlSend,, {Blind}{F3 down}{Esc}{F3 up}, ahk_exe javaw.exe
}

ChangeToSence()
{
	WinMaximize, Fullscreen Projector
    WinActivate, Fullscreen Projector
}

Return()
{
     WinActivate, Minecraft
	 WinMinimize, Fullscreen Projector
}

ResetSetting()
{
if (lowDistance)
  {
      RDPresses := lowDistance-2
    ControlSend,, {Blind}{Shift down}{F3 down}{F 32}{Shift up}{F %RDPresses%}{D}{F3 up}, ahk_exe javaw.exe
  }
else if (renderDistance)
  {
      RDPresses := renderDistance-2
    ControlSend,, {Blind}{Shift down}{F3 down}{F 32}{Shift up}{F %RDPresses%}{D}{F3 up}, ahk_exe javaw.exe
  }
if (FOV)
  {
    ; Tab to FOV reset then preset FOV to custom value with arrow keys
    FOVPresses := ceil((110-FOV)*1.7875)
    ControlSend,, {Blind}{Esc}{Tab 6}{enter}{Tab}{Right 150}{Left %FOVPresses%}{Esc}, ahk_exe javaw.exe
  }
  if (mouseSensitivity)
  {
    SensPresses := ceil(mouseSensitivity/1.408)
    ; Tab to mouse sensitivity reset then preset mouse sensitivity to custom value with arrow keys
    ControlSend,, {Blind}{Esc}{Tab 6}{enter}{Tab 7}{enter}{tab}{enter}{tab}{Left 150}{Right %SensPresses%}{Esc 3}, ahk_exe javaw.exe
  }
  if (entityDistance)
  {
    entityPresses := (5 - (entityDistance*.01)) * 143 / 4.5
    ; Tab to video settings to reset entity distance
    ControlSend,, {Blind}{Esc}{Tab 6}{enter}{Tab 6}{enter}{Tab 17}{Right 150}{Left %entityPresses%}{Esc 2}, ahk_exe javaw.exe
  }
  ControlSend,, {Blind}{Shift}, ahk_pid %pid%
}

Reset()
{
 if (fullscreen) 
 {
 ControlSend,, {Blind}{F11}, ahk_exe javaw.exe
 }
 Sleep 50
 ResetSetting()
 Sleep 500
 ChangeToSence()
 if (wideResets) {
      newHeight := Floor(A_ScreenHeight / widthMultiplier)
      WinRestore, ahk_exe javaw.exe
      WinMove, ahk_exe javaw.exe,,0,0,%A_ScreenWidth%,%newHeight%
    }
 LeavePreview()
 Loop
 {
   Sleep 70
   WinGetTitle, title, ahk_exe javaw.exe
   if (InStr(title, "-"))
    {
	 if (coop)
	 {
	 ControlSend,, {Blind}{Esc}{Tab 7}{Enter}{Tab 4}{Enter}{Tab}{Enter}, ahk_exe javaw.exe
	 }
 	if (pauseOnSwitch)
	 {
 	ControlSend,, {Esc}, ahk_exe javaw.exe
	 }
     break
     }
   Else
     continue
 }
 if (lowDistance && renderDistance)
 {
      RDPresses := renderDistance-2
    ControlSend,, {Blind}{Shift down}{F3 down}{F 32}{Shift up}{F %RDPresses%}{D}{F3 up}, ahk_exe javaw.exe
 }
 if (wideResets) {
      WinMaximize, ahk_exe javaw.exe
 }
 if (fullscreen) 
 {
 ControlSend,, {Blind}{F11}, ahk_exe javaw.exe
 }
 Return()
 Click, Right
}

#IfWinActive, Minecraft
U:: Reset()
#IfWinActive, Fullscreen Projector
U:: LeavePreview()

