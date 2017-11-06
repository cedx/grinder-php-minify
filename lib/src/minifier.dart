part of grinder_php_minify;

/// Removes PHP comments and whitespace by applying the ['php_strip_whitespace()'](https://secure.php.net/manual/en/function.php-strip-whitespace.php) function.
class Minifier {

  /// Creates a new minifier from the specified PHP [binary].
  Minifier({String binary = 'php', TransformMode mode = TransformMode.safe, this.silent = false}):
    transformer = new Transformer(mode, executable: binary);

  /// Value indicating whether to silent the plug-in output.
  bool silent;

  /// The instance used to process the PHP code.
  final Transformer transformer;

  /// Minifies the PHP files of the specified [source] directory and saves the resulting output to the specified [destination] directory.
  ///
  /// Uses the specified file [pattern] to match the eligible PHP scripts.
  /// A [recurse] value indicates whether to process the input directory recursively.
  Future<Null> compressDirectory(Directory source, Directory destination, {String pattern = '*.php', bool recurse: true}) {
    var sources = new FileSet.fromDir(source, pattern: pattern, recurse: recurse);
    return compressFiles(sources.files, destination, base: source.path);
  }

  /// Minifies the specified PHP [source] file and saves the resulting output to the specified [destination] file.
  Future<Null> compressFile(File source, File destination) async {
    await _transform(source, destination);
    return transformer.close();
  }

  /// Minifies the given set of PHP [sources] and saves the resulting output to the specified [destination] directory.
  /// A [base] path, defaulting to the current working directory, is removed from the target path of the destination files.
  Future<Null> compressFiles(List<File> sources, Directory destination, {String base}) async {
    base ??= Directory.current.path;
    for (var file in sources) await _transform(file, joinFile(destination, [path.relative(file.path, from: base)]));
    return transformer.close();
  }

  /// Minifies the specified PHP [source] file and saves the resulting output to the specified [destination] file.
  Future<Null> _transform(File source, File destination) async {
    if (!silent) log('minifying ${source.path}');
    await destination.parent.create(recursive: true);
    return destination.writeAsString(await transformer.transform(source));
  }
}
