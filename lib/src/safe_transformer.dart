part of grinder_php_minify;

/// Removes comments and whitespace from a PHP script, by calling a PHP process.
class SafeTransformer implements Transformer {

  /// The instance providing access to the minifier settings.
  final Minifier _minifier;

  /// Creates a new safe transformer.
  SafeTransformer(this._minifier);

  /// Closes this transformer and releases any resources associated with it.
  @override
  Future close() async => null;

  /// Processes the specified PHP [script] and returns its contents minified.
  @override
  Future<String> transform(File script) async =>
    (await Process.run(_minifier.binary, ['-w', script.path])).stdout;
}
