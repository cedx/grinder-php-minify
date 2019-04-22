/// [Grinder](https://google.github.io/grinder.dart) plug-in minifying [PHP](https://secure.php.net) source code by removing comments and whitespace.
library grinder_php_minify;

import 'dart:io';
import 'dart:isolate';
import 'package:grinder/grinder.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:where/where.dart';

part 'src/fast_transformer.dart';
part 'src/minifier.dart';
part 'src/safe_transformer.dart';
part 'src/transform_mode.dart';
part 'src/transformer.dart';

/// Minifies the specified [source] file or directory containing PHP files,
/// and writes the resulting output to the specified [destination].
///
/// If [source] is a directory, it will be scanned according to the value of the [recurse] parameter for files matching the specified [pattern].
/// If [base] is provided, this path is removed from the target path of the destination files.
/// If [binary] is provided, it will be used as the path to the PHP executable.
Future<void> compress(FileSystemEntity source, FileSystemEntity destination, {
  String base,
  String binary,
  TransformMode mode = TransformMode.safe,
  String pattern = '*.php',
  bool recurse = true,
  bool silent = false
}) async {
  final minifier = Minifier(binary: binary ?? await where('php', onError: (command) => command), mode: mode, silent: silent);
  if (source is! Directory) {
    final output = destination is Directory ? joinDir(destination, [baseName(source)]) : destination;
    return minifier.compressFile(source, output);
  }

  final output = destination is Directory ? destination : destination.parent;
  final fileSet = FileSet.fromDir(source, pattern: pattern, recurse: recurse);
  return minifier.compressFiles(fileSet.files, output, base: base ?? source.path);
}
