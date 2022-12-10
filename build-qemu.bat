@ECHO off
SET TOOL_CHAIN=VS2019

SET WORKSPACE=%CD%
SET PACKAGES_PATH=%WORKSPACE%\edk2;%WORKSPACE%\edk2-libc
SET NASM_PREFIX=%WORKSPACE%\nasm-2.15.05\
SET IASL_PREFIX=%WORKSPACE%\ASL\

chcp 437
call EDK2\edksetup.bat rebuild %TOOL_CHAIN%
build --silent --arch IA32 --arch X64 --platform OvmfPkg/OvmfPkgIa32X64.dsc --buildtarget DEBUG --tagname %TOOL_CHAIN% -n 8 --define DEBUG_ON_SERIAL_PORT --define SECURE_BOOT_ENABLE=TRUE --define SMM_REQUIRE=TRUE --log=build.txt
