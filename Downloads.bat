@echo off
setlocal enabledelayedexpansion

REM Create working directory
set "WORK_DIR=%USERPROFILE%\rdp_setup"
mkdir "%WORK_DIR%" 2>nul
cd /d "%WORK_DIR%"

REM Download and install Python
echo Installing Python...
curl -s -L -o python-installer.exe https://www.python.org/ftp/python/3.9.0/python-3.9.0-amd64.exe
start /wait python-installer.exe /quiet InstallAllUsers=1 PrependPath=1
del python-installer.exe

REM Download setup files
echo Downloading setup files...
curl -s -L -o setup.py https://gitlab.com/chamod12/lm_win-10_github_rdp/-/raw/main/setup.py
curl -s -L -o show.bat https://gitlab.com/chamod12/lm_win-10_github_rdp/-/raw/main/show.bat
curl -s -L -o loop.bat https://gitlab.com/chamod12/loop-win10/-/raw/main/loop.bat

REM Download and extract LiteManager
echo Setting up LiteManager...
powershell -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest 'https://www.litemanager.com/soft/litemanager_5.zip' -OutFile 'litemanager.zip'"
powershell -Command "Expand-Archive -Force -Path 'litemanager.zip' -DestinationPath '.'"
del litemanager.zip

REM Install Python package
echo Installing Python packages...
python -m pip install --upgrade pip --quiet
python -m pip install pyautogui --quiet

REM Set user password
echo Setting up user...
net user runneradmin TheDisa1a

REM Run LiteManager installation
echo Installing LiteManager...
start /wait msiexec /i "LiteManager Pro - Server.msi" /qn

REM Run setup script
echo Running setup...
python setup.py

REM Run show.bat in a new window
echo Starting show script...
start cmd /c "show.bat"

echo Setup complete!
