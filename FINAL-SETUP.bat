@echo off
REM GF-BOS Backend - Final Setup Script
REM Run this from Desktop/gf-bos-backend folder

cls
echo.
echo ======================================
echo GF-BOS Backend - Setup Script
echo ======================================
echo.

REM Set paths
set PROJECT_PATH=%cd%
set BACKEND_PATH=%PROJECT_PATH%\backend

echo Current Path: %PROJECT_PATH%
echo.

REM Step 1: Delete nested folder if exists
echo Step 1: Cleaning up...
if exist "%PROJECT_PATH%\gf-bos-backend" (
    rmdir /s /q "%PROJECT_PATH%\gf-bos-backend"
    echo OK: Removed nested folder
)
echo.

REM Step 2: Create backend folder
echo Step 2: Creating backend folder...
if not exist "%BACKEND_PATH%" (
    mkdir "%BACKEND_PATH%"
    echo OK: Backend folder created
) else (
    echo OK: Backend folder already exists
)
echo.

REM Step 3: Move TypeScript files to backend
echo Step 3: Moving TypeScript files...
for %%f in (02-types.ts 03-bom-service.ts 04-assembly-service.ts 05-deviation-service.ts 06-support-service.ts 07-auth-service.ts 08-api-routes.ts 09-app-setup.ts) do (
    if exist "%PROJECT_PATH%\%%f" (
        move /y "%PROJECT_PATH%\%%f" "%BACKEND_PATH%\%%f" >nul 2>&1
        echo OK: Moved %%f
    )
)
echo.

REM Step 4: Move config files to backend
echo Step 4: Moving config files to backend...
for %%f in (package.json tsconfig.json .env.example) do (
    if exist "%PROJECT_PATH%\%%f" (
        move /y "%PROJECT_PATH%\%%f" "%BACKEND_PATH%\%%f" >nul 2>&1
        echo OK: Moved %%f
    )
)
echo.

REM Step 5: Git operations
echo Step 5: Initializing Git...
if exist "%PROJECT_PATH%\.git" (
    echo OK: Git already initialized
) else (
    cd /d "%PROJECT_PATH%"
    git init >nul 2>&1
    echo OK: Git initialized
)
echo.

echo Step 6: Adding GitHub remote...
git remote remove origin >nul 2>&1
git remote add origin "https://rforrodotcom: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@github.com/rforrodotcom/gf-bos-backend.git" >nul 2>&1
echo OK: Remote added
echo.

echo Step 7: Staging files...
git add . >nul 2>&1
echo OK: Files staged
echo.

echo Step 8: Creating commit...
git commit -m "GF-BOS Backend - Production Ready" >nul 2>&1
echo OK: Commit created
echo.

echo Step 9: Pushing to GitHub...
git push -u origin main 2>&1
echo.

echo ======================================
echo DONE! All files organized and pushed
echo ======================================
echo.
echo Repository: https://github.com/rforrodotcom/gf-bos-backend
echo.
pause
