# ===== STM32F4 Nucleo Blink Makefile =====

# Toolchain
CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

# MCU and flags
MCU = cortex-m4
CFLAGS = -mcpu=$(MCU) -mthumb -O2 -nostdlib  
LDFLAGS = -T linker.ld

# Source and target
SRC = blink.c
ELF = blink.elf
BIN = blink.bin

# Flash tool
FLASH = st-flash --connect-under-reset --reset 
FLASH_ADDR = 0x08000000

# Default target: build and flash
all: $(BIN) flash

# Compile to ELF
$(ELF): $(SRC)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

# Convert ELF to BIN
$(BIN): $(ELF)
	$(OBJCOPY) -O binary $< $@

# Flash binary to STM32
flash: $(BIN)
	$(FLASH) write $(BIN) $(FLASH_ADDR)

# Clean build files
clean:
	rm -f $(ELF) $(BIN)

.PHONY: all flash clean
