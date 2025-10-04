@echo off
setlocal

:: ============================
:: CONFIGURATION
:: ============================
set "URL=https://github.com/lpatitouandelaunay-cmyk/GameShop/raw/main/GameShopV3.1.zip"
set "DOWNLOAD_DIR=%TEMP%\GameShop_Download"
set "ZIP_FILE=%DOWNLOAD_DIR%\GameShopV3.1.zip"
set "EXTRACT_DIR=%DOWNLOAD_DIR%\extracted"
set "INSTALL_DIR=%USERPROFILE%\Documents\Jeux\GameShop"
set "DESKTOP=%USERPROFILE%\Desktop"

:: ============================
:: PRÉPARATION
:: ============================
echo [INFO] Préparation du dossier temporaire...
if exist "%DOWNLOAD_DIR%" rd /s /q "%DOWNLOAD_DIR%"
mkdir "%DOWNLOAD_DIR%"
cd /d "%DOWNLOAD_DIR%"

echo [INFO] Création du dossier d’installation...
if not exist "%USERPROFILE%\Documents\Jeux" mkdir "%USERPROFILE%\Documents\Jeux"
if exist "%INSTALL_DIR%" rd /s /q "%INSTALL_DIR%"
mkdir "%INSTALL_DIR%"

:: ============================
:: TÉLÉCHARGEMENT
:: ============================
echo [INFO] Téléchargement de GameShopV3.1.zip...
curl -L -o "%ZIP_FILE%" "%URL%"

if not exist "%ZIP_FILE%" (
    echo [ERREUR] Téléchargement échoué.
    pause
    exit /b
)

:: ============================
:: EXTRACTION
:: ============================
echo [INFO] Extraction du fichier ZIP...
powershell -command "Expand-Archive -Force '%ZIP_FILE%' '%EXTRACT_DIR%'"

if not exist "%EXTRACT_DIR%" (
    echo [ERREUR] L’extraction a échoué.
    pause
    exit /b
)

:: ============================
:: INSTALLATION
:: ============================
echo [INFO] Installation du jeu dans Documents\Jeux\GameShop...
xcopy "%EXTRACT_DIR%\*" "%INSTALL_DIR%\" /E /I /Y >nul

:: ============================
:: DÉPLACEMENT DU RACCOURCI
:: ============================
echo [INFO] Recherche du raccourci (.lnk)...
set "foundLnk=0"

for /r "%INSTALL_DIR%" %%f in (*.lnk) do (
    echo [INFO] Raccourci trouvé : %%~nxf
    copy "%%f" "%DESKTOP%" >nul
    set "foundLnk=1"
)

:: ============================
:: CONFIRMATION
:: ============================
if "%foundLnk%"=="0" (
    echo [AVERTISSEMENT] Aucun raccourci trouvé dans le zip.
)

:: Message pop-up simple avec PowerShell
powershell -Command ^
  "[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null; ^
  [System.Windows.Forms.MessageBox]::Show('Le téléchargement et l’installation de GameShop sont terminés avec succès !','Installation réussie',[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)"

echo ✅ Installation terminée !
pause
exit /b
