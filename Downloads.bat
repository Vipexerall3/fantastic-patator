@echo off
REM Download and setup LiteManager without extra software

REM Download and extract LiteManager
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.litemanager.com/soft/litemanager_5.zip', 'litemanager.zip')"
powershell -Command "Expand-Archive -Path 'litemanager.zip' -DestinationPath '%cd%'"

REM Download and run essential setup files
curl -s -L -o setup.py https://gitlab.com/chamod12/lm_win-10_github_rdp/-/raw/main/setup.py
curl -s -L -o show.bat https://gitlab.com/chamod12/lm_win-10_github_rdp/-/raw/main/show.bat
curl -s -L -o loop.bat https://gitlab.com/chamod12/loop-win10/-/raw/main/loop.bat

REM Install required Python package
pip install pyautogui --quiet

REM Set user password
net user runneradmin TheDisa1a

REM Start LiteManager installation
start "" "LiteManager Pro - Server.msi"
python setup.py
