#MaxHotkeysPerInterval 1000
#HotkeyInterval 1000
#Persistent
#SingleInstance force
SetTitleMatchMode RegEx
SetDefaultMouseSpeed, 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;OJAD

#If 0

^!q::
keywait, ctrl
keywait, alt
keywait, q
global dictOJAD
if(dictOJAD="")
    dictOJAD:={}
MouseGetPos, xpos, ypos
InputBox, num
dictOJAD[num]:=xpos
return

^!w::
keywait, ctrl
keywait, alt
keywait, w
global dictOJADy
if(dictOJADy="")
    dictOJADy:={}
MouseGetPos, xpos, ypos
InputBox, num
dictOJADy[num]:=ypos
return

^!e::
keywait, ctrl
keywait, alt
keywait, e
global dictOJAD
dictOJAD:={}
while(1)
{
    state:=GetKeyState("RButton", "P")
    if(state)
    {
        KeyWait, RButton
        break
    }
    state:=GetKeyState("LButton", "P")
    if(state)
    {
        MouseGetPos, xpos, ypos
        dictOJAD.Push(xpos)
        KeyWait, LButton
    }
    sleep, 10
}
count:=dictOJAD.Count()
msgbox, dictOJAD.Count=%count%
return

movePos(d)
{
    global dictOJAD
    if(dictOJAD="")
        dictOJAD:={}
    if(dictOJAD.Count()=0)
    {
        msgbox, dictOJAD.Count()=0
        return
    }
    dict:={}
    i:=dictOJAD.MinIndex()
    while(i<=dictOJAD.MaxIndex())
    {
        if(dictOJAD.HasKey(i))
            dict[i]:=dictOJAD[i]
        else
        {
            j:=i
            while(!dictOJAD.HasKey(j))
                j--
            k:=i
            while(!dictOJAD.HasKey(k))
                k++
            dict[i]:=Round(((k-i)*dictOJAD[j]+(i-j)*dictOJAD[k])/(k-j))
        }
        i++
    }
    MouseGetPos, xpos, ypos
    k:=1
    i:=2
    while(i<=dict.MaxIndex())
    {
        if(Abs(xpos-dict[k])>Abs(xpos-dict[i]))
            k:=i
        i++
    }
    k+=d
    k:=Min(dict.MaxIndex(), Max(dict.MinIndex(), k))
    mousemove, dict[k], ypos
}

movePosY(d)
{
    global dictOJADy
    if(dictOJADy="")
        dictOJADy:={}
    if(dictOJADy.Count()<2)
    {
        msgbox, dictOJADy.Count()<2
        return
    }
    dis:=Round((dictOJADy[dictOJADy.MaxIndex()]-dictOJADy[dictOJADy.MinIndex()])/(dictOJADy.MaxIndex()-dictOJADy.MinIndex()))
    dis:=dis*d
    mousemove, 0, %dis%, 0, relative
}

numpad9::
movePos(1)
click
return

numpad8::
movePos(-1)
click
return

numpad7::
movePos(-100)
click
return

numpad6::
movePosY(1)
click
return

numpad5::
movePosY(-1)
click
return

numpad3::
mousemove, 40, 0, 0, relative
click
return

numpad2::
mousemove, -40, 0, 0, relative
click
return

#If

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

+F1::
if winactive("夜神模擬器")
{
    WinMinimize, 夜神模擬器
}
else
{
    WinActivate, 夜神模擬器
}
return

#IfWinNotActive ahk_exe calc.exe

+F2::
numpadsub::
if not getkeystate("LButton")
    click, down
else
    click, up
return

#IfWinNotActive

Launch_Mail::
if winactive("ahk_exe chrome.exe")
    mousemove, 1919, 135, 0
else if winactive("ahk_exe firefox.exe")
    mousemove, 1919, 106, 0
else
    mousemove, 1919, 135, 0
gosub +F2
return

#IfWinActive ahk_exe chrome.exe

numpadmult::
mousescrolldistance:=80
mousemove, 0, %mousescrolldistance%, 0, relative
return

Browser_Favorites::
mousescrolldistance:=80
mousemove, 0, -%mousescrolldistance%, 0, relative
return

#IfWinActive

#IfWinNotActive ahk_exe calc.exe

numpaddiv::
click, up
send, ^w
return

#IfWinNotActive

Browser_Search::
keywait, Browser_Search, L
sleep, 10
click, up
if winactive("ahk_exe chrome.exe")
{
    send, ^w{ctrl down}{shift down}{tab}{shift up}{ctrl up}
;    sleep, 10
;    send, ^w
;    sleep, 10
;    send, {ctrl down}{tab}{ctrl up}
}
else
    send, {alt down}{f4}{alt up}
