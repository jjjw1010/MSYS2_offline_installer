@echo off

REM ==================================================
REM Loop over each line in _pkg_list.txt and run pacman -Sgq
REM ==================================================

set "MSYSBASH=C:\msys64\usr\bin\bash.exe"

set "CURRENT_DIR=%CD%"
set "META_PKG_LIST=%~dp0_pkg_list.txt"
set "EXPANDED_META_OUTFILE=%~dp0expanded_meta_pkgs.txt"
set "PKG_LIST_FILE=%~dp0all_pkg_list.txt"
set "DEST_PKG=%~dp0..\install_pkg\basic_packages"

REM =================================================
REM PREQ
REM =================================================
if not exist "%DEST_PKG%" (
    echo Creating destination package directory: %DEST_PKG%
    mkdir "%DEST_PKG%"
)

if not exist %META_PKG_LIST% (
    echo %META_PKG_LIST% not found!
    exit /b 1
)

if exist "%EXPANDED_META_OUTFILE%" del "%EXPANDED_META_OUTFILE%"
if exist "%PKG_LIST_FILE%" del "%PKG_LIST_FILE%"

REM Download packages to get pactree working
%MSYSBASH% -lc "pacman -S --noconfirm --needed - < \"$(cygpath '%META_PKG_LIST%')\""


for /f "usebackq delims=" %%G in (%META_PKG_LIST%) do (
    REM Test if %%G is a group
    %MSYSBASH% -lc "pactree -u '%%G' >/dev/null 2>&1"
    if errorlevel 1 (
        REM It's a group
        echo Expanding group %%G ...
        %MSYSBASH% -lc "pacman -Sgq '%%G'" >> "%EXPANDED_META_OUTFILE%"
    ) else (
        REM It's a package
        echo Getting dependencies for package %%G ...
        %MSYSBASH% -lc "pactree -u '%%G'" >> "%PKG_LIST_FILE%"
    )
)

echo Expansion complete. See %EXPANDED_META_OUTFILE% for results.
for /f "usebackq delims=" %%M in ("%EXPANDED_META_OUTFILE%") do (
    echo Finding dependencies for: '%%M'
    %MSYSBASH% -lc "pactree -u '%%M'" >> "%PKG_LIST_FILE%"
)

echo Dependency resolution complete. See %PKG_LIST_FILE% for results.

%MSYSBASH% -lc "pacman -Sw --noconfirm --cachedir \"$(cygpath '%DEST_PKG%')\" - < \"$(cygpath '%PKG_LIST_FILE%')\""