# Usage
If you haven't used [Grinder](https://github.com/google/grinder.dart) before, be sure to check out the [related documentation](https://google.github.io/grinder.dart), as it explains how to create a `grind.dart` file and to define project tasks. Once you're familiar with that process, you may install the plug-in.

## Programming interface
The plug-in provides a single function, `compress()`, that take one or several [PHP](https://secure.php.net) scripts as input, and remove the comments and whitespace in this file by applying the [`php_strip_whitespace()`](https://secure.php.net/manual/en/function.php-strip-whitespace.php) function on their contents.
    
### Future&lt;void&gt; **compress**(FileSystemEntity source, FileSystemEntity destination)
Minifies the PHP files of a given source directory and saves the resulting output to a destination directory:

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' as php_minify;

@Task('Compress the PHP scripts from a given directory')
Future<void> compressDirectory() =>
  php_minify.compress(getDir('path/to/src'), getDir('path/to/out'));
```

Minifies a single PHP source file and saves the resulting output to a given destination file:

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' as php_minify;

@Task('Compress a given PHP script')
Future<void> compressFile() =>
  php_minify.compress(getFile('path/to/src.php'), getFile('path/to/out.php'));
```

## Options
The `compress()` function also support the following optional named parameters:

### String **base**
When the source input is a directory, the `base` parameter is used to customize the resulting file tree in the destination directory. It is treated as a base path that is stripped from the computed path of the destination files:

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' as php_minify;

@Task() Future<void> compressPhp() {
  // Given the script "src/subdir/script.php"...
  
  php_minify.compress(getDir('src'), getDir('out1'));
  // ... will create the file "out1/subdir/script.php".

  php_minify.compress(getDir('src'), getDir('out2'), base: 'src/subdir');
  // ... will create the file "out2/script.php": the "subdir/" component was removed.
}
```

### String **binary** = `"php"`
The `compress()` function rely on the availability of the [PHP](https://secure.php.net) executable on the target system. By default, the `compress()` function will use the `php` binary found on the system path.

If the function cannot find the default `php` binary, or if you want to use a different one, you can provide the path to the `php` executable by using the `binary` option:

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' as php_minify;

@Task() Future<void> compressPhp() =>
  php_minify.compress(getDir('src'), getDir('out'), binary: r'C:\Program Files\PHP\php.exe');
```

### TransformMode **mode** = `TransformMode.safe`
The `compress()` function can work in two manners, which can be selected using the `mode` option:

- the `safe` mode: as its name implies, this mode is very reliable. But it is also very slow as it spawns a new PHP process for every file to be processed. This is the default mode.
- the `fast` mode: as its name implies, this mode is very fast, but it is not very reliable. It spawns a PHP web server that processes the input files, but on some systems this fails. This mode requires a [PHP](https://secure.php.net) runtime version **7.2 or later**.

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' as php_minify;

@Task() Future<void> compressPhp() =>
  php_minify.compress(getDir('src'), getDir('out'), mode: TransformMode.fast);
```

### String **pattern** = `"*.php"`
When the `compress()` function processes a directory, a filter is applied on the names of the processed files to determine whether they are PHP scripts. A filename pattern is used to match the eligible PHP scripts, by default it's set to `"*.php"`. You can change use the `pattern` option to select a different set of PHP scripts:

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' as php_minify;

@Task() Future<void> compressPhp() =>
  php_minify.compress(getDir('src'), getDir('out'), pattern: '*.inc.php7');
```

### bool **recurse** = `true`
The source directories are scanned recursively. You can force the `compress()` function to only process the files located at the root of the source directory by setting the `recurse` option to `false`:

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' as php_minify;

@Task() Future<void> compressPhp() =>
  php_minify.compress(getDir('src'), getDir('out'), recurse: false);
```

### bool **silent** = `false`
By default, the `compress()` function print to the standard output the paths of the minified scripts. You can disable this output by setting the `silent` option to `true`.

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' as php_minify;

@Task() Future<void> compressPhp() =>
  php_minify.compress(getDir('src'), getDir('out'), silent: true);
```
