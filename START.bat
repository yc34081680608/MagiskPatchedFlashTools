::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCmDJH6N4EolKid5TQOLL2CKB6Ef4O3/yeaGsUUpW+0za7Pd26KHI+8dpEznevY=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSTk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJhZko0
::ZQ05rAF9IBncCkqN+0xwdVsFAlXi
::ZQ05rAF9IAHYFVzEqQIdKRxdXw8G46Uyx3CZAD9+Ci8CdYiYsTVf
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCmDJH6N4EolKid5TQOLL2CKB6Ef4O3/yeaGsUUpW+0za7Po7pW8FK4W8kCE
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
set EXE_VER=v1.4
title Magisk�޲�ˢ�빤��%EXE_VER%
:MAIN
cls
echo.
echo.Magisk�޲�ˢ�빤��%EXE_VER%
echo.by:��������luckyzyx
echo.
echo.1.��������Magisk�汾
echo.2.�޲�boot.img�ļ�
echo.3.ˢ��boot.img����
echo.q.�˳�
echo.
set SELECT=""
set /p SELECT="������Ҫ���еĲ������:"
if "%SELECT%" == "1" goto UPDATE
if "%SELECT%" == "2" goto PATCH
if "%SELECT%" == "3" goto FLASH
if /i "%SELECT%" == "q" exit
goto MAIN
:UPDATE
cls
echo.
echo.Magisk�޲�ˢ�빤��%EXE_VER%
echo.by:��������luckyzyx
echo.
echo.��������Magisk�汾
echo.����q���ز˵�ҳ��
bin\busybox bash -c "echo ��ǰMagisk�汾Ϊ:`cat bin/util_functions.sh | grep MAGISK_VER | cut -d = -f 2`"
set MagiskDir=""
set /p MagiskDir="��קMagisk.zip/apk�ļ����˽��и���(q):"
if /i "%MagiskDir%" == "q" ( goto MAIN )
if not exist %MagiskDir% ( echo.δ��⵽�ļ� %MagiskDir% & goto UPDATE ) else ( goto STARTUPDATE )
:STARTUPDATE
rd /s /q tmp 1>nul 2>nul
bin\busybox unzip %MagiskDir% -d tmp -n | bin\busybox grep -E "arm|util_functions" | bin\busybox sed "s/ //g"
echo.
if not exist tmp/META-INF ( echo.�ļ�����! & rd /s /q tmp 1>nul 2>nul & pause & goto UPDATE )
if exist tmp\assets\util_functions.sh (
	bin\busybox bash -c "echo Magisk�汾�Ѹ���Ϊ:`cat tmp/assets/util_functions.sh | grep MAGISK_VER | cut -d = -f 2`"
	copy tmp\assets\util_functions.sh bin\util_functions.sh 1>nul 2>nul
)
if exist tmp\lib\arm64-v8a (
	del bin\magisk64 1>nul 2>nul
	del bin\magiskinit 1>nul 2>nul
	copy tmp\lib\arm64-v8a\libmagisk64.so bin\magisk64 1>nul 2>nul
	copy tmp\lib\arm64-v8a\libmagiskinit.so bin\magiskinit 1>nul 2>nul
)
if exist tmp\lib\armeabi-v7a (
	del bin\magisk32 1>nul 2>nul
	copy tmp\lib\armeabi-v7a\libmagisk32.so bin\magisk32 1>nul 2>nul
	if exist tmp\lib\armeabi-v7a\libmagisk64.so (
		copy tmp\lib\armeabi-v7a\libmagisk64.so bin\magisk64 1>nul 2>nul
	)
	if not exist tmp\lib\arm64-v8a\libmagiskinit.so (
		copy tmp\lib\armeabi-v7a\libmagiskinit.so bin\magiskinit 1>nul 2>nul
	)
)
echo.������ɣ�
rd /s /q tmp
echo.
pause
goto MAIN

