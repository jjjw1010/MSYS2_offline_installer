==================================================
    Installing MSYS2 in an Offline Machine
==================================================

What is MSYS2?
--------------
MSYS2 is a collection of tools and libraries providing you with an easy-to-use
environment for building, installing, and running native Windows software.

For more information go to: www.msys2.org


Getting pkg from online machine
-------------------------------
1.  To retrieve other packages go to:
        www.packages.msys2.org/packages/

2.  Place the package name under the following to get the deps as well:
        get/get_pkg/_pkg_list.txt
    
3.  Run get_pkg.bat

Getting installer from online machine
-------------------------------------
1. Go to https://www.msys2.org/ to get the latest installer
2. Place the installer under the folder installer

Installing pkg in offline machine
---------------------------------
1. Run the installer/msys2-x86_64-20250830.exe
2. Run install_packages.bat

Current pkgs included
---------------------

Current Packages Included 
-------------------------
mingw-w64-ucrt-x86_64-toolchain (mingw32-make)
compression (7z)
VCS
editors
xorriso
mingw-w64-ucrt-x86_64-nsis (makensis)