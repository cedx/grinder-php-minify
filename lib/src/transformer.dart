part of grinder_php_minify;

/// Interface providing a mechanism for transforming input and producing output.
abstract class Transformer {

  /// Closes this transformer and releases any resources associated with it.
  Future close();

  /// Processes the specified PHP [script] and returns its contents minified.
  Future<String> transform(File script);
}
