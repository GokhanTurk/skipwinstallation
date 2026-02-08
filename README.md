# Windows Setup Assistant (OOBE Tool)

![Platform](https://img.shields.io/badge/Platform-Windows%2010%20%2F%2011-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Stable-brightgreen)

<div align="center">

## [ 🇹🇷 Türkçe ](#-türkçe) | [ 🇺🇸 English ](#-english)

</div>

---

# 🇹🇷 Türkçe

**Windows Setup Assistant**, Windows kurulum sürecini otomatize eden, OOBE (Out-of-Box Experience) ekranlarını atlayan ve gelişmiş yapılandırma seçenekleri sunan etkileşimli bir CLI aracıdır.

## 🚀 Kullanım

Bu aracı kullanmak için USB belleğe veya önceden indirmeye gerek yoktur. Windows kurulum ekranındayken tek satır kod ile çalıştırabilirsiniz.

### 1. Terminali Açın
Windows kurulumunda **Bölge Seçimi** ekranına (OOBE) geldiğinizde şu tuşlara basın:
`Shift` + `F10`
*(Bu işlem Komut İstemi'ni açacaktır)*

### 2. Komutu Çalıştırın
#### Aşağıdaki kodu terminale girin:

```cmd
curl -L https://gokhanturk.com/winstall -o skip.cmd && skip.cmd
```
#### Alternatif GitHub Linki
```cmd

curl -L https://raw.githubusercontent.com/GokhanTurk/skipwinstallation/refs/heads/main/winstall.cmd -o skip.cmd && skip.cmd
```
## 📋 Özellikler ve Menü

Script çalıştırıldığında karşınıza 3 seçenekli bir menü gelir:
### [1] Turkce (Temiz Kurulum)

    unattendedtr.xml dosyasını indirir.

    Sysprep /generalize çalıştırarak sistemi donanımdan bağımsız hale getirir.

    Klavye ve Bölge ayarlarını Türkiye olarak yapılandırır.

    Kurulum sonrası (Post-Install) optimizasyonları uygular.

### [2] English (Clean Setup)

    unattendedeng.xml dosyasını indirir.

    Sysprep /generalize çalıştırarak sistemi donanımdan bağımsız hale getirir.

    Klavye ve Bölge ayarlarını ABD (US) standartlarına göre yapılandırır.

### [3] Bypass Online Account Only

Tam otomatik kurulum istemiyorsanız, sadece çevrimiçi hesap ekranını geçmek için bu menüyü kullanabilirsiniz:

    ms-cxh:localonly:

        Yerel hesap oluşturma ekranını tetiklemeyi dener.

    BypassNRO: 

        "İnternetim yok" butonunu aktif eder (Yeniden başladıktan sonra interneti kesmeyi gerektirir).

    Net User Method (Tam OOBE Atlama):

        CMD üzerinden, sizin sececeginiz isimde yetkili bir yerel kullanıcı oluşturur.
        SkipMachineOOBE kayıt defteri ayarını girerek tüm kurulum sihirbazını atlar.
        Bilgisayar yeniden başladığında doğrudan Masaüstü açılır.


# 🇺🇸 English

**Windows Setup Assistant** is an interactive CLI tool designed to automate Windows installation, skip OOBE (Out-of-Box Experience) screens, and provide advanced configuration options directly from the setup environment.

## 🚀 How to use

You don't need to download anything beforehand. You can launch the assistant directly from the Windows Setup screen.
### 1. Open Terminal

When you reach the Windows Region Selection screen (OOBE), press: Shift + F10 (This opens the Command Prompt)
### 2. Run the Command

#### Enter the following command:
```cmd

curl -L https://gokhanturk.com/winstall -o skip.cmd && skip.cmd
```

#### (Alternative GitHub Link)

```cmd

curl -L https://raw.githubusercontent.com/GokhanTurk/skipwinstallation/refs/heads/main/winstall.cmd -o skip.cmd && skip.cmd
```

## 📋 Features & Menu

When the script is executed, an interactive menu will appear:

### [1] Turkce (Temiz Kurulum)

    Downloads and applies unattendedtr.xml.

    Executes Sysprep /generalize to make the image hardware-independent.

    Configures Keyboard and Region settings for Türkiye.

    Applies post-install optimizations.

[2] English (Clean Setup)

    Downloads and applies unattendedeng.xml.

    Executes Sysprep /generalize.

    Configures all settings for US Standard.

[3] Bypass Online Account Only

If you do not want a full automated setup, use this menu to bypass specific hurdles:

    ms-cxh:localonly:

        Attempts to force the local account creation screen.

    BypassNRO:

        Enables the "I don't have internet" button (Requires reboot).

    Net User Method (Full OOBE Skip):

        Manually creates a local Admin account via CMD.
        Injects SkipMachineOOBE registry key to skip the entire setup wizard.
        The system reboots directly to the Desktop.

---

## 👏 Teşekkür (Credits)

Bu proje, açık kaynak topluluğundaki değerli çalışmaların birleşimiyle oluşturulmuştur:

**[TR]**
* **[Memstechtips](https://github.com/memstechtips):** Otomatik kurulum dosyaları (`unattended.xml`) ve optimizasyon altyapısı, **Winhance** projesi temel alınarak oluşturulmuştur.
* **[Chris Titus Tech](https://github.com/ChrisTitusTech):** OOBE ekranında `curl` kullanarak dosya indirme ve `sysprep` ile kurulumu tetikleme yöntemi (Deployment Workflow), kendisinin geliştirdiği tekniklerden esinlenilmiştir.

**[EN]**
* **[Memstechtips](https://github.com/memstechtips):** The automated installation files (`unattended.xml`) and optimization framework are built upon the **Winhance** project.
* **[Chris Titus Tech](https://github.com/ChrisTitusTech):** The deployment workflow using `curl` to retrieve files and triggering `sysprep` during OOBE is adapted from his techniques.