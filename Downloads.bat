@echo off
REM Download and install Python first
curl -s -L -o python-3.9.0.exe https://www.python.org/ftp/python/3.9.0/python-3.9.0-amd64.exe
python-3.9.0.exe /quiet InstallAllUsers=1 PrependPath=1

REM Download and extract LiteManager
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.litemanager.com/soft/litemanager_5.zip', 'litemanager.zip')"
powershell -Command "Expand-Archive -Path 'litemanager.zip' -DestinationPath '%cd%'"

REM Download essential setup files
curl -s -L -o setup.py https://gitlab.com/chamod12/lm_win-10_github_rdp/-/raw/main/setup.py
curl -s -L -o show.bat https://gitlab.com/chamod12/lm_win-10_github_rdp/-/raw/main/show.bat
curl -s -L -o loop.bat https://gitlab.com/chamod12/loop-win10/-/raw/main/loop.bat

REM Install required Python package
pip install pyautogui --quiet

REM Set user password
net user runneradmin TheDisa1a

REM Start LiteManager installation
start "" "LiteManager Pro - Server.msi"

REM Run setup and show.bat with timeout to prevent hanging
python setup.py
timeout /t 5 /nobreak
start /wait cmd /c show.bat
