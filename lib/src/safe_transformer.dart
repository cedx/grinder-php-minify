part of grinder_php_minify;

/// Removes comments and whitespace from a PHP script, by calling a PHP process.
class SafeTransformer {

  /// The instance providing access to the minifier settings.
  final Minifier _minifier;

  /// Creates a new safe transformer.
  SafeTransformer(this._minifier);

  /// Processes a PHP script and returns it with all its source code minified.
  Future<String> transform(String script) async {
    return '';
  }
}
