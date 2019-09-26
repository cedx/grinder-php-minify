# Usage
If you haven't used [Grinder](https://github.com/google/grinder.dart) before, be sure to check out the [related documentation](https://google.github.io/grinder.dart), as it explains how to create a `grind.dart` file and to define project tasks. Once you're familiar with that process, you may install the plug-in.

## Programming interface
The plug-in provides a single function, `phpMinify()`, that takes a list of [PHP](https://www.php.net) scripts as input, and remove the comments and whitespace in these files by applying the [`php_strip_whitespace()`](https://www.php.net/manual/en/function.php-strip-whitespace.php) function on their contents.
    
### Future&lt;void&gt; **phpMinify**(dynamic patterns, dynamic destination)
Minifies the PHP scripts corresponding to the specified file patterns, and saves the resulting output to a destination directory:

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';

@Task() Future<void> compressPhp() =>
  phpMinify('path/to/src/**.php', 'path/to/out');
```

The file patterns use the same syntax as the [`glob` package](https://pub.dev/packages/glob).

!!! tip
    You can provide several file patterns to the `phpMinify()` function:
    the `patterns` parameter can be a `String` (single pattern) or a `List<String>` (multiple patterns).  
    The path to the destination directory can be provided as a `String` or as a [`Directory`](https://api.dartlang.org/stable/dart-io/Directory-class.html) instance.

## Options
The `phpMinify()` function also support the following optional named parameters:

### String **base**
The `base` parameter is used to customize the resulting file tree in the destination directory. It is treated as a base path that is stripped from the computed path of the destination files:

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';

@Task() Future<void> compressPhp() async {
  // Given the script "src/subdir/script.php"...
  
  await phpMinify('src/**.php', 'out1');
  // ...will create the file "out1/src/subdir/script.php".

  await phpMinify('src/**.php', 'out2', base: 'src/subdir');
  // ...will create the file "out2/script.php": the "src/subdir/" component was removed.
}
```

### String **binary** = `"php"`
The `phpMinify()` function relies on the availability of the [PHP](https://www.php.net) executable on the target system. By default, the `phpMinify()` function will use the `php` binary found on the system path.

If the function cannot find the default `php` binary, or if you want to use a different one, you can provide the path to the `php` executable by using the `binary` option:

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';

@Task() Future<void> compressPhp() =>
  phpMinify('src/**.php', 'out', binary: r'C:\Program Files\PHP\php.exe');
```

### TransformMode **mode** = `TransformMode.safe`
The `phpMinify()` function can work in two manners, which can be selected using the `mode` option:

- the `safe` mode: as its name implies, this mode is very reliable. But it is also very slow as it spawns a new PHP process for every file to be processed. This is the default mode.
- the `fast` mode: as its name implies, this mode is very fast, but it is not very reliable. It spawns a PHP web server that processes the input files, but on some systems this fails. This mode requires a [PHP](https://www.php.net) runtime version **7.2 or later**.

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';

@Task() Future<void> compressPhp() =>
  phpMinify('src/**.php', 'out', mode: TransformMode.fast);
```

### bool **silent** = `false`
By default, the `phpMinify()` function prints to the standard output the paths of the minified scripts. You can disable this output by setting the `silent` option to `true`.

```dart
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';

@Task() Future<void> compressPhp() =>
  phpMinify('src/**.php', 'out', silent: true);
```
