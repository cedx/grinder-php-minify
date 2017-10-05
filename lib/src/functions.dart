part of grinder_php_minify;

/// Minifies the PHP files of the specified [source] directory and saves the resulting output to the specified [destination] directory.
///
/// The processing can be customized using the following options:
/// - [binary]: the path to the PHP executable. Defaults to the `php` binary found on the system path.
/// - [mode]: the transformation type.
/// - [pattern]: the file pattern used to match the eligible PHP scripts.
/// - [recurse]: a value indicating whether to process the directory recursively.
/// - [silent]: a value indicating whether to silent the plug-in output.
Future compress(source, destination, {binary, String mode = 'safe', String pattern = '*.php', bool recurse = true, bool silent = false}) async {
  var minifier = new Minifier(
    binary: binary != null ? new FilePath(binary).path : await where('php'),
    mode: mode,
    silent: silent
  );

  return minifier.processDirectory(
    new FilePath(source).asDirectory,
    new FilePath(destination).asDirectory,
    pattern: pattern,
    recurse: recurse
  );
}

/// Minifies the specified PHP [source] file and saves the resulting output to the specified [destination] file.
///
/// The processing can be customized using the following options:
/// - [binary]: the path to the PHP executable. Defaults to the `php` binary found on the system path.
/// - [mode]: the transformation type.
/// - [silent]: a value indicating whether to silent the plug-in output.
Future compressFile(source, destination, {binary, String mode = 'safe', bool silent = false}) async {
  var minifier = new Minifier(
    binary: binary != null ? new FilePath(binary).path : await where('php'),
    mode: mode,
    silent: silent
  );

  return minifier.processFile(
    new FilePath(source).asFile,
    new FilePath(destination).asFile
  );
}
