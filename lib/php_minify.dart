/// [Grinder](https://google.github.io/grinder.dart) plug-in minifying [PHP](https://secure.php.net) source code by removing comments and whitespace.
library grinder_php_minify;

import 'dart:async';
import 'dart:io';
import 'package:grinder/grinder.dart';
import 'package:which/which.dart';

part 'src/fast_transformer.dart';
part 'src/minifier.dart';
part 'src/safe_transformer.dart';

/// TODO
Future phpMinify(dynamic src, dynamic dest) async {
  // TODO
}