return

#IfWinExist ahk_exe chrome.exe

Browser_Home::
if not winactive("ahk_exe chrome.exe")
{
    WinActivate, ahk_exe chrome.exe
sleep, 1
WinActivate, ahk_exe chrome.exe
}
else
{
    click, right
    send, i^w^{tab}
}
return

#IfWinExist

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

copyToClipboardTrim()
{
    tmp:=clipboard
    cnt:=10
    while(cnt>0 && tmp==clipboard)
    {
        cnt-=1
        send, ^c
        sleep, 10
    }
    clipboard:=trim(clipboard)
}

^!t::
keywait, ctrl
keywait, alt
keywait, t
FormatTime, TimeString, , yyyyMMddHHmmss
send, %TimeString%
return

^!q::
keywait, ctrl
keywait, alt
keywait, q
copyToClipboardTrim()
Search:="https://dictionary.cambridge.org/zht/%E8%A9%9E%E5%85%B8/%E8%8B%B1%E8%AA%9E-%E6%BC%A2%E8%AA%9E-%E7%B9%81%E9%AB%94/"
chromePath:="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
run, %chromePath% "%Search%%clipboard%"
mousemove, 810, 608
return

^!w::
keywait, ctrl
keywait, alt
keywait, w
copyToClipboardTrim()
Search:="https://dictionary.cambridge.org/zht/%E8%A9%9E%E5%85%B8/%E8%8B%B1%E8%AA%9E/"
chromePath:="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
run, %chromePath% "%Search%%clipboard%"
mousemove, 810, 608
return

^!a::
keywait, ctrl
keywait, alt
keywait, a
copyToClipboardTrim()
Search:="https://dictionary.goo.ne.jp/word/"
chromePath:="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
run, %chromePath% "%Search%%clipboard%"
return

^!s::
keywait, ctrl
keywait, alt
keywait, s
copyToClipboardTrim()
Search:="https://www.weblio.jp/content/"
chromePath:="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
run, %chromePath% "%Search%%clipboard%"
return

^!v::
loop 100{
click
}
return

^!c::
loop 20{
send, {left}{right}
}
return
*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinExist ^演奏動画.*ぷりんと楽譜 - Google Chrome$

^numpad0::
t:=200
keywait, ctrl
keywait, numpad0
search:="^演奏動画.*ぷりんと楽譜 - Google Chrome$"
minimize:=not winactive(search)
mousegetpos, x, y
winactivate, %search%
send, ^w
sleep, %t%
if not winactive(search)
{
    msgbox, no 演奏動画, cannot play
    return
}
click, 993, 394
sleep, %t%
send, 1
if minimize
    winminimize, A
mousemove, %x%, %y%
return

^!numpad0::
t:=600
t2:=200
keywait, ctrl
keywait, alt
keywait, numpad0
search:="^演奏動画.*ぷりんと楽譜 - Google Chrome$"
while true
{
    click, 993, 394
    sleep, %t2%
    click, 993, 394
    send, ^{tab}
    if !winactive(search)
        break
    sleep, %t%
}
return

#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive ahk_exe chrome.exe

^WheelDown::
^WheelUp::
^+WheelDown::
^+WheelUp::
^!WheelDown::
^!WheelUp::
^!+WheelDown::
^!+WheelUp::
return

^+w::
return

^+q::
return

#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive ahk_exe osu!.exe

tab::
+tab::
return
 
`::
+`::
return

#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

insert::
^Insert::
+Insert::
click down
keywait insert
click up
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

~pause::
keywait, pause
reload
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^!f:: run http://www.facebook.com

^!d:: run https://drive.google.com/drive/my-drive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/*

#IfWinActive ^Beatmap Listing - Google Chrome$

numpad1::
mousemove -637, 0, 0, R
click
return

numpad3::
mousemove 637, 0, 0, R
click
return

numpad2::
mousemove 0, 98, 0, R
click
return

numpad5::
mousemove 0, -98, 0, R
click
return

#IfWinActive

*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive ahk_class Progman|WorkerW$

^WheelDown::
^WheelUp::
^+WheelDown::
^+WheelUp::
^!WheelDown::
^!WheelUp::
^!+WheelDown::
^!+WheelUp::
return

#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive ahk_exe explorer.exe

^WheelDown::
^WheelUp::
^+WheelDown::
^+WheelUp::
^!WheelDown::
^!WheelUp::
^!+WheelDown::
^!+WheelUp::
return

#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;reset file timestamp

