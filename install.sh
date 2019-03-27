mkdir -p bin
cd bin
if [[ ! -e arduino-cli ]]; then
  # Download and move arduino-cli
  curl -o arduino-cli.zip https://downloads.arduino.cc/arduino-cli/arduino-cli-latest-osx.zip
  unzip arduino-cli.zip
  rm arduino-cli.zip
  mv arduino-cli* arduino-cli
fi
./arduino-cli --config-file ../arduino-cli.yaml core update-index
./arduino-cli --config-file ../arduino-cli.yaml core install arduino:samd