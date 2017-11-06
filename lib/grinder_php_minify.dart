/// [Grinder](https://google.github.io/grinder.dart) plug-in minifying [PHP](https://secure.php.net) source code by removing comments and whitespace.
library grinder_php_minify;

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:grinder/grinder.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:where/where.dart';

part 'src/fast_transformer.dart';
part 'src/minifier.dart';
part 'src/safe_transformer.dart';
part 'src/transform_mode.dart';
part 'src/transformer.dart';

/// Minifies the PHP files of the specified [source] directory, and optionally saves the resulting output to the specified [destination] directory.
///
/// Uses the specified file [pattern] to match the eligible PHP scripts.
/// A [recurse] value indicates whether to process the input directory recursively.
Future<Null> compressDirectory(source, destination, {String binary, TransformMode mode = TransformMode.safe, String pattern = '*.php', bool recurse: true, bool silent = false}) async {
  var minifier = new Minifier(binary: binary ?? await where('php'), mode: mode, silent: silent);
  return minifier.compressDirectory(new FilePath(source).asDirectory, new FilePath(destination).asDirectory);
}

/// Minifies the specified PHP [source] file, and optionally saves the resulting output to the specified [destination] file.
Future<Null> compressFile(source, destination, {String binary, TransformMode mode = TransformMode.safe, bool silent = false}) async {
  var minifier = new Minifier(binary: binary ?? await where('php'), mode: mode, silent: silent);
  return minifier.compressFile(new FilePath(source).asFile, new FilePath(destination).asFile);
}

/// Minifies the given set of PHP [sources] and saves the resulting output to the specified [destination] directory.
/// A [base] path, defaulting to the current working directory, is removed from the target path of the destination files.
Future<Null> compressFiles(List sources, destination, {String base, String binary, TransformMode mode = TransformMode.safe, bool silent = false}) async {
  var files = sources.map((source) => new FilePath(source).asFile).toList();
  var minifier = new Minifier(binary: binary ?? await where('php'), mode: mode, silent: silent);
  return minifier.compressFiles(files, new FilePath(destination).asDirectory, base: base);
}
