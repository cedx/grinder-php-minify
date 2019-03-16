# Usage
If you haven't used [Grinder](https://github.com/google/grinder.dart) before, be sure to check out the [related documentation](https://google.github.io/grinder.dart), as it explains how to create a `grind.dart` file and to define project tasks. Once you're familiar with that process, you may install the plug-in.

## Programming interface
The plug-in provides a set of functions that take a list of [PHP](https://secure.php.net) scripts as input, and remove the comments and whitespace in this file by applying the [`php_strip_whitespace()`](https://secure.php.net/manual/en/function.php-strip-whitespace.php) function on their contents.

!!! tip
    Whenever a function expects a directory or file parameter,
    you can specify it as an instance of [`FileSystemEntity`](https://api.dartlang.org/stable/dart-io/FileSystemEntity-class.html) or as a string (e.g. its path).
    
### Future&lt;void&gt; **compressDirectory**(Directory source, Directory destination, {String pattern = `"*.php"`, bool recurse = `true`})
Minifies the PHP files of a given source directory and saves the resulting output to a destination directory:

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' as php_minify;

@Task('Compress the PHP scripts from a given directory')
Future<void> compressPhp() => php_minify.compressDirectory('path/to/src', 'path/to/out');
```

When the function processes a directory, a filter is applied on the names of the processed files to determine whether they are PHP scripts. A filename pattern is used to match the eligible PHP scripts, by default it's set to `"*.php"`. You can change use the `pattern` option to select a different set of PHP scripts:

```dart
compressDirectory('path/to/src', 'path/to/out', pattern: '*.inc.php7');
```

The source directories are scanned recursively. You can force the function to only process the files located at the root of the source directory by setting the `recurse` option to `false`:

```dart
compressDirectory('path/to/src', 'path/to/out', recurse: false);
```

### Future&lt;void&gt; **compressFile**(File source, File destination)
Minifies a single PHP source file and saves the resulting output to a given destination file:

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' as php_minify;

@Task('Compress a given PHP script')
Future<void> compressPhp() => php_minify.compressFile('path/to/src.php', 'path/to/out.php');
```

### Future&lt;void&gt; **compressFiles**(Iterable sources, Directory destination, {String base})
Minifies the given set of PHP files and saves the resulting output to a destination directory:

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' as php_minify;

@Task('Compress a given set of PHP scripts')
Future<void> compressPhp() {
  var sourceDir = getDir('path/to/src');
  var fileSet = FileSet.fromDir(sourceDir, pattern: '*.php', recurse: true);
  return php_minify.compressFiles(fileSet.files, 'path/to/out', base: sourceDir.path);
}
```

The `base` parameter is used to customize the resulting file tree in the destination directory.
It is treated as a base path that is stripped from the computed path of the destination files:

```dart
// Will create the file "out/src/script.php".
compressFiles(['src/script.php'], 'out');

// Will create the file "out/script.php": the "src/" component was removed.
compressFiles(['src/script.php'], 'out', base: 'src');
```

## Options
All functions also support the following optional named parameters:

### String **binary** = `"php"`
The functions rely on the availability of the [PHP](https://secure.php.net) executable on the target system. By default, the functions will use the `php` binary found on the system path.

If a function cannot find the default `php` binary, or if you want to use a different one, you can provide the path to the `php` executable by using the `binary` option:

```dart
compressFile('path/to/src', 'path/to/out', binary: r'C:\Program Files\PHP\php.exe');
```

### TransformMode **mode** = `TransformMode.safe`
The functions can work in two manners, which can be selected using the `mode` option:

- the `safe` mode: as its name implies, this mode is very reliable. But it is also very slow as it spawns a new PHP process for every file to be processed. This is the default mode.
- the `fast` mode: as its name implies, this mode is very fast, but it is not very reliable. It spawns a PHP web server that processes the input files, but on some systems this fails. This mode requires a [PHP](https://secure.php.net) runtime version **7.2 or later**.

```dart
compressFile('path/to/src', 'path/to/out', mode: TransformMode.fast);
```

### bool **silent** = `false`
By default, the functions print to the standard output the paths of the minified scripts. You can disable this output by setting the `silent` option to `true`.

```dart
compressFile('path/to/src', 'path/to/out', silent: true);
```
