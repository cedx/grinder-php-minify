part of '../grinder_php_minify.dart';

/// Removes comments and whitespace from a PHP script, by calling a PHP process.
class SafeTransformer implements Transformer {

  /// Creates a new safe transformer.
  SafeTransformer([this._executable = 'php']);

  /// The path to the PHP executable.
  final String _executable;

  /// Closes this transformer and releases any resources associated with it.
  @override
  Future<void> close() => Future.value();

  /// Processes the specified PHP [script] and returns its contents minified.
  @override
  Future<String> transform(File script) async =>
    (await Process.run(path.normalize(_executable), ['-w', script.absolute.path])).stdout;
}
