import 'dart:io';
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' as php_minify;

@Task('Compresses the PHP scripts from a given directory')
Future<void> compressDirectory() => php_minify.compress(
  getDir('path/to/src'),
  getDir('path/to/out'),
  binary: Platform.isWindows ? r'C:\Program Files\PHP\php.exe' : '/usr/bin/php',
  mode: Platform.isWindows ? php_minify.TransformMode.safe : php_minify.TransformMode.fast,
  silent: stdout.hasTerminal
);

@Task('Compresses a given PHP script')
Future<void> compressFile() => php_minify.compress(
  getFile('path/to/src.php'),
  getFile('path/to/out.php')
);
