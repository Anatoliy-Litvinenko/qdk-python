@echo off

if '%1'=='/?' goto help
if '%1'=='-help' goto help
if '%1'=='-h' goto help

pwsh -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "& '%~dp0\build\build.ps1' %*"
exit /B %errorlevel%

:help
pwsh -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "& '%~dp0\build\build.ps1' -help"
