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
    for (var script in sources.files) {
      var output = path.join(destination.path, path.relative(script.path, from: source.path));
      log(output); // TODO: normalize ???
      await processFile(script, new File(output));
    }
  }

  /// Minifies the specified PHP [source] file and saves the resulting output to the specified [destination] file.
  Future processFile(File source, File destination) async {
    if (!silent) log('Minifying: ${source.path}');
    return destination.writeAsString(await transform(source));
  }
}
