;@Ahk2Exe-AddResource prevenir_ausente-Online.ico, 210
;@Ahk2Exe-AddResource prevenir_ausente-AFK.ico, 211

#SingleInstance Force

global title := "Prevenir Ausente Teams"
global tray_timer := 3000
global toggle_afk := false

A_IconTip := title

if A_IsCompiled {
	TraySetIcon(A_ScriptFullPath, 6)
} else {
	TraySetIcon('prevenir_ausente-Online.ico')
}

TrayTip("Pressione Windows Shift L para ativar a prevenção de ausente.`r`nPressione Alt X para fechar.", title, 1)
SetTimer () => TrayTip(), -tray_timer

#HotIf !toggle_afk
#+l::
{
	KeyWait("Shift")
		global toggle_afk := true
		if A_IsCompiled {
			TraySetIcon(A_ScriptFullPath, 7)
		} else {
			TraySetIcon('prevenir_ausente-AFK.ico')
		}
	TrayTip("Prevenção de ausente ativado`r`nPressione SHIFT para desativar", title, 1)
		SetTimer () => TrayTip(), -tray_timer
		while (toggle_afk) {
			MouseMove(random(-20, 20), random(-20, 20), 1, "R")
				Sleep(random(1, 10) * 50)
		}
}

#HotIf toggle_afk
Shift::
{
	global toggle_afk := false
		if A_IsCompiled {
			TraySetIcon(A_ScriptFullPath, 6)
		} else {
			TraySetIcon('prevenir_ausente-Online.ico')
		}
	TrayTip("Prevenção de ausente desativado", title, 1)
		SetTimer () => TrayTip(), -tray_timer
}

#HotIf
!x::ExitApp
