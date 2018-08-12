part of '../grinder_php_minify.dart';

/// Minifies the PHP files of the specified [source] directory, and optionally saves the resulting output to the specified [destination] directory.
///
/// Uses the specified file [pattern] to match the eligible PHP scripts.
/// A [recurse] value indicates whether to process the input directory recursively.
Future<void> compressDirectory(Object source, Object destination, {
  String binary,
  Object mode = TransformMode.safe,
  String pattern = '*.php',
  bool recurse = true,
  bool silent = false
}) async {
  var minifier = await _createMinifier(binary, mode: mode, silent: silent);
  return minifier.compressDirectory(FilePath(source).asDirectory, FilePath(destination).asDirectory);
}

/// Minifies the specified PHP [source] file, and optionally saves the resulting output to the specified [destination] file.
Future<void> compressFile(Object source, Object destination, {
  String binary,
  Object mode = TransformMode.safe,
  bool silent = false
}) async {
  var minifier = await _createMinifier(binary, mode: mode, silent: silent);
  return minifier.compressFile(FilePath(source).asFile, FilePath(destination).asFile);
}

/// Minifies the given set of PHP [sources] and saves the resulting output to the specified [destination] directory.
/// A [base] path, defaulting to the current working directory, is removed from the target path of the destination files.
Future<void> compressFiles(Iterable sources, Object destination, {
  String base,
  String binary,
  Object mode = TransformMode.safe,
  bool silent = false
}) async {
  var minifier = await _createMinifier(binary, mode: mode, silent: silent);
  return minifier.compressFiles(sources.map((source) => FilePath(source).asFile), FilePath(destination).asDirectory, base: base);
}

/// Creates a new minifier.
Future<Minifier> _createMinifier(String binary, {Object mode = TransformMode.safe, bool silent = false}) async {
  var transformMode = mode is TransformMode ? mode : (mode.toString() == 'fast' ? TransformMode.fast : TransformMode.safe);
  return Minifier(binary: binary ?? await where('php'), mode: transformMode, silent: silent);
}