:PATCH
cls
echo.
echo.Magisk�޲�ˢ�빤��%EXE_VER%
echo.by:��������luckyzyx
echo.
echo.�޲�boot.img�ļ�
echo.�����л�Magisk�汾���ȸ���Magisk�汾�ٽ����޲�
bin\busybox bash -c "echo ��ǰMagisk�汾Ϊ:`cat bin/util_functions.sh | grep MAGISK_VER | cut -d = -f 2`"
echo.����q���ز˵�ҳ��
echo.
setlocal enabledelayedexpansion
if exist boot.img (
	set BOOTIMG=boot.img
	set PatchFlag=""
	set /p PatchFlag="��⵽��ǰĿ¼��boot.img�����ļ� !BOOTIMG! �Ƿ��޲�? (y/n/q)"
	if /i "!PatchFlag!" == "y" goto STARTPATCH
	if /i "!PatchFlag!" == "n" goto CUSTOMPATCH
	if /i "!PatchFlag!" == "q" goto MAIN
	goto PATCH
)
:CUSTOMPATCH
set BOOTIMG=""
set /p BOOTIMG="������Ҫ�޲���boot�ļ�·������קboot.img�ļ����˽����޲�(q):"
if /i "!BOOTIMG!" == "q" ( goto MAIN )
if not exist !BOOTIMG! ( echo.δ��⵽�ļ� %BootDir% & goto CUSTOMPATCH) else ( goto STARTPATCH )
:STARTPATCH
if exist boot_patched.img (del /s /q boot_patched.img 1>nul 2>nul)
bin\busybox bash bin/boot_patch.sh !BOOTIMG!
if exist new-boot.img (
    move new-boot.img boot_patched.img 1>nul 2>nul & echo.���޲� boot.img Ϊ boot_patched.img
) else ( 
    echo.�޲� boot.img ���� & pause & goto PATCH
)
echo.
setlocal disabledelayedexpansion
pause
goto MAIN

:FLASH
cls
echo.
echo.Magisk�޲�ˢ�빤��%EXE_VER%
echo.by:��������luckyzyx
echo.
echo.ˢ��boot.img����
echo.����q���ز˵�ҳ��
echo.
setlocal enabledelayedexpansion
if exist boot_patched.img (
	set BOOTIMG=boot_patched.img
	set FlashFlag=""
	set /p FlashFlag="��⵽���޲���boot���� !BOOTIMG! �Ƿ�ˢ��? (y/n/q)"
	if /i "!FlashFlag!" EQU "y" goto CHECKVAB
	if /i "!FlashFlag!" EQU "n" goto CUSTOMFLASH
	if /i "!FlashFlag!" EQU "q" goto MAIN
	goto FLASH
)
:CUSTOMFLASH
set BOOTIMG=""
set /p BOOTIMG="�뽫Ҫˢ���boot.img�����ļ��϶����˴�(q):"
if /i "!BOOTIMG!" == "q" ( goto MAIN )
if not exist !BOOTIMG! ( echo.δ��⵽�ļ� %BootDir% & goto CUSTOMFLASH) else ( goto CHECKVAB )
:CHECKVAB
echo.
echo.ѡ������ֻ���������(��֪��ѡ�� 1 )
echo.1.��VAB����(������)
echo.2.VAB����(����ab����,�����л�ab��λ)
echo.����q���ز˵�ҳ��
set VAB=""
set /p VAB="������ѡ��Ȼ��س�(1/2/q):"
if "!VAB!" == "1" set VABType= & goto STARTFLASH 
if "!VAB!" == "2" set VABType=_ab & goto STARTFLASH 
if /i "!VAB!" == "q" goto MAIN
goto CHECKVAB
:STARTFLASH
bin\fastboot devices
bin\fastboot flash boot!VABType! !BOOTIMG!
bin\fastboot reboot
echo.ˢ�����!
echo.
setlocal disabledelayedexpansion
pause
goto MAIN
