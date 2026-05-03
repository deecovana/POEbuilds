;; ver 26.04.02
;; for AHK 1.1.34.04
;; (CC4 2026) cheva 2012-2026

#SingleInstance Force

;-=-\ Set globals \-=-
global SMin = 200
global SMax = 600
global MMin = 2
global MMax = 6
global Zoom = false
MouseSpeed = % ran(MMin, MMax)
SetDefaultMouseSpeed, MouseSpeed
SetKeyDelay, 20, 10

;-=-\ Functions \-=-
ran(min, max)
{
	random, ran, min, max
	return ran                                                                                                                                                      
}

;-=-\ Init \-=-
SoundPlay, %A_WinDir%\Media\Windows Foreground.wav

; reload
$^+R::Reload

; suspend/resume
$^+S::
; CAREFULL !!! Mapped to Alt+S !!!
$!s::
; pause/resume
$^+P::
;use both to sleep/pause
  ;thanks to Rohwedder
  ;https://www.autohotkey.com/boards/viewtopic.php?t=50594
  Suspend ;Suspend Hotkeys
  Pause,,1 ;Pause Script
  If !(Reload := !Reload)
    Reload ;Reload Script
Return

; exit
$^+W::
  SoundPlay, %A_WinDir%\Media\Windows Notify System Generic.wav
  Sleep, 1000
  ExitApp
Return

; Release all physical fixed keys and Reload script
; Use Alt/Shift + Backspace
$+BackSpace::
$!BackSpace::
	Send, {LShift Up}
	Send, {LAlt Up}
	Send, {LControl Up}
	Send, {LButton Up}
	Send, {RButton Up}
	Send, {MButton Up}
	Loop, 0xFF {
		IF GetKeyState(Key:=Format("VK{:X}",A_Index))
			SendInput, {%Key% up}
	}
	Reload
return
  
; Emergency process kill
;$^F1::
;	SoundPlay, %A_WinDir%\Media\Windows Pop-up Blocked.wav
;	Process,Close,svchost.exe
;return
     
;-----Let's play POE1!-----
#IfWinActive, Path of Exile 
;;=======================================================================

; Jump to Hideout on F5
$F5::
  Send, {Enter}
  Send, /hideout
  Send, {Enter}
return

; Reset XP counter
$^/::
  Send, {Enter}
  Send, /reset_xp
  Send, {Enter}
return

; List passives in chat window
$^p::
  Send, {Enter}
  Send, /passives
  Send, {Enter}

; Jump!!!
; Map Q ability to jump/move/slide 
; Control + Right click: Send Q
; Using: Holding LMB, press Control than RMB
$^RButton::
  Send, {Q}
  SoundPlay, %A_WinDir%\Media\Windows Default.wav
return

; Flasks macro mapped to key 2
$2::
  Send, 1
  Send, 2
  Send, 3
  Send, 4
; Send, 5
  SoundPlay, %A_WinDir%\Media\Windows Default.wav
return

; run +control clicker loop
$^Backspace::
  BreakLoop := 0
  Loop, 1000 {
    Send ^{Click} 
    Sleep, 100 
    ; hold Backspace to break loop
    if (BreakLoop == 1 or GetKeyState("Backspace", "P")) {
      BreakLoop := 0
      break
    }
    SoundPlay, %A_WinDir%\Media\Windows Default.wav 
  }
return

; run +control+shift clicker loop
$+^Backspace::
  SoundPlay, %A_WinDir%\Media\Windows Background.wav
  BreakLoop := 0
  Loop, 1000 { 
    Send +^{Click} 
    Sleep, 100 
    ; hold Backspace to break loop
    if (BreakLoop == 1 or GetKeyState("Backspace", "P")) {
      BreakLoop := 0
      break
    }
    SoundPlay, %A_WinDir%\Media\Windows Default.wav 
  }
return
