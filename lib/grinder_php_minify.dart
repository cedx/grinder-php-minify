/// [Grinder](https://google.github.io/grinder.dart) plug-in minifying [PHP](https://www.php.net) source code by removing comments and whitespace.
library grinder_php_minify;

import 'dart:io';
import 'dart:isolate';
import 'package:glob/glob.dart';
import 'package:grinder/grinder.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:where/where.dart';

part 'src/fast_transformer.dart';
part 'src/minifier.dart';
part 'src/safe_transformer.dart';
part 'src/transformer.dart';

/// Minifies the PHP scripts corresponding to the specified file [patterns],
/// and writes the resulting output to the specified [destination] directory.
///
/// If [base] is provided, this path is removed from the target path of the destination files.
/// If [binary] is provided, it will be used as the path to the PHP executable.
/// The [mode] value indicates the operation mode of the minifier, while the [silent] value indicates whether to silent the minifier output.
Future<void> phpMinify(patterns, destination, {
  String base,
  String binary,
  TransformMode mode = TransformMode.safe,
  bool silent = false
}) async {
  final globs = patterns is List ? patterns : [patterns];
  return Minifier(binary: binary ?? await where('php', onError: (command) => command), mode: mode, silent: silent)
    .run(globs.map((pattern) => Glob(pattern)), FilePath(destination).asDirectory, base: base);
}
