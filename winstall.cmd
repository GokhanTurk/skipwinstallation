@echo off
cls
color 0B
title Windows Setup Assistant - Gokhan Turk
:MainMenu
cls
echo ========================================================
echo          WINDOWS SETUP ASSISTANT (OOBE TOOL)
echo ========================================================
echo.
echo  [1] Turkce (Temiz Kurulum)
echo      - unattendedtr.xml (Dil Turkce olur) indirilir ve Sysprep calistirilir.
echo      - Otomatik kurulum ve optimizasyon saglar.
echo.
echo  [2] English (Clean Setup)
echo      - Downloads unattendedeng.xml (Language will be English) and runs Sysprep.
echo      - Performs automated setup and optimization.
echo.
echo  [3] Bypass Online Account Only
echo      - Sadece online hesap zorunlulugunu kaldirir.
echo      - Removes online account requirement only.
echo.
echo ========================================================
set /p choice="Seciminizi yapin / Select option (1-3): "

if "%choice%"=="1" goto SetupTR
if "%choice%"=="2" goto SetupENG
if "%choice%"=="3" goto BypassMenu
goto MainMenu

:SetupTR
cls
echo [INFO] Turkce yapilandirma indiriliyor...
if not exist "C:\Windows\Panther" mkdir "C:\Windows\Panther"
curl -L -o "C:\Windows\Panther\unattendedtr.xml" "https://raw.githubusercontent.com/GokhanTurk/skipwinstallation/refs/heads/feature/test/unattendedtr.xml"
if %errorlevel% neq 0 (
    echo [ERROR] Dosya indirilemedi! Internet baglantinizi kontrol edin.
    pause
    goto MainMenu
)
echo [INFO] Sysprep baslatiliyor...
%WINDIR%\System32\Sysprep\Sysprep.exe /generalize /oobe /unattend:C:\Windows\Panther\unattendedtr.xml /reboot
goto End

:SetupENG
cls
echo [INFO] Downloading English configuration...
if not exist "C:\Windows\Panther" mkdir "C:\Windows\Panther"
curl -L -o "C:\Windows\Panther\unattendedeng.xml" "https://raw.githubusercontent.com/GokhanTurk/skipwinstallation/refs/heads/feature/test/unattendedeng.xml"
if %errorlevel% neq 0 (
    echo [ERROR] Failed to download file! Check internet connection.
    pause
    goto MainMenu
)
echo [INFO] Starting Sysprep...
%WINDIR%\System32\Sysprep\Sysprep.exe /generalize /oobe /unattend:C:\Windows\Panther\unattendedeng.xml /reboot
goto End

:BypassMenu
cls
echo ========================================================
echo          BYPASS ONLINE ACCOUNT OPTIONS
echo ========================================================
echo.
echo  [1] start ms-cxh:localonly
echo      - Yerel hesap ekranini tetikler. Ise yaramazsa diger secenekleri deneyin.
echo        veya CTRL + SHIFT + J ile dev console'u acip su komutu yapistirin:
echo      - Triggers the local account creation screen directly. If it doesn't work,
echo        try other options or open dev console with CTRL + SHIFT + J and paste the following command:
echo        WinJS.Application.restart("ms-cxh:localonly")
echo.
echo  [2] BypassNRO Method
echo      - Klasik 'Internetim yok' butonunu aktif eder. Yeniden basladiktan sonra interneti kesmeniz gerekir!
echo      - Enables the "I don't have internet" button. You will need to disconnect from the internet after rebooting!
echo.
echo  [3] Net User Method (Manuel Kullanici)
echo      - Sececeginiz isimde, yerel Admin olusturur ve OOBE (Kurulum) ekranini atlar.
echo      - Creates a local admin with the name you choose and bypasses OOBE (Setup).
echo.
echo  [4] Ana Menuye Don / Back to Main Menu
echo.
echo ========================================================
set /p subchoice="Seciminizi yapin / Select option (1-4): "

if "%subchoice%"=="1" goto MethodLocalOnly
if "%subchoice%"=="2" goto MethodBypassNRO
if "%subchoice%"=="3" goto MethodNetUser
if "%subchoice%"=="4" goto MainMenu
goto BypassMenu

:MethodLocalOnly
cls
echo [INFO] 'ms-cxh:localonly' komutu calistiriliyor...
echo.
start ms-cxh:localonly
echo.
echo [!] Eger karsiniza ekran gelmediyse veya hata verdiyse, herhangi bir tusa basarak diğer seçenekleri deneyebilirsiniz veya
echo     CTRL + SHIFT + J tus kombinasyonu ile dev console'u acip su komutu yapistirin:
echo     If screen does not appear, try other options or open dev console with CTRL + SHIFT + J and paste the following command:
echo     WinJS.Application.restart("ms-cxh:localonly")
pause
goto BypassMenu

:MethodBypassNRO
cls
echo [BILGI/INFO] BypassNRO kaydi ekleniyor... / Adding Registry key...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v BypassNRO /t REG_DWORD /d 1 /f
echo.
echo [UYARI/WARNING]
echo Bilgisayar simdi yeniden baslatilacak. / System will restart now.
echo Yeniden başladıktan sonra interneti kesmeniz gerekecek.
echo You will need to disconnect from the internet after rebooting.
echo.
pause
shutdown /r /t 0
goto End

:MethodNetUser
cls
echo [BILGI/INFO] Manuel Kullanici Olusturma / Manual User Creation
echo.
set /p newusername="Kullanici Adi Girin (Bosluksuz) / Enter Username (No spaces): "
if "%newusername%"=="" goto MethodNetUser
echo.
echo [1/6] Kullanici olusturuluyor... / Creating user...
net user "%newusername%" /add /active:yes
echo.
echo [2/6] Administrators grubuna ekleniyor... / Adding to Admins...
net localgroup administrators "%newusername%" /add
echo.
echo [3/6] Kullanici sifresi suresiz yapiliyor... / Setting password to never expire...
net user "%newusername%" /expires:never
echo.
echo [4/6] Administrator hesabi devre disi birakiliyor... / Disabling built-in Administrator account...
net user "Administrator" /active:no
echo [5/6] defaultuser0 temizleniyor... / Cleaning up defaultuser0...
net user "defaultuser0" /delete
echo.
echo [6/6] Registry duzenlemeleri yapiliyor... / Applying registry tweaks...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v DefaultAccountAction /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v DefaultAccountSAMName /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v DefaultAccountSID /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v LaunchUserOOBE /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v SkipMachineOOBE /t REG_DWORD /d 1 /f
echo.
echo [BASARILI/SUCCESS] Bilgisayar yeniden baslatiliyor... / Rebooting...
shutdown /r /t 2
goto End

:End