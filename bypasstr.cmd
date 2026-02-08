curl -L -o C:\Windows\Panther\unattendedtr.xml https://raw.githubusercontent.com/GokhanTurk/skipwinstallation/refs/heads/feature/test/unattendedtr.xml
%WINDIR%\System32\Sysprep\Sysprep.exe /generalize /oobe /unattend:C:\Windows\Panther\unattendedtr.xml /reboot
