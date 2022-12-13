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
::cRo6pxp7LAbNWATEpSI=
::egkzugNsPRvcWATEpSI=
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

set EXE_VER=v1.8

title Magisk修补刷入工具%EXE_VER%
:MAIN
cls
echo.
echo.Magisk修补刷入工具%EXE_VER%
echo.by:忆清鸣、luckyzyx
echo.
echo.1.解锁BootLoader
echo.2.更新内置Magisk版本
echo.3.修补boot.img文件
echo.4.刷入boot.img镜像
echo.5.关闭AVB校验(一般无需使用)
echo.q.退出
echo.
set SELECT=
set /p SELECT="请输入要进行的操作序号:"
if "%SELECT%" == "1" goto UNLOCK
if "%SELECT%" == "2" goto UPDATE
if "%SELECT%" == "3" goto PATCH
if "%SELECT%" == "4" goto FLASH
if "%SELECT%" == "5" goto FLASHAVB
if /i "%SELECT%" == "q" exit
goto MAIN

:UNLOCK
cls
echo.
echo.Magisk修补刷入工具%EXE_VER%
echo.by:忆清鸣、luckyzyx
echo.
echo.解锁BootLoader
echo.输入y开始解锁
echo.输入q返回菜单页面
set SetUnlock=
set /p SetUnlock="输入要进行的操作(y/q):"
if /i "%SetUnlock%" == "y" goto STARTUNLOCK
if /i "%SetUnlock%" == "q" ( goto MAIN )
goto UNLOCK

:STARTUNLOCK
echo.
echo.确保处于BootLoader(fastboot)模式下连接设备
echo.
bin\fastboot flashing unlock
pause
goto MAIN

