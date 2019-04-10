mkdir -p bin
mkdir -p build
cd bin
if [[ ! -e arduino-cli ]]; then
  # Download and move arduino-cli
  curl -o arduino-cli.zip https://downloads.arduino.cc/arduino-cli/arduino-cli-latest-osx.zip
  unzip arduino-cli.zip
  rm arduino-cli.zip
  mv arduino-cli* arduino-cli
fi
easy_install -U pyserial
./arduino-cli --config-file ../arduino-cli.yaml core update-index
./arduino-cli --config-file ../arduino-cli.yaml core install arduino:samd
./arduino-cli --config-file ../arduino-cli.yaml core install adafruit:samd
ARDUINO_DIR=$(./arduino-cli --config-file ../arduino-cli.yaml config dump | grep 'arduino_data' | sed 's/^arduino_data: \(.*\)$/\1/')
ARDUINO_PACKAGE_DIR=$ARDUINO_DIR/packages
ln -s $ARDUINO_PACKAGE_DIR/arduino/tools $ARDUINO_PACKAGE_DIR/adafruit/
cd ../
git submodule update --init
mkdir -p libraries/U8g2lib/src
cp libraries/u8g2/cppsrc/*.h libraries/U8g2lib/
cp libraries/u8g2/cppsrc/*.cpp libraries/U8g2lib/
cp libraries/u8g2/csrc/*.h libraries/U8g2lib/
cp libraries/u8g2/csrc/*.c libraries/U8g2lib/
