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

  /// Minifies the given set of PHP [source] files and saves the resulting output to the specified [destination] directory.
  Future compress(FileSet source, Directory destination, {Directory base}) async {
    base ??= Directory.current;

    for (var file in source.files) {
      if (!silent) log('minifying ${file.path}');

      var output = joinFile(destination, [path.relative(file.path, from: base.path)]);
      await output.parent.create(recursive: true);
      await output.writeAsString(await transformer.transform(file));
    }

    return transformer.close();
  }
}
