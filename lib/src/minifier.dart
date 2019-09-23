part of '../grinder_php_minify.dart';

/// Removes PHP comments and whitespace by applying the ['php_strip_whitespace()'](https://www.php.net/manual/en/function.php-strip-whitespace.php) function.
class Minifier {

  /// Creates a new minifier.
  Minifier({String binary = 'php', TransformMode mode = TransformMode.safe, this.silent = true}):
    transformer = Transformer(mode, executable: binary);

  /// Value indicating whether to silent the minifier output.
  bool silent;

  /// The instance used to process the PHP code.
  final Transformer transformer;

  /// Minifies the PHP files of the specified [source] directory and saves the resulting output to the specified [destination] directory.
  ///
  /// Uses the specified file [pattern] to match the eligible PHP scripts.
  /// A [recurse] value indicates whether to process the input directory recursively.
  Future<void> compressDirectory(Directory source, Directory destination, {String pattern = '*.php', bool recurse = false}) {
    final sources = FileSet.fromDir(source, pattern: pattern, recurse: recurse);
    return compressFiles(sources.files, destination, base: source.path);
  }

  /// Minifies the specified PHP [source] file and saves the resulting output to the specified [destination] file.
  Future<void> compressFile(File source, File destination) async {
    await _transform(source, destination);
    return transformer.close();
  }

  /// Minifies the given set of PHP [sources] and saves the resulting output to the specified [destination] directory.
  /// A [base] path, defaulting to the current working directory, is removed from the target path of the destination files.
  Future<void> compressFiles(Iterable<File> sources, Directory destination, {String base}) async {
    base ??= Directory.current.path;
    for (final source in sources) await _transform(source, joinFile(destination, [p.relative(source.path, from: base)]));
    return transformer.close();
  }

  /// Minifies the specified PHP [source] file and saves the resulting output to the specified [destination] file.
  Future<File> _transform(File source, File destination) async {
    if (!silent) log('minifying ${source.path}');
    await destination.create(recursive: true);
    return destination.writeAsString(await transformer.transform(source));
  }
}

/// Defines the type of transformation applied by a minifier.
enum TransformMode {

  /// Applies a fast transformation.
  fast,

  /// Applies a safe transformation.
  safe
}
