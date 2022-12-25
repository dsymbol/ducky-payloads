# ducky-payloads

A collection of 🦆 payloads compatible with hak5-RubberDucky, FlipperZero-BadUSB & pico-ducky.

## Usage

#### [hak5-RubberDucky](https://docs.hak5.org/hak5-usb-rubber-ducky/ducky-script-basics/hello-world#testing-the-payload)

Copy the content of `payload.txt`, paste it into a blank project in [Payload Studio](https://payloadstudio.hak5.org/community), click "Generate Payload" to compile the payload, click "Download Payload" to save the `inject.bin` file, and copy it to the root of the USB Rubber Ducky drive.

#### [FlipperZero-BadUSB](https://docs.flipperzero.one/bad-usb)

Place the `payload.txt` file in the `SD Card/badusb/` folder on your Flipper Zero using the qFlipper software or the Flipper Mobile App.

#### [pico-ducky](https://github.com/dbisu/pico-ducky)

Place the `payload.txt` file in the root directory of the Pico and rename it to `payload.dd`.
