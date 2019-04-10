ROOT := $(realpath $(dir $(realpath $(lastword $(MAKEFILE_LIST)))))

ARDUINO_DIR:=$(shell ./bin/arduino-cli --config-file ../arduino-cli.yaml config dump | grep 'arduino_data' | sed 's/^arduino_data: \(.*\)$$/\1/')
ARDUINO_PACKAGE_DIR=$(ARDUINO_DIR)/packages
ARDUINO_SKETCHBOOK=$(ROOT)

ARDUINO_VERSION=10803

ARDMK_VENDOR=adafruit
BOARD_TAG=adafruit_trellis_m4
ARCHITECTURE=samd

CMSIS_ATMEL_VER=1.2.0

BUNDLED_BOSSA_DIR=$(ARDUINO_PACKAGE_DIR)/$(ARDMK_VENDOR)/tools/bossac
BOSSA_VER=$(shell echo "$(wildcard $(BUNDLED_BOSSA_DIR)/*)" | xargs -n 1 basename | sort -V | tail -1)
BOSSA = $(BUNDLED_BOSSA_DIR)/$(BOSSA_VER)/bossac

$(shell ./utils/uDino-Preprocessor/preprocessor.rb ./src/Lattice ./build)

SOURCE_FOLDERS=build

# These two are used by Arduino.mk
LOCAL_C_SRCS=$(foreach dir,$(SOURCE_FOLDERS),$(wildcard $(dir)/*.c))
LOCAL_CPP_SRCS=$(foreach dir,$(SOURCE_FOLDERS),$(wildcard $(dir)/*.cpp))
LOCAL_INO_SRCS=$(foreach dir,$(SOURCE_FOLDERS),$(wildcard $(dir)/*.ino))

BOSSA_OPTS = -d --info --erase --write --verify --reset --offset=0x4000

include $(ROOT)/utils/ArduinoMakefile/Sam.mk
