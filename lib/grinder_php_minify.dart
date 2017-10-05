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
part 'src/functions.dart';
part 'src/minifier.dart';
part 'src/safe_transformer.dart';
part 'src/transformer.dart';
