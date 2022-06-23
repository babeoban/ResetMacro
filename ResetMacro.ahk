; By canhvjp
; Version v1.1
global fullscreen := False	
global worldPreviewResetKey := "g" ; [Keep this in lower case] world preview reset key (default: h)
global pauseOnSwitch := False
global coop := False
; Change setting to 0 will not reset!
global renderDistance := 16
global entityDistance := 500
global FOV := 95 ; For quake pro put 110
global mouseSensitivity := 130
SetKeyDelay, 0


ExitWorld()
{
 send {Esc}+{Tab}{Enter}
}

ResetPreview()
{
 ControlSend, ahk_parent, {%worldPreviewResetKey%}, ahk_exe javaw.exe
}

ChangeToSence()
{
 if WinExist("Fullscreen Projector (Preview)")
    WinActivate 
}

Return()
{
 Loop
  {
   Sleep 70
   If WinExist("Minecraft* 1.16.1 - Singleplayer")
    {
     Sleep 70
     WinActivate
     break
     }
   Else
     continue
  }
}

Chunk()
{
if (renderDistance)
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
 Chunk()
 Sleep 500
 ExitWorld()
 Sleep 10
 ChangeToSence()
 Loop
 {
   Sleep 70
   If WinExist("Minecraft* 1.16.1 - Singleplayer")
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
 Return()
 if (fullscreen) 
 {
 ControlSend,, {Blind}{F11}, ahk_exe javaw.exe
 }
 Click, Right
}

U:: 
{
 Reset()
}

G::
{
 ResetPreview()
}

