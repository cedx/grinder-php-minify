/// [Grinder](https://google.github.io/grinder.dart) plug-in minifying [PHP](https://secure.php.net) source code by removing comments and whitespace.
library grinder_php_minify;

import 'dart:async';
import 'dart:io';
import 'package:grinder/grinder.dart';
import 'package:which/which.dart';

part 'src/fast_transformer.dart';
part 'src/minifier.dart';
part 'src/safe_transformer.dart';

/// Minifies the PHP scripts located in the specified [source] directory and saves the resulting output to the specified [destination] directory.
///
/// The processing can be customized using the following options:
/// - [binary]: the path to the PHP executable. Defaults to `"php"`.
/// - [mode]: the transformation type. Defaults to `"safe"`.
/// - [pattern]: TODO Defaults to `"*.php"`.
/// - [silent]: a value indicating whether to silent the plug-in output. Defaults to `false`.
Future phpMinify(dynamic source, dynamic destination, {dynamic binary, String mode = 'safe', String pattern = '*.php', bool silent = false}) async {
  var minifier = new Minifier(binary != null ? new FilePath(binary).path : await which('php'))
    ..mode = mode
    ..silent = silent;

  var sources = new FileSet.fromDir(new FilePath(source).asDirectory, pattern: pattern, recurse: true);
  log(sources.files.toString());
  return minifier.transform(sources, new FilePath(destination).asDirectory);
}
