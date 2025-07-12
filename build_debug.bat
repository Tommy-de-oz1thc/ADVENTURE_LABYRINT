@echo off
chcp 65001 > nul
echo Kompilerer...

REM === Assemblerer alle .asm-filer ===
echo %CYAN%=== Assemblerer alle ASM-filer ===%RESET%
for %%f in (*.asm) do (
    echo Assemblerer %%f ...
    nasm -f win32 "%%f" -o "%%~nf.o"
    if errorlevel 1 (
        echo %RED%!!! FEJL UNDER ASSEMBLING: %%f !!!%RESET%
        pause
        exit /b
    )
)

echo Linker med ld...

ld -o adventure.exe *.o -e main ^
 -L"C:\Users\tommy\Documents\winlibs-i686-posix-dwarf-gcc-15.1.0-mingw-w64ucrt-13.0.0-r2\mingw32\lib" ^
 -L"C:\Users\tommy\Documents\winlibs-i686-posix-dwarf-gcc-15.1.0-mingw-w64ucrt-13.0.0-r2\mingw32\i686-w64-mingw32\lib" ^
 -L"C:\Users\tommy\Documents\winlibs-i686-posix-dwarf-gcc-15.1.0-mingw-w64ucrt-13.0.0-r2\mingw32\lib\gcc\i686-w64-mingw32\15.1.0" ^
 -lkernel32 -luser32 -lmsvcrt

if %errorlevel% neq 0 (
    echo ►►► LINKFEJL
) else (
    echo ✅ Link lykkedes! Du kan nu køre adventure.exe
)

pause
