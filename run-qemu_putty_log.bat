@ECHO off
IF NOT EXIST tools mkdir tools

set QEMU_PARS=-name "Debugger"
set QEMU_PARS=%QEMU_PARS% -drive file=Build/Ovmf3264/DEBUG_VS2019/FV/OVMF_CODE.fd,if=pflash,format=raw,unit=0,readonly=on
set QEMU_PARS=%QEMU_PARS% -drive file=Build/Ovmf3264/DEBUG_VS2019/FV/OVMF_VARS.fd,if=pflash,format=raw,unit=1
set QEMU_PARS=%QEMU_PARS% -drive file=fat:rw:tools/,media=disk,if=virtio,format=raw 
set QEMU_PARS=%QEMU_PARS% -m 512
set QEMU_PARS=%QEMU_PARS% -machine q35,smm=on
set QEMU_PARS=%QEMU_PARS% -nodefaults
set QEMU_PARS=%QEMU_PARS% -vga std
set QEMU_PARS=%QEMU_PARS% -global driver=cfi.pflash01,property=secure,value=on 
set QEMU_PARS=%QEMU_PARS% -global ICH9-LPC.disable_s3=1
set QEMU_PARS=%QEMU_PARS% -monitor tcp:localhost:20717,server
set QEMU_PARS=%QEMU_PARS% -serial  tcp:localhost:20715,server

timeout /t 1

start "Monitor" /B "putty\putty.exe" telnet://localhost:20717
start "Console" /B "putty\putty.exe" telnet://localhost:20715
"C:\Program Files\qemu\qemu-system-x86_64.exe" %QEMU_PARS%