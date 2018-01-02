part of grinder_php_minify;
// ignore_for_file: type_annotate_public_apis

/// Minifies the PHP files of the specified [source] directory, and optionally saves the resulting output to the specified [destination] directory.
///
/// Uses the specified file [pattern] to match the eligible PHP scripts.
/// A [recurse] value indicates whether to process the input directory recursively.
Future<Null> compressDirectory(source, destination, {
  String binary,
  Object mode = TransformMode.safe,
  String pattern = '*.php',
  bool recurse: true,
  bool silent = false
}) async {
  var minifier = await _createMinifier(binary, mode: mode, silent: silent);
  return minifier.compressDirectory(new FilePath(source).asDirectory, new FilePath(destination).asDirectory);
}

/// Minifies the specified PHP [source] file, and optionally saves the resulting output to the specified [destination] file.
Future<Null> compressFile(source, destination, {
  String binary,
  Object mode = TransformMode.safe,
  bool silent = false
}) async {
  var minifier = await _createMinifier(binary, mode: mode, silent: silent);
  return minifier.compressFile(new FilePath(source).asFile, new FilePath(destination).asFile);
}

/// Minifies the given set of PHP [sources] and saves the resulting output to the specified [destination] directory.
/// A [base] path, defaulting to the current working directory, is removed from the target path of the destination files.
Future<Null> compressFiles(Iterable sources, destination, {
  String base,
  String binary,
  Object mode = TransformMode.safe,
  bool silent = false
}) async {
  var minifier = await _createMinifier(binary, mode: mode, silent: silent);
  return minifier.compressFiles(sources.map((source) => new FilePath(source).asFile), new FilePath(destination).asDirectory, base: base);
}

/// Creates a new minifier.
Future<Minifier> _createMinifier(String binary, {Object mode = TransformMode.safe, bool silent = false}) async {
  var transformMode = mode is TransformMode ? mode : (mode.toString() == 'fast' ? TransformMode.fast : TransformMode.safe);
  return new Minifier(binary: binary ?? await where('php'), mode: transformMode, silent: silent);
}
