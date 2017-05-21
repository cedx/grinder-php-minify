part of grinder_php_minify;

/// Removes comments and whitespace from a PHP script, by calling a PHP process.
class SafeTransformer implements Function {

  /// The instance providing access to the minifier settings.
  final Minifier _minifier;

  /// Creates a new safe transformer.
  SafeTransformer(this._minifier);

  /// Processes the specified PHP [script] and returns its minified contents.
  Future<String> call(File script) async {
    var result = await Process.run(_minifier.binary, ['-w', script.path]);
    return result.stdout;
  }
}