:UPDATE
cls
echo.
echo.Magisk修补刷入工具%EXE_VER%
echo.by:忆清鸣、luckyzyx
echo.
echo.更新内置Magisk版本
echo.输入q返回菜单页面
bin\busybox bash -c "echo 当前Magisk版本为:`cat bin/util_functions.sh | grep MAGISK_VER | cut -d = -f 2`"
set MagiskDir=
set /p MagiskDir="拖拽Magisk.zip/apk文件到此进行更新(q):"
if /i "%MagiskDir%" == "q" ( goto MAIN )
if not exist %MagiskDir% ( echo.未检测到文件 %MagiskDir% & goto UPDATE ) else ( goto STARTUPDATE )
:STARTUPDATE
rd /s /q tmp 1>nul 2>nul
bin\busybox unzip %MagiskDir% -d tmp -n | bin\busybox grep -E "arm|util_functions" | bin\busybox sed "s/ //g"
echo.
if not exist tmp/META-INF ( echo.文件错误! & rd /s /q tmp 1>nul 2>nul & pause & goto UPDATE )
if exist tmp\assets\util_functions.sh (
	bin\busybox bash -c "echo Magisk版本已更新为:`cat tmp/assets/util_functions.sh | grep MAGISK_VER | cut -d = -f 2`"
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
echo.更新完成！
rd /s /q tmp
echo.
pause
goto MAIN

:PATCH
cls
echo.
echo.Magisk修补刷入工具%EXE_VER%
echo.by:忆清鸣、luckyzyx
echo.
echo.修补boot.img文件
echo.如需切换Magisk版本请先更新Magisk版本再进行修补
bin\busybox bash -c "echo 当前Magisk版本为:`cat bin/util_functions.sh | grep MAGISK_VER | cut -d = -f 2`"
echo.输入q返回菜单页面
echo.
setlocal enabledelayedexpansion
if exist boot.img (
	set BOOTIMG=boot.img
	set PatchFlag=
	set /p PatchFlag="检测到当前目录下boot.img镜像文件 !BOOTIMG! 是否修补? (y/n/q)"
	if /i "!PatchFlag!" == "y" goto STARTPATCH
	if /i "!PatchFlag!" == "n" goto CUSTOMPATCH
	if /i "!PatchFlag!" == "q" goto MAIN
	goto PATCH
)
:CUSTOMPATCH
set BOOTIMG=
set /p BOOTIMG="请输入要修补的boot文件路径或拖拽boot.img文件到此进行修补(q):"
if /i "!BOOTIMG!" == "q" ( goto MAIN )
if not exist !BOOTIMG! ( echo.未检测到文件 %BOOTIMG% & goto CUSTOMPATCH) else ( goto STARTPATCH )
:STARTPATCH
if exist boot_patched.img (del /s /q boot_patched.img 1>nul 2>nul)
bin\busybox bash bin/boot_patch.sh !BOOTIMG!
if exist new-boot.img (
    move new-boot.img boot_patched.img 1>nul 2>nul & echo.已修补 boot.img 为 boot_patched.img
) else ( 
    echo.修补 boot.img 出错 & pause & goto PATCH
)
echo.
setlocal disabledelayedexpansion
pause
goto MAIN

:FLASH
cls
echo.
echo.Magisk修补刷入工具%EXE_VER%
echo.by:忆清鸣、luckyzyx
echo.
echo.刷入boot.img镜像
echo.输入q返回菜单页面
echo.
setlocal enabledelayedexpansion
if exist boot_patched.img (
	set BOOTIMG=boot_patched.img
	set FlashFlag=
	set /p FlashFlag="检测到已修补的boot镜像 !BOOTIMG! 是否刷入? (y/n/q)"
	if /i "!FlashFlag!" EQU "y" goto CHECKVAB
	if /i "!FlashFlag!" EQU "n" goto CUSTOMFLASH
	if /i "!FlashFlag!" EQU "q" goto MAIN
	goto FLASH
)
:CUSTOMFLASH
set BOOTIMG=
set /p BOOTIMG="请将要刷入的boot.img镜像文件拖动到此处(q):"
if /i "!BOOTIMG!" == "q" ( goto MAIN )
if not exist !BOOTIMG! ( echo.未检测到文件 %BOOTIMG% & goto CUSTOMFLASH) else ( goto CHECKVAB )
:CHECKVAB
echo.
echo.选择你的手机分区类型(不知道选择 1 )
echo.1.非VAB类型(单分区)
echo.2.VAB类型(具有ab分区,可以切换ab槽位)
echo.输入q返回菜单页面
set VAB=
set /p VAB="请输入选项然后回车(1/2/q):"
if "!VAB!" == "1" set VABType= & goto STARTFLASH 
if "!VAB!" == "2" set VABType=_ab & goto STARTFLASH 
if /i "!VAB!" == "q" goto MAIN
goto CHECKVAB
:STARTFLASH
bin\fastboot devices
bin\fastboot flash boot!VABType! !BOOTIMG!
bin\fastboot reboot
echo.刷入完成!
echo.
setlocal disabledelayedexpansion
pause
goto MAIN

:FLASHAVB
cls
echo.
echo.Magisk修补刷入工具%EXE_VER%
echo.by:忆清鸣、luckyzyx
echo.
echo.关闭AVB校验
echo.刷入vbmeta.img镜像
echo.输入q返回菜单页面
echo.
setlocal enabledelayedexpansion
if exist vbmeta.img (
	set VBIMG=vbmeta.img
	set AVBFlashFlag=""
	set /p AVBFlashFlag="检测到目录下vbmeta.img镜像 !VBIMG! 是否刷入? (y/n/q)"
	if /i "!AVBFlashFlag!" EQU "y" goto STARTFLASHAVB
	if /i "!AVBFlashFlag!" EQU "n" goto CUSTOMFLASHAVB
	if /i "!AVBFlashFlag!" EQU "q" goto MAIN
	goto FLASH
)
:CUSTOMFLASHAVB
set VBIMG=
set /p VBIMG="请将要刷入的vbmeta.img镜像文件拖动到此处(q):"
if /i "!VBIMG!" == "q" ( goto MAIN )
if not exist !VBIMG! ( echo.未检测到文件 %VBIMG% & goto CUSTOMFLASHAVB) else ( goto STARTFLASHAVB )
:STARTFLASHAVB
bin\fastboot devices
bin\fastboot --disable-verity --disable-verification flash vbmeta !VBIMG!
bin\fastboot reboot
echo.刷入完成!
echo.
setlocal disabledelayedexpansion
pause
goto MAIN
