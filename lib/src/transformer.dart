part of grinder_php_minify;

/// Interface providing a mechanism for transforming input and producing output.
abstract class Transformer {

  /// Creates a new transformer from the specified [mode],
  /// optionnaly using the specified PHP [executable].
  factory Transformer(String mode, {String executable = 'php'}) =>
    mode.toLowerCase() == 'fast' ? new FastTransformer(executable) : new SafeTransformer(executable);

  /// Closes this transformer and releases any resources associated with it.
  Future close();

  /// Processes the specified PHP [script] and returns its contents minified.
  Future<String> transform(File script);
}
