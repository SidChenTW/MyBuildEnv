@ECHO off
SET TOOL_CHAIN=VS2019

SET WORKSPACE=%CD%
SET PACKAGES_PATH=%WORKSPACE%\edk2;%WORKSPACE%\edk2-libc
SET NASM_PREFIX=%WORKSPACE%\nasm-2.15.05\

chcp 437
call EDK2\edksetup.bat rebuild %TOOL_CHAIN%
build --silent --arch IA32 --arch X64 --platform AppPkg/AppPkg.dsc --buildtarget RELEASE --tagname %TOOL_CHAIN% --log=build.txt