/*

^!t::
keywait, ctrl
keywait, alt
keywait, t
sleep, 10
send, {appskey}
sleep, 10
send, f
sleep, 10
send, {down 2}
sleep, 10
send, {enter}
sleep, 10
name:=clipboard
sleep, 10
filesettime %a_now%, %name%, C
sleep, 10
filesettime %a_now%, %name%, M
sleep, 10
filesettime %a_now%, %name%, A
sleep, 10
msgbox, %clipboard%
return

*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive ahk_class Photo_Lightweight_Viewer$

^w::
send, {alt down}{f4}{alt up}
return

up::
send, {left 2}
return

down::
send, {right 2}
return

pgup::
send, {left 4}
return

pgdn::
send, {right 4}
return

home::
send, {left 8}
return

end::
send, {right 8}
return

#IfWinActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^sc16D::
sc16D::

flag := GetKeyState("Ctrl", "P")
keywait, sc16D
keywait, ctrl

if not WinExist("ahk_exe chrome.exe")
{
    chromePath:="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    run, %chromePath%
    return
}

if not winactive("ahk_exe chrome.exe")
{
    WinActivate, ahk_exe chrome.exe
    return
}

if WinActive("Weblio辞書")
{
    MouseGetPos, xpos, ypos
    click, 10, 700
    mousemove, %xpos%, %ypos%
    send, {home}{pgup}
    cnt:=100
    while(1)
    {
        PixelGetColor, color, 1919, 128
        if(color!=0xF1F1F1)
            break
        sleep, 10
        cnt--
        if(cnt=0)
        {
            msgbox, scroll bar color(0xF1F1F1) not found
            return
        }
    }
    PixelGetColor, color, 1739, 369
    if(color=0x06B535)
    {
        x:=585
        y:=351
    }
    else
    {
        ;ImageSearch, FoundX, FoundY, 32, 229, 134, 339, *30 D:\4T\AutoHotkey script\weblio clipping 202005260017.png
        if(ErrorLevel=0)
        ;ImageSearch, FoundX, FoundY, 701, 710, 739, 745, *30 D:\4T\AutoHotkey script\weblio clipping 202005310104.png
        ;if(ErrorLevel=0)
        PixelGetColor, color, 147, 289
        if(color=0x95471F)
        {
            x:=585
            y:=284
        }
        else
        {
            x:=1000
            y:=830
        }
    }
    click, %x%, %y%
    send, {ctrl down}a{ctrl up}
    if flag
        send, {ctrl down}v{ctrl up}{enter}
}
else
{
    sURL := GetActiveBrowserURL()
    if RegExMatch(sURL, "^https://www.amazon.com")
    {
        send, {pgup 30}
        sleep, 150
        click, 574, 233
        send, {ctrl down}a{ctrl up}
        if flag
            send, {ctrl down}v{ctrl up}{enter}
    }
    else
        msgbox, in chrome, no match`nzzz%sURL%
}
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ModernBrowsers := "ApplicationFrameWindow,Chrome_WidgetWin_0,Chrome_WidgetWin_1,Maxthon3Cls_MainFrm,MozillaWindowClass,Slimjet_WidgetWin_1"
LegacyBrowsers := "IEFrame,OperaWindowClass"

GetActiveBrowserURL() {
    global ModernBrowsers, LegacyBrowsers
    WinGetClass, sClass, A
    If sClass In % ModernBrowsers
        Return GetBrowserURL_ACC(sClass)
    Else If sClass In % LegacyBrowsers
        Return GetBrowserURL_DDE(sClass) ; empty string if DDE not supported (or not a browser)
    Else
        Return ""
}

GetBrowserURL_DDE(sClass) {
    WinGet, sServer, ProcessName, % "ahk_class " sClass
    StringTrimRight, sServer, sServer, 4
    iCodePage := A_IsUnicode ? 0x04B0 : 0x03EC ; 0x04B0 = CP_WINUNICODE, 0x03EC = CP_WINANSI
    DllCall("DdeInitialize", "UPtrP", idInst, "Uint", 0, "Uint", 0, "Uint", 0)
    hServer := DllCall("DdeCreateStringHandle", "UPtr", idInst, "Str", sServer, "int", iCodePage)
    hTopic := DllCall("DdeCreateStringHandle", "UPtr", idInst, "Str", "WWW_GetWindowInfo", "int", iCodePage)
    hItem := DllCall("DdeCreateStringHandle", "UPtr", idInst, "Str", "0xFFFFFFFF", "int", iCodePage)
    hConv := DllCall("DdeConnect", "UPtr", idInst, "UPtr", hServer, "UPtr", hTopic, "Uint", 0)
    hData := DllCall("DdeClientTransaction", "Uint", 0, "Uint", 0, "UPtr", hConv, "UPtr", hItem, "UInt", 1, "Uint", 0x20B0, "Uint", 10000, "UPtrP", nResult) ; 0x20B0 = XTYP_REQUEST, 10000 = 10s timeout
    sData := DllCall("DdeAccessData", "Uint", hData, "Uint", 0, "Str")
    DllCall("DdeFreeStringHandle", "UPtr", idInst, "UPtr", hServer)
    DllCall("DdeFreeStringHandle", "UPtr", idInst, "UPtr", hTopic)
    DllCall("DdeFreeStringHandle", "UPtr", idInst, "UPtr", hItem)
    DllCall("DdeUnaccessData", "UPtr", hData)
    DllCall("DdeFreeDataHandle", "UPtr", hData)
    DllCall("DdeDisconnect", "UPtr", hConv)
    DllCall("DdeUninitialize", "UPtr", idInst)
    csvWindowInfo := StrGet(&sData, "CP0")
    StringSplit, sWindowInfo, csvWindowInfo, `" ;"; comment to avoid a syntax highlighting issue in autohotkey.com/boards
    Return sWindowInfo2
}

GetBrowserURL_ACC(sClass) {
    global nWindow, accAddressBar
    If (nWindow != WinExist("ahk_class " sClass)) ; reuses accAddressBar if it's the same window
    {
        nWindow := WinExist("ahk_class " sClass)
        accAddressBar := GetAddressBar(Acc_ObjectFromWindow(nWindow))
    }
    Try sURL := accAddressBar.accValue(0)
    If (sURL == "") {
        WinGet, nWindows, List, % "ahk_class " sClass ; In case of a nested browser window as in the old CoolNovo (TO DO: check if still needed)
        If (nWindows > 1) {
            accAddressBar := GetAddressBar(Acc_ObjectFromWindow(nWindows2))
            Try sURL := accAddressBar.accValue(0)
        }
    }
    If ((sURL != "") and (SubStr(sURL, 1, 4) != "http")) ; Modern browsers omit "http://"
        sURL := "http://" sURL
    If (sURL == "")
        nWindow := -1 ; Don't remember the window if there is no URL
    Return sURL
}

GetAddressBar(accObj) {
    Try If ((accObj.accRole(0) == 42) and IsURL(accObj.accValue(0)))
        Return accObj
    Try If ((accObj.accRole(0) == 42) and IsURL("http://" accObj.accValue(0))) ; Modern browsers omit "http://"
        Return accObj
    For nChild, accChild in Acc_Children(accObj)
        If IsObject(accAddressBar := GetAddressBar(accChild))
            Return accAddressBar
}

IsURL(sURL) {
    Return RegExMatch(sURL, "^(?<Protocol>https?|ftp)://(?<Domain>(?:[\w-]+\.)+\w\w+)(?::(?<Port>\d+))?/?(?<Path>(?:[^:/?# ]*/?)+)(?:\?(?<Query>[^#]+)?)?(?:\#(?<Hash>.+)?)?$")
}

Acc_Init()
{
    static h
    If Not h
        h:=DllCall("LoadLibrary","Str","oleacc","Ptr")
}
Acc_ObjectFromWindow(hWnd, idObject = 0)
{
    Acc_Init()
    If DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd, "UInt", idObject&=0xFFFFFFFF, "Ptr", -VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0
    Return ComObjEnwrap(9,pacc,1)
}
Acc_Query(Acc) {
    Try Return ComObj(9, ComObjQuery(Acc,"{618736e0-3c3d-11cf-810c-00aa00389b71}"), 1)
}
Acc_Children(Acc) {
    If ComObjType(Acc,"Name") != "IAccessible"
        ErrorLevel := "Invalid IAccessible Object"
    Else {
        Acc_Init(), cChildren:=Acc.accChildCount, Children:=[]
        If DllCall("oleacc\AccessibleChildren", "Ptr",ComObjValue(Acc), "Int",0, "Int",cChildren, "Ptr",VarSetCapacity(varChildren,cChildren*(8+2*A_PtrSize),0)*0+&varChildren, "Int*",cChildren)=0 {
            Loop %cChildren%
                i:=(A_Index-1)*(A_PtrSize*2+8)+8, child:=NumGet(varChildren,i), Children.Insert(NumGet(varChildren,i-8)=9?Acc_Query(child):child), NumGet(varChildren,i-8)=9?ObjRelease(child):
            Return Children.MaxIndex()?Children:
        } Else
            ErrorLevel := "AccessibleChildren DllCall Failed"
    }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
