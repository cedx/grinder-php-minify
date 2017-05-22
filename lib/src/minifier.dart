part of grinder_php_minify;

/// Processes the specified PHP [script] and returns its contents minified.
typedef Future<String> Transform(File script);

/// Removes PHP comments and whitespace by applying the ['php_strip_whitespace()'](https://secure.php.net/manual/en/function.php-strip-whitespace.php) function.
class Minifier {

  /// Creates a new PHP minifier.
  Minifier([this.binary = 'php', this.transform]) {
    if (transform == null) transform = new SafeTransformer(this);
  }

  /// The path to the PHP executable.
  String binary;

  /// The transformation type.
  String get mode => transform is FastTransformer ? 'fast' : 'safe';
  set mode(String value) => transform = value == 'fast' ? new FastTransformer(this) : new SafeTransformer(this);

  /// Value indicating whether to silent the plug-in output.
  bool silent = false;

  /// The function used to process the PHP code.
  Transform transform;

  /// Minifies the specified PHP [source] directory and saves the resulting output to the specified [destination] directory.
  ///
  /// Uses the specified file [pattern] to match the eligible PHP scripts.
  /// A [recurse] value indicates whether to process the directory recursively.
  Future processDirectory(Directory source, Directory destination, {String pattern = '*.php', bool recurse: true}) async {
    var sources = new FileSet.fromDir(source, pattern: pattern, recurse: recurse);
    return _processFiles(sources.files.map((src) {
      var dest = path.join(destination.path, path.relative(src.path, from: source.path));
      return [src, new File(dest)];
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
      await pair.last.writeAsString(await transform(pair.first));
    }

    var transformer = transform as FastTransformer;
    if (transformer != null) await transformer.close();
  }
}
