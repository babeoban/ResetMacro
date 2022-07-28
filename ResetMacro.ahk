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
global atumResetKey := "F6" ; [KEEP THIS LOWER CASE] world preview reset key (default: F6) 

; Delays
global wait := 500
global maxLoops := 50 
global beforeFreezeDelay := 500 
global beforePauseDelay := 500 
SetKeyDelay, 0

; Code below! Do not config

logFile := RegExReplace(logFile, "logs(\/|\\)*", "logs")

IfNotExist, %logFile% 
{
    MsgBox, You have not set your Minecraft instance folder!
    ExitApp
}

IfWinNotExist, Fullscreen Projector 
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
ResetPreview()
{
ControlSend,, {Blind}{%atumResetKey%}, Minecraft
LeavePreview()
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

NinjaHide()
{
WinMinimize, Ninjabrain
}

Reset()
{
 ControlSend,, {Blind}{%atumResetKey%}, Minecraft
 if (fullscreen) 
 {
 ControlSend,, {Blind}{F11}, Minecraft
 }
 NinjaHide()
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
 send, {%sence%}
 if (wideResets) {
      WinMaximize, Minecraft
 }
 if (fullscreen) 
 {
 ControlSend,, {Blind}{F11}, Minecraft
 }
 Return()
 ControlSend,, {Blind}{Esc 2}, Minecraft
}

;Hotkey below
#IfWinActive, Minecraft
U:: Reset()
#IfWinActive, Fullscreen Projector
U:: ResetPreview()


