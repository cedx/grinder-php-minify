part of grinder_php_minify;

/// Removes comments and whitespace from a PHP script, by calling a Web service.
class FastTransformer implements Function {

  /// The instance providing access to the minifier settings.
  final Minifier _minifier;

  /// Creates a new fast transformer.
  FastTransformer(this._minifier);

  /// Processes the specified PHP [script] and returns its minified contents.
  Future<String> call(File script) async {
    return '';
  }
}
