@echo off

Echo Current IP Settings for LAN:
netsh interface ip show addresses "Local Area Connection" | findstr "IP Address"
netsh interface ip show addresses "Local Area Connection" | findstr "DHCP"
echo.
:Start
echo Choose:
echo [A] Set Static IP
echo [B] Set DHCP
echo.
:choice
SET /P C=[A,B]?
for %%? in (A) do if /I "%C%"=="%%?" goto A
for %%? in (B) do if /I "%C%"=="%%?" goto B
goto choice

:A
@echo off
echo Enter Desired Static IP Information, or x to Return to Start
set /p IP_Addr=
if '%IP_Addr%'=='x' goto start
if '%IP_Addr%'=='X' goto start
echo Setting Static IP Information
@ping -n 1 -w 500 %IP_ADDR% | find "TTL" > nul && Echo. && echo The specified IP is in use && echo. && goto A 
netsh interface ip set address "Local Area Connection" static %IP_Addr% 255.255.0.0 172.16.0.120 || Echo Invalid IP Entered && echo. && goto A
netsh interface ip add dnsservers "Local Area Connection" 172.16.0.29 >nul

::sets metric to 2 so i can bypass the fucking locks and use wireless as primary internet connection
netsh interface ip add dnsservers "Local Area Connection" 172.16.0.21 index=2 >nul 

echo IP Succesfully changed to %IP_Addr%
echo.
goto C

:B
@ECHO OFF
ECHO Resetting IP Address and Subnet Mask For DHCP
netsh int ip set address name = "Local Area Connection" source = dhcp
ECHO Here are the new settings for %computername%:
netsh interface ip show addresses "Local Area Connection" | findstr "IP Address"
echo.
goto C

:C
Echo Enter Y to restart this program, or x to exit
set /p restart=
if '%restart%'=='y' goto start
if '%restart%'=='Y' goto start

:end
