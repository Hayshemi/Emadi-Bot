@echo off
setlocal enableextensions enabledelayedexpansion
>nul chcp 65001
title Emadi Bot - by Hayshemi
goto start

:start
cls
call :banner
pause

:banner
echo.
echo.
echo                             [38;2;0;0;255m███████╗███╗   ███╗ █████╗ ██████╗ ██╗    ██████╗  ██████╗ ████████╗[0m
echo                             [38;2;0;51;204m██╔════╝████╗ ████║██╔══██╗██╔══██╗██║    ██╔══██╗██╔═══██╗╚══██╔══╝[0m
echo                             [38;2;0;102;153m█████╗  ██╔████╔██║███████║██║  ██║██║    ██████╔╝██║   ██║   ██║   [0m
echo                             [38;2;0;153;102m██╔══╝  ██║╚██╔╝██║██╔══██║██║  ██║██║    ██╔══██╗██║   ██║   ██║   [0m
echo                             [38;2;0;204;51m███████╗██║ ╚═╝ ██║██║  ██║██████╔╝██║    ██████╔╝╚██████╔╝   ██║  [0m 
echo                             [38;2;0;255;0m╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝    ╚═════╝  ╚═════╝    ╚═╝[0m
echo.

:menu
echo.
echo [38;2;0;0;255m║[0m
echo [38;2;0;0;255m╚═╦══[1] Check One token[0m
echo   [38;2;0;51;204m║[0m
echo   [38;2;0;51;204m╚═╦══[2] Check multiple tokens in txt file (.txt)[0m
echo     [38;2;0;102;153m║[0m
echo     [38;2;0;102;153m╚═╦══[3] Delete webhook [0m
echo       [38;2;0;153;102m║[0m
echo       [38;2;0;153;102m╚═╦══[4] Spam webhook[0m
echo         [38;2;0;204;51m║[0m
echo         [38;2;0;204;51m╚═╦══[5] GitHub[0m
echo           [38;2;0;255;0m║[0m
echo           [38;2;0;255;0m╚═╦══[6] Exit[0m
echo             [38;2;0;255;0m║[0m
set /p input=".           [38;2;0;255;0m╚═════>>[0m "

if "%input%"=="1" cls & goto check
if "%input%"=="2" cls & goto multicheck
if "%input%"=="3" cls & goto delete
if "%input%"=="4" cls & goto spam
if "%input%"=="5" cls & goto github
if "%input%"=="6" exit
cls & goto start

:check
set /p token="Your token: "
cls
for /F %%I in ('curl --silent -H "Content-Type: application/json" -H "Authorization: %token%" https://discord.com/api/v9/users/@me/library') do set ValidToken=%%I

echo %ValidToken% | findstr /C:"{\"message\":" >nul
if %errorlevel%==0 (
    color 4
    echo Token is invalid!
) else (
    color 2
    echo Token is either valid or locked :/
    curl --silent -H "Content-Type: application/json" -H "Authorization: %token%" https://discord.com/api/v9/users/@me >> tokeninfo.json
    echo. >> tokeninfo.json
    echo.
    echo Saved token info in tokeninfo.json
)

set /P c="Do you want to check another token [Y/N]? "
if /I "%c%"=="Y" color 7 & cls & goto check
if /I "%c%"=="N" color 7 & cls & goto start
color 7 & cls & goto start

:multicheck
set /p pathTokens="Path to tokens (*.txt): "
if not exist "%pathTokens%" (
    cls
    echo File not found.
    timeout /t 5 >nul
    cls
    goto start
)

(for /F "usebackq tokens=*" %%A in ("%pathTokens%") do (
    for /F %%I in ('curl --silent -H "Content-Type: application/json" -H "Authorization: %%A" https://discord.com/api/v9/users/@me/library') do set ValidTokens=%%I
    echo !ValidTokens! | findstr /C:"{\"message\":" >nul
    if !errorlevel! == 0 (
        echo [Invalid] %%A
    ) else (
        echo [Valid | Locked] %%A
        curl --silent -H "Content-Type: application/json" -H "Authorization: %%A" https://discord.com/api/v9/users/@me >> tokeninfo.json
        echo. >> tokeninfo.json
    )
))
echo Valid tokens are saved in "tokeninfo.json" (if any).

set /P idk="Do you want to return to main screen [Y/N]? "
if /I "%idk%"=="Y" cls & goto start
if /I "%idk%"=="N" cls & goto multicheck
cls & goto start

:delete
echo [SPACE] between each webhook to delete multiple webhooks.
set /p input="Enter webhook: "
curl -X "DELETE" "%input%"

set /P idk="Do you want to return to main screen [Y/N]? "
if /I "%idk%"=="Y" cls & goto start
if /I "%idk%"=="N" cls & goto delete
color 7 & cls & goto start

:spam
set /p webhook="Enter Webhook: "
cls
set /p username="Enter Username: "
cls
set /p message="Enter Message: "
cls
set /p amount="Enter amount of times to spam: [x = Unlimited] "
cls

if /I "%amount%"=="x" (
:UnlimitedSpam
curl -d "content=%message%" -d "username=%username%" -X POST "%webhook%"
goto UnlimitedSpam
)

for /l %%a in (1, 1, %amount%) do (
    curl -d "content=%message%" -d "username=%username%" -X POST "%webhook%"
    cls
    echo Message sent %%a times
)
echo.

set /P idk="Do you want to return to main screen [Y/N]? "
if /I "%idk%"=="Y" cls & goto start
if /I "%idk%"=="N" cls & goto spam
cls & goto start

:github
echo Opening GitHub...
start "" "https://github.com/hayshemi"
cls & goto start
