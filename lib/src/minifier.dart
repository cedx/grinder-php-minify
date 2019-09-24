part of '../grinder_php_minify.dart';

/// Removes PHP comments and whitespace by applying the ['php_strip_whitespace()'](https://www.php.net/manual/en/function.php-strip-whitespace.php) function.
class Minifier {

  /// Creates a new minifier.
  Minifier({String binary = 'php', TransformMode mode = TransformMode.safe, this.silent = true}):
    transformer = Transformer(mode, executable: binary);

  /// Value indicating whether to silent the minifier output.
  bool silent;

  /// The instance used to process the PHP code.
  final Transformer transformer;

  /// Minifies the PHP scripts corresponding to the specified file [patterns], and saves the resulting output to a [destination] directory.
  ///
  /// The file patterns are resolved against a given [root] path, which defaults to the current working directory.
  /// An absolute [base] path, defaulting to the current working directory, is removed from the target path of the destination files.
  Future<void> run(Iterable<Glob> patterns, Directory destination, {String base, Directory root}) async {
    base ??= Directory.current.path;
    root ??= Directory.current;

    for (final pattern in patterns) {
      for (final file in await pattern.list(root: root.path).toList()) {
        if (!silent) log('minifying ${file.path}');
        final output = joinFile(destination, [p.relative(file.path, from: base)]);
        await output.create(recursive: true);
        await output.writeAsString(await transformer.transform(file), flush: true);
      }
    }

    return transformer.close();
  }
}

/// Defines the type of transformation applied by a minifier.
enum TransformMode {

  /// Applies a fast transformation.
  fast,

  /// Applies a safe transformation.
  safe
}
