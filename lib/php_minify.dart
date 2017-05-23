/// [Grinder](https://google.github.io/grinder.dart) plug-in minifying [PHP](https://secure.php.net) source code by removing comments and whitespace.
library grinder_php_minify;

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:grinder/grinder.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:which/which.dart';

part 'src/fast_transformer.dart';
part 'src/minifier.dart';
part 'src/safe_transformer.dart';
part 'src/transformer.dart';

/// Minifies the specified PHP [source] directory and saves the resulting output to the specified [destination] directory.
///
/// The processing can be customized using the following options:
/// - [binary]: the path to the PHP executable. Defaults to the `php` binary found on the system path.
/// - [mode]: the transformation type. Defaults to `"safe"`.
/// - [pattern]: the file pattern used to match the eligible PHP scripts. Defaults to `"*.php"`.
/// - [recurse]: a value indicating whether to process the directory recursively. Defaults to `true`.
/// - [silent]: a value indicating whether to silent the plug-in output. Defaults to `false`.
Future minify(dynamic source, dynamic destination, {dynamic binary, String mode = 'safe', String pattern = '*.php', bool recurse = true, bool silent = false}) async {
  var minifier = new Minifier(binary != null ? new FilePath(binary).path : await which('php'))
    ..mode = mode
    ..silent = silent;

  return minifier.processDirectory(
    new FilePath(source).asDirectory,
    new FilePath(destination).asDirectory,
    pattern: pattern,
    recurse: recurse
  );
}

/// Minifies the specified PHP [source] file and saves the resulting output to the specified [destination] file.
///
/// The processing can be customized using the following options:
/// - [binary]: the path to the PHP executable. Defaults to the `php` binary found on the system path.
/// - [mode]: the transformation type. Defaults to `"safe"`.
/// - [silent]: a value indicating whether to silent the plug-in output. Defaults to `false`.
Future minifyFile(dynamic source, dynamic destination, {dynamic binary, String mode = 'safe', bool silent = false}) async {
  var minifier = new Minifier(binary != null ? new FilePath(binary).path : await which('php'))
    ..mode = mode
    ..silent = silent;

  return minifier.processFile(
    new FilePath(source).asFile,
    new FilePath(destination).asFile
  );
}
