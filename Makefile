ROOT := $(realpath $(dir $(realpath $(lastword $(MAKEFILE_LIST)))))

ARDUINO_DIR=$(HOME)/Library/arduino15
ARDUINO_PACKAGE_DIR=$(HOME)/Library/arduino15/packages
# ALTERNATE_CORE_PATH=$(HOME)/Library/arduino15/packages/adafruit/hardware/samd/1.2.9
#
ARM_TOOLS_DIR=$(HOME)/Library/Arduino15/packages/arduino/tools/arm-none-eabi-gcc/4.8.3-2014q1
CMSIS_DIR=$(HOME)/Library/arduino15/packages/arduino/tools/CMSIS/4.5.0/CMSIS
CMSIS_ATMEL_DIR=$(HOME)/Library/arduino15/packages/arduino/tools/CMSIS-Atmel/1.2.0/CMSIS
# BUNDLED_BOSSA_DIR=$(HOME)/Library/arduino15/packages/arduino/tools/bossac
BOSSA=$(HOME)/Library/arduino15/packages/arduino/tools/bossac/1.7.0/bossac
ARDMK_VENDOR=adafruit
BOARD_TAG=adafruit_trellis_m4
ARCHITECTURE=samd

# This variable is local, name it however you want
SOURCE_FOLDERS=src

# These two are used by Arduino.mk
# LOCAL_C_SRCS=$(foreach dir,$(SOURCE_FOLDERS),$(wildcard $(dir)/*.c))
# LOCAL_CPP_SRCS=$(foreach dir,$(SOURCE_FOLDERS),$(wildcard $(dir)/*.cpp))
LOCAL_INO_SRCS=$(foreach dir,$(SOURCE_FOLDERS),$(wildcard $(dir)/*.ino))

# Arduino.app uses the following command to successfully upload
# /Users/ben/Library/Arduino15/packages/arduino/tools/bossac/1.8.0-48-gb176eee/bossac -i -d --port=cu.usbmodem14101 -U -i --offset=0x4000 -w -v /var/folders/w0/mnr4bl3x3yz0bjvz8x2rrnpc0000gn/T/arduino_build_619717/neopixel_test.ino.bin -R 

# This makefile uses this command and it doesn't appear to do anything, then fails "no device found"
# /Users/ben/Library/arduino15/packages/arduino/tools/bossac/1.7.0/bossac -d --info --erase --write --verify --reset --port=tty.usbmodem14101 build-adafruit_trellis_m4/lattice.bin

# This command works!
# /Users/ben/Library/Arduino15/packages/arduino/tools/bossac/1.8.0-48-gb176eee/bossac -i -d --port=tty.usbmodem14101 -U -i --offset=0x4000 -w -v ./build-adafruit_trellis_m4/lattice.bin -R

# Can it be reproduced with
#  BOSSA_OPTS += -d --info --erase --write --verify --reset

# SKETCH = $(ROOT)/src/Lattice.ino
# CUSTOM_LIBS=$(ROOT)/libs

# EXCLUDE_DIRS=$(wildcard $(ARDUINO_LIBS)/*/tests) $(wildcard $(CUSTOM_LIBS)/*/tests)

# UPLOAD_PORT ?= $(shell ls -1tr /dev/tty.usb* 2>/dev/null | tail -1)

# For versions <= 2.4.0
# FLASH_DEF=1M0
# For versions 2.4.3+
# FLASH_DEF=1M
# UPLOAD_SPEED="115200"

# FLASH_MODE=dout
# LWIP_VARIANT=Prebuilt (v1.4 Higher Bandwidth)

# NAME=GardenLights
# TYPE=BASIC

# BUILD_EXTRA_FLAGS="-DTYPE_$(TYPE)"
# BUILD_EXTRA_FLAGS+="-DNAME=\"$(NAME)\""

include $(ROOT)/utils/ArduinoMakefile/Sam.mk
