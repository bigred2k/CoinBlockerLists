:: CoinBlockerLists Downloader
:: This script will first create a backup of the original or current hosts
:: file and save it in a file titled "hosts.bak"
:: It will then download the latest updated hosts file
:: Finally the DNS cache will also be refreshed.
:: THIS BAT FILE MUST BE LAUNCHED WITH ADMINISTRATOR PRIVILEGES

TITLE CoinBlockerListsDownloader

cd \
mkdir tmp

:: Check if we are administrator. If not, exit immediately.

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %ERRORLEVEL% NEQ 0 (
    ECHO This script must be run with administrator privileges!
    ECHO Please launch command prompt as administrator. Exiting...
    EXIT /B 1
)
if not exist "%WINDIR%\System32\drivers\etc\hosts.bak" (
	COPY %WINDIR%\System32\drivers\etc\hosts %WINDIR%\System32\drivers\etc\hosts.bak
    )
if not exist "%WINDIR%\System32\drivers\etc\hosts.original" (
	COPY %WINDIR%\System32\drivers\etc\hosts %WINDIR%\System32\drivers\etc\hosts.original
    )
:: Download Latest Updated Hosts File
:: Uses a Windows component called BITS
:: It has been included in Windows since XP and 2000 SP3

bitsadmin.exe /transfer "Download Fresh Hosts File" https://raw.githubusercontent.com/ZeroDot1/CoinBlockerLists/master/hosts C:\tmp\hosts

@echo # Copyright (c) 1993-2009 Microsoft Corp. >> C:\tmp\hosts
@echo # >> C:\tmp\hosts
@echo # This is a sample HOSTS file used by Microsoft TCP/IP for Windows. >> C:\tmp\hosts
@echo # >> C:\tmp\hosts
@echo # This file contains the mappings of IP addresses to host names. Each >> C:\tmp\hosts
@echo # entry should be kept on an individual line. The IP address should >> C:\tmp\hosts
@echo # be placed in the first column followed by the corresponding host name. >> C:\tmp\hosts
@echo # The IP address and the host name should be separated by at least one >> C:\tmp\hosts
@echo # space. >> C:\tmp\hosts
@echo # >> C:\tmp\hosts
@echo # Additionally, comments (such as these) may be inserted on individual >> C:\tmp\hosts
@echo # lines or following the machine name denoted by a '#' symbol. >> C:\tmp\hosts
@echo # >> C:\tmp\hosts
@echo # For example: >> C:\tmp\hosts
@echo # >> C:\tmp\hosts
@echo #      102.54.94.97     rhino.acme.com          # source server >> C:\tmp\hosts
@echo #       38.25.63.10     x.acme.com              # x client host >> C:\tmp\hosts
@echo # localhost name resolution is handle within DNS itself. >> C:\tmp\hosts
@echo #       127.0.0.1       localhost >> C:\tmp\hosts
@echo #       ::1             localhost >> C:\tmp\hosts
@echo 127.0.0.1 localhost >> C:\tmp\hosts
@echo 127.0.0.1 localhost.localdomain >> C:\tmp\hosts
@echo 127.0.0.1 local >> C:\tmp\hosts
@echo 255.255.255.255 broadcasthost >> C:\tmp\hosts
@echo ::1 localhost ip6-localhost ip6-loopback >> C:\tmp\hosts
@echo fe80::1%lo0 localhost >> C:\tmp\hosts
@echo ff02::1 ip6-allnodes >> C:\tmp\hosts
@echo ff02::2 ip6-allrouters >> C:\tmp\hosts
@echo 0.0.0.0 0.0.0.0 >> C:\tmp\hosts

echo Move new hosts file in-place

:: Move new hosts file in-place

COPY C:\tmp\hosts %WINDIR%\System32\drivers\etc\

echo Flush the DNS cache

:: Flush the DNS cache

ipconfig /flushdns

echo ALL DONE! Your computer is now protected against cryptojaking.
