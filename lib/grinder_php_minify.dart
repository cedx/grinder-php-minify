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

/// Minifies the given set of PHP [source] files and saves the resulting output to the specified [destination] directory.
///
/// The processing can be customized using the following options:
/// - [binary]: the path to the PHP executable. Defaults to the `php` binary found on the system path.
/// - [mode]: the type of transformation applied.
/// - [silent]: a value indicating whether to silent the plug-in output.
Future phpMinify(FileSet source, Directory destination, {String binary, TransformMode mode = TransformMode.safe, bool silent = false}) async {
  var minifier = new Minifier(
    binary: binary != null ? new FilePath(binary).path : await where('php'),
    mode: mode,
    silent: silent
  );

  var input = new FilePath(source);
  return input.isFile ?
    minifier.processFile(input.asFile, joinFile(destination, [input.name])) :
    minifier.processDirectory(input.asDirectory, destination);
}
