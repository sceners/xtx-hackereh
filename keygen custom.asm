;==========================================================================================================================================
;                                                                             
;                                                                                               Source Keygen coded by SPOKE3FFF              
;                                                                                                               August  2008                                 
;                                                                                                 KeygenMe coded by hackereh@
;                                                                                                               Thanks to him.
;                                                                                                                                              
; ==========================================================================================================================================                                                                                                                                                                  
;                                                                         
;
; ///////////////////////////////////////////////////////////////////////////   INCLUDES \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
.386 
.model flat,stdcall 
option casemap:none 

include			windows.inc 
include			kernel32.inc 
include			user32.inc
include			ufmodapi.inc

includelib        	kernel32.lib
includelib	       	user32.lib 
includelib	       	uFMOD\ufmod.lib
includelib        	winmm.lib


DlgProc			proto		:DWORD,:DWORD,:DWORD,:DWORD
FadeIn      		proto		:DWORD
FadeOut		    	proto		:DWORD
Generate		       proto 		:DWORD

; /////////////////////////////////////////////////////////////////////////////// SECTION .DATA \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

.data                                                       ; contient les msgbox , déclarations de variables
       

	include chiptune.inc                          ; include the xm
	xmSize equ $ - table
	Formatdec		db		"%u",0    ; convert to decimal
	
	
	vide     db "Enter your serial ",0
	trp_long db "20 characters MAXI",0


AboutTxt	       db		   "                     hackereh@  KeygenMe                       ",10,13 ; contenu texte de la msgbox FENETRE ABOUT "A PROPOS"
			db              "                  Thanks to him for his good job .       ",10,13
			db              " ",10,13
			db              "                                      Keygen                            ",10,13
			db              "                               coded by Sp0ke                      ",10,13
			db		   "                         in  ASM (MASM32)                       ",10,13
			db		   "                              GFX by Sp0ke                     ",10,13
			db 		   "                      TeaM XTX August 2008                     ",10,13
			db              " ",10,13
			db		   "                                  Thanks to :                      ",10,13
			db              "                      Goldocrack, Burner for help                 ",10,13 
			db 		   "                                  TeaM XTX                           ",10,13
			db              " ",10,13
			db              "                                and thanks to :             ",10,13
			db              "                      all TeaM XTX members            ",10,13
			db              "                               http://xtx.free.fr/                   ",10,13
			db              "             Thanks to mars ,Baboon,Ullysse_31,,           ",10,13
			db              "                            Ezequi3L,Donald.                      ",10,13
			db              "          Thanks to Dynasty and all members.       ",10,13
			db              "                   http://deezdynasty.xdir.org                ",10,13
			db              "                        Thanks to all Teams              ",10,13
			db              "     SND,FFF,FOFF,Crackmes.de,Astalavista.MS.  ",10,13
			db		" ",0
AboutCap		db		"About keygen ",0  ;CAPTION (TITRE) DE LA FENETRE ABOUT "A PROPOS"




;////////////////////////////////////////////////////////////////////////////// SECTION .DATA? \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
.data? 

	hInstance              dd           ?
	Transparency		dd		?
	BufferNom		db		40 dup(?) 
	SerialBuffer		db		40 dup(?)
	SerialSection		db		32 dup(?)
	long                      db          40 dup(?)
	

;////////////////////////////////////////////////////////////////////////////////ID DES BOUTONS \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

.data? 
.const
	IDD_KEYGEN		       equ		1001
	IDC_EXIT		                equ		1002
	IDC_COPY		       equ		1003 
	IDC_ABOUT		       equ		1004
	IDC_NAME		       equ		1005
	IDC_SERIAL		       equ		1006
	ICON			       equ		2001
	LWA_ALPHA		       equ		2
	LWA_COLORKEY		equ		1
	WS_EX_LAYERED		equ		80000h
	DELAY_VALUE		       equ		10

;////////////////////////////////////////////////////////////////////////////////// SECTION .CODE \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

.code 
start: 
	invoke GetModuleHandle,NULL 
	mov hInstance,eax 
	invoke DialogBoxParam,hInstance,IDD_KEYGEN,NULL,addr DlgProc,NULL 
	invoke ExitProcess,eax 
	
	
;/////////////////////////////////////////////////////////////////////////////// DIALOG PROCESS, ACTION DES BOUTONS \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\	
    
DlgProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM 
	.if uMsg == WM_INITDIALOG
		invoke GetWindowLong,hWnd,GWL_EXSTYLE 
		or eax,WS_EX_LAYERED 
		invoke SetWindowLong,hWnd,GWL_EXSTYLE,eax 
		invoke SetWindowPos,hWnd,HWND_TOPMOST,0,0,0,0,SWP_NOMOVE+SWP_NOSIZE	
		invoke LoadIcon,hInstance,ICON 
		invoke SendMessage,hWnd,WM_SETICON,1,eax
		invoke GetDlgItem,hWnd,IDC_NAME
		invoke SetFocus,eax 
		invoke uFMOD_PlaySong,addr table,xmSize,XM_MEMORY
		invoke FadeIn,hWnd
	.elseif uMsg==WM_LBUTTONDOWN							
		invoke SendMessage,hWnd,WM_NCLBUTTONDOWN,HTCAPTION,lParam
	.elseif uMsg==WM_COMMAND
		mov eax,wParam
		.if ax==IDC_NAME
			shr eax,16
		.if ax==EN_CHANGE
			invoke Generate,hWnd
		.endif
	.elseif eax==IDC_ABOUT
		invoke MessageBox,hWnd,addr AboutTxt,addr AboutCap,MB_OK	
	.elseif eax==IDC_COPY
		invoke SendDlgItemMessage,hWnd,IDC_SERIAL,EM_SETSEL,0,-1 
		invoke SendDlgItemMessage,hWnd,IDC_SERIAL,WM_COPY,0,0 
	.elseif eax==IDC_EXIT 
		invoke	SendMessage,hWnd,WM_CLOSE,0,0
	.endif
	.elseif	uMsg== WM_CLOSE
		invoke FadeOut,hWnd	
		invoke uFMOD_PlaySong,0,0,0 
		invoke EndDialog,hWnd,0 
	.endif        
	xor eax,eax
	ret 
DlgProc endp 

;/////////////////////////////////////////////////////////////////////////////// EFFET Fondu sur arrivée d'image\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

FadeIn proc hWnd:HWND

	invoke ShowWindow,hWnd,SW_SHOW
	mov Transparency,5
@@:
	invoke SetLayeredWindowAttributes,hWnd,0,Transparency,LWA_ALPHA
	invoke Sleep,DELAY_VALUE
	add Transparency,5
	cmp Transparency,240
	jne @b
	ret 
	
FadeIn endp

;//////////////////////////////////////////////////////////////////////////////// EFFET Fondu sur sortie d'image \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

FadeOut proc hWnd:HWND

	mov Transparency,255
@@:
	invoke SetLayeredWindowAttributes,hWnd,0,Transparency,LWA_ALPHA
	invoke Sleep,DELAY_VALUE
	sub Transparency,5
	cmp Transparency,0
	jne @b
	ret
FadeOut endp




;////////////////////////////////////////////////////////////////////////////////ROUTINE DE GENERATION SERIAL\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Generate proc hWnd:HWND

	;============================== Generation Keygen  =======================================================================================
		invoke GetDlgItemText,hWnd,IDC_NAME,addr BufferNom,20     
			cmp eax,0                                                                        
		je @vide                                                                                 ;
			cmp eax,20                                                                     ; il verifie que le serial ne depasse pas 20 caracteres
		MOV EBX,EAX                          ; put lengh Name in EBX
		XOR ECX,ECX                          ; restore ECX
		XOR EAX,EAX                          ; restore EAX
		LEA EDI,[BufferNom]            ; mov Name in EDI
		MOV EDX,0DEADC0DEh                   ; mov DEADC0DEh in EDX

@@:

		MOVSX EAX,BYTE PTR DS:[ECX+EDI]      ; get Name 
		ADD EAX,EDX                          ; add EDX to EAX
		IMUL EAX,EAX,0666h                   ; imul 666h
		ADD EDX,EAX                          ; add EAX to EDX
		SUB EAX,0777h                        ; EAX-777h
		INC ECX                              ; loop 
		CMP ECX,EBX                          ; count the characters Name
		JNZ @b               ; loop if > 9
		MOV EBX,EAX                          ; mov EAX in EBX
		XOR EAX,EAX                          ; restore EAX
                   invoke wsprintf,addr SerialBuffer,addr Formatdec ,ebx
		invoke SetDlgItemText,hWnd,IDC_SERIAL,addr SerialBuffer        ; il invoque l'handle de l'editbox du Serial pour y afficher le serial
			ret
		@vide:
			invoke SetDlgItemText,hWnd,IDC_SERIAL,addr vide          ; il invoque l'handle de l'editbox du Serial pour y afficher un message si aucun caractère n'est entré
			ret
			trop_long:
			invoke SetDlgItemText,hWnd,IDC_SERIAL,addr trp_long     ; il invoque l'handle de l'editbox du Serial pour y afficher un message si le Nom dépasse 20 caractères
			ret
    	;===============================================================================================================================================		
Generate endp  ;  fin de génération du serial

end start   ;  FIN
