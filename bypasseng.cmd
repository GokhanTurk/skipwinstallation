curl -L -o C:\Windows\Panther\unattend.xml https://raw.githubusercontent.com/GokhanTurk/skipwinstallation/refs/heads/main/unattendedeng.xml
%WINDIR%\System32\Sysprep\Sysprep.exe /oobe /unattend:C:\Windows\Panther\unattendedeng.xml /reboot
