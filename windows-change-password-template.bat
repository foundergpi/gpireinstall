@echo off
setlocal enabledelayedexpansion
echo [Password Script] Starting password change...
timeout /t 30 /nobreak >nul
echo [Password Script] Changing Administrator password...

REM Set password - gunakan quotes untuk handle special characters
net user Administrator "PASSWORD_PLACEHOLDER" >nul 2>&1
if %errorlevel% equ 0 (
    echo [Password Script] Password changed successfully
) else (
    echo [Password Script] Failed to change password, error code: %errorlevel%
    echo [Password Script] Trying alternative method...
    wmic useraccount where name="Administrator" set password="PASSWORD_PLACEHOLDER" >nul 2>&1
)

net user Administrator /active:yes >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 0 /f >nul 2>&1
echo [Password Script] Cleaning up...
del "%~f0" >nul 2>&1

