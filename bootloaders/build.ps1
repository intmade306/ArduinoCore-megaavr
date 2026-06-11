$AVR_GCC_PATH = "C:\Users\intmade\AppData\Local\Arduino15\packages\arduino\tools\avr-gcc\7.3.0-atmel3.6.1-arduino7\bin"
$CC = Join-Path $AVR_GCC_PATH "avr-gcc.exe"
$OBJCOPY = Join-Path $AVR_GCC_PATH "avr-objcopy.exe"

Write-Host "Compiling..."
& $CC -c -g -Os -w -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics "-Wno-error=narrowing" "-Wl,--gc-sections" -w -mmcu=atmega4809 -DF_CPU=16000000L boot.c -o boot.o

Write-Host "Linking..."
& $CC -g -Os -w -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics "-Wno-error=narrowing" -nostartfiles "-Wl,--gc-sections" -w -mmcu=atmega4809 -DF_CPU=16000000L boot.o -o boot.elf

Write-Host "Extracting hex..."
& $OBJCOPY -O ihex -R .fuses boot.elf boot.hex

Write-Host "Moving hex..."
Move-Item -Force boot.hex atmega4809_uart_bl.hex

Write-Host "Done! Generated: atmega4809_uart_bl.hex"
