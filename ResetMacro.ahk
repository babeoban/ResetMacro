; By canhvjp
global worldPreviewResetKey := "g" ; [KEEP THIS LOWER CASE] world preview reset key (default: h)
global renderDistance := 16
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
}

Reset()
{
 Chunk()
 Sleep 500
 ExitWorld()
 ChangeToSence()
 Return()
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

