@echo off
chcp 65001 >nul
title GameShop - Lancement de l'installation
color 0A

echo ===========================================================
echo              🕹️  GameShop - Lancement
echo ===========================================================
echo.

:: 📁 Création du dossier local
set "BASEDIR=%~dp0"
set "INSTALL_DIR=%BASEDIR%GameShopInstallerV3.2"
if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
)
cd /d "%INSTALL_DIR%"
echo [INFO] Dossier d'installation : %INSTALL_DIR%
echo.

:: 🌐 URLs GitHub RAW
set "PAGE_URL=https://raw.githubusercontent.com/lpatitouandelaunay-cmyk/GameShopconnect/main/connecterGameShop.html"
set "INSTALLER_URL=https://raw.githubusercontent.com/lpatitouandelaunay-cmyk/GameShopconnect/main/GameShopinstallV3.2_2.bat"

:: 📄 Fichiers locaux
set "PAGE_FILE=%INSTALL_DIR%\connecterGameShop.html"
set "INSTALLER_FILE=%INSTALL_DIR%\GameShopinstallV3.2_2.bat"

:: 📥 Téléchargement de la page HTML
echo [INFO] Téléchargement de la page de connexion...
powershell -Command "Invoke-WebRequest -Uri '%PAGE_URL%' -OutFile '%PAGE_FILE%'"

if not exist "%PAGE_FILE%" (
    echo ❌ Erreur : la page HTML n'a pas été téléchargée.
    pause
    exit /b
)

echo ✅ Page téléchargée : %PAGE_FILE%
echo 🌐 Ouverture dans le navigateur...
start "" "%PAGE_FILE%"
echo.

:: 📌 Instructions pour l'utilisateur
echo ------------------------------------------------------------
echo 1️⃣  Utilise la page ouverte pour générer ta clé GameShop.
echo 2️⃣  Télécharge les fichiers :
echo       - key.txt
echo       - expected_hash.txt
echo.
echo 3️⃣  Ce script va maintenant télécharger le programme principal.
echo ------------------------------------------------------------
echo.
pause

:: 📥 Téléchargement du script d'installation
echo [INFO] Téléchargement de GameShopinstallV3.2_2.bat...
powershell -Command "Invoke-WebRequest -Uri '%INSTALLER_URL%' -OutFile '%INSTALLER_FILE%'"

if exist "%INSTALLER_FILE%" (
    echo ✅ Script téléchargé : %INSTALLER_FILE%
    echo 🚀 Tu peux maintenant lancer ce fichier pour continuer l'installation.
) else (
    echo ❌ Erreur : le script n'a pas pu être téléchargé.
    pause
    exit /b
)

echo.
pause
exit
