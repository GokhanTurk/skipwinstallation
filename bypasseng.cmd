curl -L -o C:\Windows\Panther\unattendedeng.xml https://raw.githubusercontent.com/GokhanTurk/skipwinstallation/refs/heads/feature/test/unattendedeng.xml
%WINDIR%\System32\Sysprep\Sysprep.exe /generalize /oobe /unattend:C:\Windows\Panther\unattendedeng.xml /reboot
