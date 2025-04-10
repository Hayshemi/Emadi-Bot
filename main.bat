@echo off
setlocal enableextensions enabledelayedexpansion
>nul chcp 65001
title Emadi Bot -  by Hayshemi
goto start 

:start
cls
call :banner
pause

:banner
echo.
echo.
echo                             [38;2;255;0;0m███████╗███╗   ███╗ █████╗ ██████╗ ██╗    ██████╗  ██████╗ ████████╗[0m
echo                             [38;2;255;51;0m██╔════╝████╗ ████║██╔══██╗██╔══██╗██║    ██╔══██╗██╔═══██╗╚══██╔══╝[0m
echo                             [38;2;255;102;0m█████╗  ██╔████╔██║███████║██║  ██║██║    ██████╔╝██║   ██║   ██║   [0m
echo                             [38;2;255;153;0m██╔══╝  ██║╚██╔╝██║██╔══██║██║  ██║██║    ██╔══██╗██║   ██║   ██║   [0m
echo                             [38;2;255;204;0m███████╗██║ ╚═╝ ██║██║  ██║██████╔╝██║    ██████╔╝╚██████╔╝   ██║  [0m 
echo                             [38;2;255;255;0m╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝    ╚═════╝  ╚═════╝    ╚═╝[0m
echo.

:menu
echo.
echo [38;2;255;0;0m║[0m
echo [38;2;255;0;0m╚═╦══[1] Check One token[0m
echo   [38;2;255;0;0m║[0m
echo   [38;2;255;51;0m╚═╦══[2] Check multiple tokens in txt file (.txt)[0m
echo     [38;2;255;51;0m║[0m
echo     [38;2;255;51;0m╚═╦══[3] Delete webhook [0m
echo       [38;2;255;153;0m║[0m
echo       [38;2;255;153;0m╚═╦══[4] Spam webhook[0m
echo         [38;2;255;153;0m║[0m
echo         [38;2;255;204;0m╚═╦══[5] GitHub[0m
echo           [38;2;255;204;0m║[0m
echo           [38;2;255;204;0m╚═╦══[6] Exit  [0m
echo             [38;2;255;255;0m║[0m
set /p input=".           [38;2;255;255;0m╚═════>>[0m"

if "%input%" == "5" cls & goto github
if "%input%" == "4" cls & goto spam
if "%input%" == "3" cls & goto delete
if "%input%" == "6" exit
if "%input%" == "2" cls & goto multicheck
if "%input%" == "1" (cls & goto check
) else (cls & goto start)

rem Single Token Checker
:check
set /p token="Your token: "
cls
for /F %%I in ('curl --silent -H "Content-Type: application/json" -H "Authorization: %token%" https://discord.com/api/v9/users/@me/library') do set ValidToken=%%I
	if NOT %ValidToken%=={"message": (
		color 2 & echo Token is either valid or locked :/
		curl --silent -H "Content-Type: application/json" -H "Authorization: %token%" https://discordapp.com/api/v9/users/@me >> tokeninfo.json
		echo. >> tokeninfo.json
		echo.
		echo Saved token info in tokeninfo.json
	) else (
		color 4 & echo Token is invalid!
	)

set /P c="Do you want to check another token [Y/N]? "
if /I "%c%" EQU "Y" color 7 & cls & goto check
if /I "%c%" EQU "N" (
color 7 & cls & goto start
)
else (
color 7 && cls & goto start
)

rem Mass Check Tokens | Broken for now . _.
:multicheck
set /p pathTokens="Path to tokens (*.txt): "
if not exist %pathTokens% cls && echo File not found && timeout 5 && cls & goto start
for /F "usebackq tokens=*" %%A in ("%pathTokens%") do (
	for /F %%I in ('curl --silent -H "Content-Type: application/json" -H "Authorization: %%A" https://discord.com/api/v9/users/@me/library') do set ValidTokens=%%I
		if NOT "%ValidTokens%"=="{""message"":" (
		echo "[Valid | Locked] %%A"
		curl --silent -H "Content-Type: application/json" -H "Authorization: %%A" https://discordapp.com/api/v9/users/@me >> tokeninfo.json
		echo. >> tokeninfo.json
		) else (
			echo "[Invalid] %%A"
		)
	)
echo Valid token are saved in "tokeninfo.json" (if any).

set /P idk="Do you want to return to main screen [Y/N]? "
if /I "%idk%" EQU "Y" cls & goto start
if /I "%idk%" EQU "N" cls & goto mutlicheck
else cls & goto start

rem Mass Delete Webhook
:delete
echo [SPACE] between each webhook to delete multiple webhooks.
set /p input="Enter webhook: "
CURL -X "DELETE" %input%

set /P idk="Do you want to return to main screen [Y/N]? "
if /I "%idk%" EQU "Y" cls & goto start
if /I "%idk%" EQU "N" cls & goto delete
else color 7 & cls & goto start

rem Webhook Spammer
:spam
set /p webhook="Enter Webhook: "
cls
set /p username="Enter Username: "
cls
set /p message="Enter Message: "
cls
set /p amount="Enter amount of times to spam: [x = Unlimited] "
rem No Limit Spammer
if "%amount%"=="x" (
:UnlimitedSpam
curl -d "content=%message%" -d "username=%username%" -X POST %webhook%
goto UnlimitedSpam
)
for /l %%a in (1, 1, %amount%) do (
curl -d "content=%message%" -d "username=%username%" -X POST %webhook%
cls
echo Message sent %%a times
)
echo.

set /P idk=Do you want to return to main screen [Y/N]? 
if /I "%idk%" EQU "Y" cls & goto start
if /I "%idk%" EQU "N" cls & goto spam
else cls & goto start

rem Open GitHub
:github
echo Opening GitHub...
start "" "https://github.com/hayshemi"
cls & goto start
