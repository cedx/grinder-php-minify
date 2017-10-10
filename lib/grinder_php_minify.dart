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

/// Minifies the PHP files of the specified [source] directory and saves the resulting output to the specified [destination] directory.
///
/// The processing can be customized using the following options:
/// - [binary]: the path to the PHP executable. Defaults to the `php` binary found on the system path.
/// - [mode]: the transformation type.
/// - [pattern]: the file pattern used to match the eligible PHP scripts.
/// - [recurse]: a value indicating whether to process the directory recursively.
/// - [silent]: a value indicating whether to silent the plug-in output.
Future phpMinify(source, destination, {binary, String mode = 'safe', String pattern = '*.php', bool recurse = true, bool silent = false}) async {
  var minifier = new Minifier(
    binary: binary != null ? new FilePath(binary).path : await where('php'),
    mode: mode,
    silent: silent
  );

  var input = new FilePath(source);
  var output = new FilePath(destination).asDirectory;
  return input.isFile ?
    minifier.processFile(input.asFile, joinFile(output, [input.name])) :
    minifier.processDirectory(input.asDirectory, output, pattern: pattern, recurse: recurse);
}
