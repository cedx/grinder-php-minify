import 'dart:async';
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' as php_minify;

@Task('Compresses the PHP scripts from a given directory')
Future<void> compressPhpDirectory() => php_minify.compressDirectory('path/to/src', 'path/to/out');

@Task('Compresses a given PHP script')
Future<void> compressPhpFile() => php_minify.compressFile('path/to/src.php', 'path/to/out.php');

@Task('Compresses a given set of PHP scripts')
Future<void> compressPhpFiles() {
  final sourceDir = getDir('path/to/src');
  final fileSet = FileSet.fromDir(sourceDir, pattern: '*.php', recurse: true);
  return php_minify.compressFiles(fileSet.files, 'path/to/out', base: sourceDir.path);
}
