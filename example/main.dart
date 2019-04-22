import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' as php_minify;

@Task('Compresses the PHP scripts from a given directory')
Future<void> compressPhpDirectory() => php_minify.compress(getDir('path/to/src'), getDir('path/to/out'));

@Task('Compresses a given PHP script')
Future<void> compressPhpFile() => php_minify.compress(getFile('path/to/src.php'), getFile('path/to/out.php'));
