
# flutterwatch

A command-line application that allows hot-reload/hot-restart when there is file
change in directory.

https://github.com/user-attachments/assets/799d70fc-328f-4ce8-a90c-ddcf09cdca66

## Motivation

Some people don't use IDEs (vscode, android studio, intellij) to develop Flutter apps and rely on
`flutter run` command. This CLI tool wraps the flutter command and watches the
`./lib` directory by default for any changes and auto hot-reload flutter.

## Installation

### Global

```bash
dart pub global activate flutterwatch
```

### Local project

```bash
dart pub add flutterwatch
```

## Usage

```bash
Usage: flutterwatch <flags> -- [flutter arguments]
# dart run flutterwatch (if added locally)
-h, --help           Print this usage information.
-r, --hot-reload     Hot reload when there is a code change.
                     (defaults to on)
-R, --hot-restart    Hot restart when there is a code change.
-d, --dir            Directory to watch for changes.
                     (defaults to "./lib")
-v, --version        Print the cli version.
# Example: flutterwatch -- run -d emulator-5554
```
