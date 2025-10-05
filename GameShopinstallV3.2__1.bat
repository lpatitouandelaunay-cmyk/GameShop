@echo off
chcp 65001 >nul
title GameShop - Préparation de l'installation
color 0A

echo ===========================================================
echo              🕹️  GameShop - Préparation
echo ===========================================================
echo.

:: Création du dossier d'installation local
set "BASEDIR=%~dp0"
set "INSTALL_DIR=%BASEDIR%installerGameShopV3.2"
if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
)
cd /d "%INSTALL_DIR%"
echo [INFO] Dossier d'installation créé :
echo        %INSTALL_DIR%
echo.

:: URL de la page de connexion et du deuxième .bat (version RAW sur GitHub)
set "PAGE_URL=https://raw.githubusercontent.com/lpatitouandelaunay-cmyk/GameShopconnect/main/connecterGameShop.html"
set "INSTALLER_URL=https://github.com/lpatitouandelaunay-cmyk/GameShopconnect/blob/main/GameShopinstallV3.2_2.bat"

set "PAGE_FILE=%INSTALL_DIR%\connecterGameShop.html"
set "INSTALLER_FILE=%INSTALL_DIR%\GameShopInstallerV3.2__2.bat"

echo [INFO] Téléchargement de la page de connexion depuis GitHub...
powershell -NoProfile -Command "Invoke-WebRequest -Uri '%PAGE_URL%' -OutFile '%PAGE_FILE%' -UseBasicParsing" 2>nul

if not exist "%PAGE_FILE%" (
    echo ❌ Erreur : la page de connexion n'a pas pu être téléchargée.
    echo Vérifie ta connexion Internet ou l'URL :
    echo    %PAGE_URL%
    pause
    exit /b 1
)

echo ✅ Page téléchargée : %PAGE_FILE%
echo 🌐 Ouverture de la page dans le navigateur...
start "" "%PAGE_FILE%"
echo.

:: Instructions
echo ------------------------------------------------------------
echo 1️⃣  Utilise la page ouverte pour générer ta clé GameShop.
echo 2️⃣  Télécharge les fichiers :
echo       - key.txt
echo       - expected_hash.txt
echo.
echo 3️⃣  Une fois que tu as les deux fichiers,
echo     ce script téléchargera l'installateur dans ce dossier :
echo       %INSTALL_DIR%
echo ------------------------------------------------------------
echo.

pause

echo [INFO] Téléchargement du deuxième script GameShopInstallerV3.2__2.bat ...
powershell -NoProfile -Command "Invoke-WebRequest -Uri '%INSTALLER_URL%' -OutFile '%INSTALLER_FILE%' -UseBasicParsing" 2>nul

if exist "%INSTALLER_FILE%" (
    echo ✅ Fichier téléchargé :
    echo    %INSTALLER_FILE%
    echo.
    echo Tu peux maintenant ouvrir ce fichier pour continuer l'installation.
) else (
    echo ❌ Erreur : impossible de télécharger GameShopInstallerV3.1__2.bat
    echo Vérifie ton accès à :
    echo    %INSTALLER_URL%
)

echo.
pause
exit /b
