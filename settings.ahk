#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Macro setting
global logFile := "D:\MultiMC\instances\mc1\.minecraft\logs" ; Your logs folder in .minecraft
global fullscreen := False ; set to True 
global wideResets := 2.5 ; how wide your instance go, set to 0 to disable wide reset
global coop := False ; coop mode
global ninjareset := False ; toggle reset calculator
global ninjabrain := "Numpad1" ; Ninjabrain resetKey
global f3Mode := True ; F3 + Esc on reset
global wideObsPreview := False ; Using obs Fullscreen Projector to Preview the seed
