part of grinder_php_minify;

/// Removes PHP comments and whitespace by applying the ['php_strip_whitespace()'](https://secure.php.net/manual/en/function.php-strip-whitespace.php) function.
class Minifier {

  /// Creates a new minifier from the specified PHP [binary].
  Minifier({String binary = 'php', String mode = 'safe', this.silent = false}):
    transformer = new Transformer(mode, executable: binary);

  /// Value indicating whether to silent the plug-in output.
  bool silent;

  /// The instance used to process the PHP code.
  final Transformer transformer;

  /// Minifies the PHP files of the specified [source] directory and saves the resulting output to the specified [destination] directory.
  ///
  /// Uses the specified file [pattern] to match the eligible PHP scripts.
  /// A [recurse] value indicates whether to process the directory recursively.
  Future processDirectory(Directory source, Directory destination, {String pattern = '*.php', bool recurse: true}) async {
    var sources = new FileSet.fromDir(source, pattern: pattern, recurse: recurse);
    return _processFiles(sources.files.map((src) {
      var dest = joinFile(destination, [path.relative(src.path, from: source.path)]);
      return [src, dest];
    }));
  }

  /// Minifies the specified PHP [source] file and saves the resulting output to the specified [destination] file.
  Future processFile(File source, File destination) async => _processFiles([
    [source, destination]
  ]);

  /// Minifies the specified list of PHP [files], provided as source-destination pairs.
  Future _processFiles(Iterable<List<File>> files) async {
    for (var pair in files) {
      if (!silent) log('Minifying: ${pair.first.path}');
      await pair.last.parent.create(recursive: true);
      await pair.last.writeAsString(await transformer.transform(pair.first));
    }

    return transformer.close();
  }
}
