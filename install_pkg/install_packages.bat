@echo off

:: After installing MSYS2 on Offline Machine
set "SRC_PKG=%CD%\basic_packages"
set "DEST_PKG=C:\msys64\var\cache\pacman\pkg"
set "DEST_CMD=C:\msys64\msys2_shell.cmd"

:: Check if the packages exist
if not exist "%SRC_PKG%" (
    echo WARNING: The 'packages' folder is missing at %CD%.
    echo Please make sure the folder exists and contains .pkg.tar.zst files.
    pause
    exit /b
)

:: Copy only new packages into DEST_PKG
for %%F in ("%SRC_PKG%\*.pkg.tar.zst") do (
    if not exist "%DEST_PKG%\%%~nxF" (
        echo Copying: %%~nxF
        copy "%%F" "%DEST_PKG%"
    ) else (
        echo File already exist : %%~nxF
    )
)

echo.
echo ===== Will now be installing new packages =====
echo.
pause

:: Install only new packages
cd %DEST_PKG%
"%DEST_CMD%" -ucrt64 -here -c  "pacman -U --noconfirm --needed *.zst"
