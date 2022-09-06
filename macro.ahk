#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

#Include settings.ahk

global onpreview := 0
global lastReset := 0

SetKeyDelay, 0
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
      if (InStr(A_LoopReadLine, "Resetting")) {
        preview := True
        previewStarted := A_NowUTC
        break
      }
    }
  }
  if (preview)
    break
}

if (wideResets) {
	  newHeight := Floor(A_ScreenHeight / wideResets)
      WinRestore, Minecraft
      WinMove, Minecraft,,0,0,%A_ScreenWidth%,%newHeight%
}
sleep, 200 
if (f3Mode) {
Setup()
{  
   numLines := 0
   found := False
   
   Loop, Read, %logFile%
   {
      numLines += 1
   }
   Loop, Read, %logFile%
   {
      if ((numLines - A_Index) < 1)
      {
         if (InStr(A_LoopReadLine, key)){
            found := True
         }
      }
   }

   return found
}
ControlSend,, {Blind}{F3 down}{Esc}{F3 up}, Minecraft
}
if (ninjareset) {
send, {%ninjabrain%}
}
Loop {
WinGetTitle, title, Minecraft
if (InStr(title, "-"))
{
if (wideResets) {
WinMaximize, Minecraft
}
if coop {
ControlSend,, {Blind}{Esc}{Tab 7}{Enter}{Tab 4}{Enter}{Tab}{Enter}, Minecraft
}
Reload
}
else {
continue
}
}

