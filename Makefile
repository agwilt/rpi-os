# Makefile for my bare metal rpi project
MAKEFLAGS := -j 1


# VARIABLES
#==================

# tools
PREFIX?=arm-none-eabi-
FLAGS=-mfpu=vfp -mfloat-abi=hard -march=armv6zk -mtune=arm1176jzf-s
LINKER=kernel.ld

# directoris
BUILD=build/
SOURCE=source/
TMP=tmp/

# files
OBJECTS := $(patsubst $(SOURCE)%.S,$(TMP)%.o,$(wildcard $(SOURCE)*.S))
ELF=$(TMP)kernel.elf
TARGET=$(BUILD)kernel.img

LIST=kernel.list
MAP=kernel.map
NM=kernel.nm



# TARGETS
#==================

# BUILD
#---------------
# Build everything, and include help files
all: $(TARGET) disassemble

# Build object files
$(TMP)%.o: $(SOURCE)%.s $(TMP)
	$(PREFIX)as -I $(SOURCE) $< -o $@

# Assemble the code to and elf file
$(ELF):	$(OBJECTS) $(LINKER)
	$(PREFIX)ld --no-undefined $(OBJECTS) -Map $(MAP) -o $(ELF) -T $(LINKER)

# Turn the elf into a binary image
$(TARGET): $(ELF)
	$(PREFIX)objcopy $(ELF) -O binary $(TARGET)


# DISASSEMBLY
#---------------
# Disassemble the elf
disassemble: $(LIST) $(NM)

# Generate listing file
$(LIST): $(ELF)
	$(PREFIX)objdump -D $(ELF) > $(LIST)

# Generate symbol list
$(NM): $(ELF)
	$(PREFIX)nm $(ELF) > $(NM)
#---------------


# OTHERS
#---------------
# Clean up everything
clean:
	rm -f $(LIST) $(MAP) $(TARGET)
	rm -rf $(TMP)

$(TMP):
	mkdir $@

# rebuild everything
rebuild: clean all

# install image to SD
install:
	cp build/kernel.img /run/media/andreas/boot/

# aliases:
list: $(LIST)
nm: $(NM)
#---------------
