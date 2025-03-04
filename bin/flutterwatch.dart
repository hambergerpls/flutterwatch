library;

import 'dart:convert';
import 'dart:io';
import 'package:watcher/watcher.dart';
import 'package:args/args.dart';

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'hot-reload',
      abbr: 'r',
      negatable: false,
      defaultsTo: true,
      help: 'Hot reload when there is a code change.',
    )
    ..addFlag(
      'hot-restart',
      abbr: 'R',
      negatable: false,
      help: 'Hot restart when there is a code change.',
    )
    ..addOption(
      'dir',
      abbr: 'd',
      defaultsTo: './lib',
      help: 'Directory to watch for changes.',
    )
    ..addFlag(
      'version',
      abbr: 'v',
      negatable: false,
      help: 'Print the cli version.',
    );
}

void printUsage(ArgParser argParser) {
  print('Usage: flutterwatch <flags> -- [flutter arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);

    // Process the parsed arguments.
    if (results.wasParsed('help')) {
      printUsage(argParser);
      return;
    }
    if (results.wasParsed('version')) {
      print('flutterwatch version: $version');
      return;
    }

    if (results.rest.isEmpty) {
      printUsage(argParser);
      return;
    }

    stdin.lineMode = false;
    stdin.echoMode = false;

    Process.start('flutter', results.rest).then((process) {
      process
        ..stdout.pipe(stdout)
        ..stderr.pipe(stderr)
        ..exitCode.then((code) => exit(code));

      stdin.transform(utf8.decoder).listen((input) {
        process.stdin.write(input);
      });

      DirectoryWatcher(results.option('dir')!).events.listen((event) {
        process.stdin.write(results.wasParsed('hot-restart') ? 'R' : 'r');
      });
    });
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
