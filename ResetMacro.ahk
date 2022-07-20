; By canhvjp
; Version v1.5
#NoEnv

; Macro setting
global logFile := "D:\MultiMC\instances\-NewAtum\.minecraft\logs"
global fullscreen := False 
global wideResets := True 
global widthMultiplier := 2.5 
global coop := False 
global sence := "Numpad1"
global wideSence := "Numpad2"

; Minecraft Setting
global renderDistance := 16
global entityDistance := 500
global FOV := 95 ; For quake pro put 110
global mouseSensitivity := 130

; Delays
global wait := 0 ; increase if not reset
global maxLoops := 50 
global beforeFreezeDelay := 500 
global beforePauseDelay := 100
SetKeyDelay, 0

; Code below! Do not config
global atumResetKey := ""

GetAtumKey()
{
    optionsFile := StrReplace(logFile, "logs", "options.txt")
    FileReadLine, atumKey, %optionsFile%, 98
    return StrReplace(atumKey, "key_Create New World:key.keyboard.", "")
}

atumResetKey := GetAtumKey()

logFile := RegExReplace(logFile, "logs(\/|\\)*", "logs")
global optionsFile := ""
    
IfNotExist, %logFile% 
{
    MsgBox, You have not set your Minecraft instance folder!
    ExitApp
}
WinMinimize, Ninjabrain
if (wideResets) {
      newHeight := Floor(A_ScreenHeight / widthMultiplier)
      WinRestore, Minecraft
      WinMove, Minecraft,,0,0,%A_ScreenWidth%,%newHeight%
    }
WinSet, AlwaysOnTop, On, Minecraft
WinSet, AlwaysOnTop, Off, Minecraft

LeavePreview() 
{
ControlSend,, {Blind}{F6}, Minecraft

while (True) {
  numLines := 0
  Loop, Read, %logFile%\latest.log
  {
    numLines += 1
  }
  preview := False
  Loop, Read, %logFile%\latest.log
  {
    if ((numLines - A_Index) < 1)
    {
      if (InStr(A_LoopReadLine, "Starting Preview")) {
        preview := True
        previewStarted := A_NowUTC
        break
      }
    }
  }
  if (preview)
    break
}

ControlSend,, {Blind}{F3 down}{Esc}{F3 up}, Minecraft
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
if (renderDistance)
  {
      RDPresses := renderDistance-2
    ControlSend,, {Blind}{Shift down}{F3 down}{F 32}{Shift up}{F %RDPresses%}{D}{F3 up}, Minecraft
  }
if (FOV)
  {
    ; Tab to FOV reset then preset FOV to custom value with arrow keys
    FOVPresses := ceil((110-FOV)*1.7875)
    ControlSend,, {Blind}{Esc}{Tab 6}{enter}{Tab}{Right 150}{Left %FOVPresses%}{Esc}, Minecraft
  }
  if (mouseSensitivity)
  {
    SensPresses := ceil(mouseSensitivity/1.408)
    ; Tab to mouse sensitivity reset then preset mouse sensitivity to custom value with arrow keys
    ControlSend,, {Blind}{Esc}{Tab 6}{enter}{Tab 7}{enter}{tab}{enter}{tab}{Left 150}{Right %SensPresses%}{Esc 3}, Minecraft
  }
  if (entityDistance)
  {
    entityPresses := (5 - (entityDistance*.01)) * 143 / 4.5
    ; Tab to video settings to reset entity distance
    ControlSend,, {Blind}{Esc}{Tab 6}{enter}{Tab 6}{enter}{Tab 17}{Right 150}{Left %entityPresses%}{Esc 2}, Minecraft
  }
  ControlSend,, {Blind}{Shift}, ahk_pid %pid%
}
NinjaHide()
{
WinMinimize, Ninjabrain
}

Reset()
{
 if (fullscreen) 
 {
 ControlSend,, {Blind}{F11}, Minecraft
 }
 NinjaHide()
 Sleep %wait%
 ChangeToSence()
 send, {%wideSence%}
 if (wideResets) {
      newHeight := Floor(A_ScreenHeight / widthMultiplier)
      WinRestore, Minecraft
      WinMove, Minecraft,,0,0,%A_ScreenWidth%,%newHeight%
    }
 LeavePreview()
 Loop
 {
   Sleep 70
   WinGetTitle, title, Minecraft
   if (InStr(title, "-"))
    {
	 if (coop)
	 {
	 ControlSend,, {Blind}{Esc}{Tab 7}{Enter}{Tab 4}{Enter}{Tab}{Enter}, Minecraft
	 }
 	if (pauseOnSwitch)
	 {
 	ControlSend,, {Esc}, Minecraft
	 }
     break
     }
   Else
     continue
 }
 ResetSetting()
 send, {%sence%}
 if (wideResets) {
      WinMaximize, Minecraft
 }
 if (fullscreen) 
 {
 ControlSend,, {Blind}{F11}, Minecraft
 }
 Return()
 Click, Right
}

;Hotkey below

#IfWinActive, Minecraft

U:: Reset()

#IfWinActive, Fullscreen Projector

U:: LeavePreview()


