@ECHO OFF

..\..\..\tools\asw\bin\asw -cpu z80undoc -U -L make_micro_boot_fat.a80
IF %ERRORLEVEL% EQU 1 GOTO ERROR
..\..\..\tools\asw\bin\p2bin make_micro_boot_fat.p micro_boot_fat.rom -r $-$ -k

..\..\..\tools\asw\bin\asw -cpu z80undoc -U -L make_main.a80
IF %ERRORLEVEL% EQU 1 GOTO ERROR
..\..\..\tools\asw\bin\p2bin make_main.p main.rom -r $-$ -k

..\..\..\tools\asw\bin\asw -cpu z80undoc -U -L make_cmosset.a80
IF %ERRORLEVEL% EQU 1 GOTO ERROR
..\..\..\tools\asw\bin\p2bin make_cmosset.p cmosset.rom -r $-$ -k

rem ..\..\..\tools\sjasmplus\sjasmplus --sym=sym.log --lst=dump.log -isrc make_micro_boot_fat.a80
rem ..\..\..\tools\sjasmplus\sjasmplus --sym=sym.log --lst=dump.log -isrc make_main.a80
rem ..\..\..\tools\sjasmplus\sjasmplus --sym=sym.log --lst=dump.log -isrc make_cmosset.a80

..\..\..\tools\mhmt\mhmt -mlz main.rom main_pack.rom
..\..\..\tools\mhmt\mhmt -mlz cmosset.rom cmosset_pack.rom
..\..\..\tools\mhmt\mhmt -mlz altstd.bin chars_pack.bin

..\..\..\tools\asw\bin\asw -cpu z80undoc -U -L make_all_services.a80
IF %ERRORLEVEL% EQU 1 GOTO ERROR
..\..\..\tools\asw\bin\p2bin make_all_services.p ../services.rom -r $-$ -k

rem ..\..\..\tools\sjasmplus\sjasmplus --sym=sym.log --lst=dump.log -isrc make_all_services.a80

del micro_boot_fat.rom
REM del micro_boot_fat_pack.rom
del main.rom
del cmosset.rom

del main_pack.rom
del cmosset_pack.rom

copy /B /Y ..\services.rom %zx_emul_ROM%\service_kay.rom
rem copy /B /Y ..\services.rom H:\install\zx\US0374\service_kay.rom
rem copy /B /Y ..\services.rom H:\install\zx\TST_GLUCK\service_kay.rom

rem copy /B /Y ..\services.rom D:\install\zx\US0374\service_kay.rom
GOTO DONE

:ERROR
ECHO See log for assembling errors!
pause
exit

:DONE
ECHO Done! 
pause
