#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

NumpadDiv::		;	This is for "Fit to Screen" / "Quick Save"
if (toggleLayout){
	Send, {LCtrl down}{s}{LCtrl up}
}
else{
	Send, {LCtrl down}{0}{LCtrl up}
}
return

NumpadMult::	;	This is for "Reset Rotation" / "Screenshot Clipping"
if (toggleLayout){
	Send, {LWin down}{LShift down}
	Send, {s}
	Send, {LWin up}{LShift up}
}
else {
	Send, {z}
}
return

Numpad7::		;	This is for "Magnify"
KeyWait, Numpad7, T0.145

;If it is pressed briefly, it will change to zoom tool
if(!ErrorLevel){
	Send, {/}
	return
}

;if hold long enough, it will be zoom tool until released
Send, {LAlt down}{Space down}
KeyWait, Numpad7
Send, {LAlt up}{Space up}
return

Numpad8::		;	This is for "Grab"
KeyWait, Numpad8, T0.145

;If it is pressed briefly, it will change to grab tool
if(!ErrorLevel){
	Send, {h}
	return
}

;if hold long enough, it will be grab until released
Send, {Space down}
KeyWait, Numpad8
Send, {Space up}
return

*Numpad9::		;	This is for "Rotate"
KeyWait, Numpad9, T0.145

;if it is pressed briefly, it will change to rotate tool
if(!ErrorLevel){
	Send, {r}
	return
}

;if hold long enough, it will be rotate until released
;If you see this code, you can change the LCtrl to LShift if you want to use the default
Send, {LCtrl down}{Space down}
KeyWait, Numpad9
Send, {LCtrl up}{Space up}
return

NumpadSub::		;	This is for "Flip Horizontal" / "Flip Vertical"

if(toggleLayout){
	Send, {v}
}
else {
	Send, {f}
}
return

Numpad4:: 		; This is for Pen / Marker
KeyWait, Numpad4, T0.145

;If it is pressed briefly, it will change to Pen tool
if(!ErrorLevel){
	Send, {;}
	return
}

;if hold long enough, it will change its size relative to your hold click
changeSize()
return

Numpad5::		; This is for Brush
KeyWait, Numpad5, T0.145

;if it is pressed briefly, it will change to brush tool
if(!ErrorLevel){
	Send, {b}
	return
}

;if hold long enough, it will change its size relative to your hold click
changeSize()
return

Numpad6::		; This is for Movement Tool / Select Layer
KeyWait, Numpad6, T0.145

if(!ErrorLevel){
	Send, {k}
	return
}

Send, {LCtrl down}
KeyWait, Numpad6
Send, {LCtrl up}
return

NumpadAdd::		; This is for Lasso Tool
Send, {m}
return

~Numpad1::		; This is for Colourpicker with a hold function
KeyWait, Numpad1, T0.145

;if it is pressed briefly, it will turn into colourpicker tool
if (!ErrorLevel){
	Send, {i}
	return
}

;if it is held, it will be colourpicker until it is released
	Send, {LAlt down}
    KeyWait, Numpad1
	Send, {LAlt up}
    return

return

Numpad2::		; This is for Pencil
KeyWait, Numpad2, T0.145

;if it is pressed briefly, it will turn into pencil
if(!ErrorLevel){
	Send, {p}
	return
}

;if hold long enough, it will change its size relative to your hold click
changeSize()
return

Numpad3::		; This is for Eraser / Fill (Only)
KeyWait, Numpad3, T0.145

if(!ErrorLevel){
	;if Enter is pressed, this is for fill
	if (toggleLayout){
		Send, {g}{g}
	}
	;if its raw, then it is eraser
	else{
		Send, {e}
	}
	return
}

;Once hold long enough, holding click will change its size
changeSize()

return

~*NumpadEnter::	; This is for Transformation tool and Layout change function
Send, {}
toggleLayout := true
startTime := A_TickCount
KeyWait, NumpadEnter
return

~*NumpadEnter Up::
toggleLayout := false
elapsedTime := A_TickCount - startTime
if (elapsedTime < 250){
	Send {LCtrl down}{t}{LCtrl up}
}
return

*Numpad0::		;This is for Undo / Merge
Send, {}
if (toggleLayout){
	Send, {LCtrl down}{e}{LCtrl up}
}
else{
	Send, {LCtrl down}{z}{LCtrl up}
}
return

*NumpadDot::	; This is for Redo
Send, {LCtrl down}{y}{LCtrl up}
return

;This is the Numlock off mode. For some reason the Layout change method is buggy

*NumpadEnd::	; This is for Cut or Copy. Cut has special case.
if (toggleLayout){
	Send, {LCtrl down}{x}{LCtrl up}
}
else {
	Send, {LCtrl down}{c}{LCtrl up}
}
return

*NumpadPgDn::	; This is for paste
Send, {LCtrl down}{v}{LCtrl up}
return

*NumpadIns::
Send, {LShift down}
KeyWait, NumpadIns
Send, {LShift up}
return

*NumpadDel::
Send, {LAlt down}
KeyWait, NumpadDel
Send, {LAlt up}
return

;This is function area.

;This is for change brush size function. Reuseable with anything
changeSize(){
	Send, {LCtrl down}{LAlt down}
    KeyWait, %A_PriorHotkey%
	Send, {LCtrl up}{LAlt up}
    return
}