# Grinder-PHP-Minify
![Runtime](https://img.shields.io/badge/dart-%3E%3D1.23-brightgreen.svg) ![Release](https://img.shields.io/pub/v/grinder_php_minify.svg) ![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg) ![Coverage](https://coveralls.io/repos/github/cedx/grinder-php-minify/badge.svg) ![Build](https://travis-ci.org/cedx/grinder-php-minify.svg)

[Grinder](https://google.github.io/grinder.dart) plug-in minifying [PHP](https://secure.php.net) source code by removing comments and whitespace.

## Getting started
If you haven't used [Grinder](https://github.com/google/grinder.dart) before, be sure to check out the [related documentation](https://google.github.io/grinder.dart), as it explains how to create a `grind.dart` file and to define project tasks. Once you're familiar with that process, you may install this plug-in.

## Installing via [Pub](https://pub.dartlang.org)

### 1. Depend on it
Add this to your package's `pubspec.yaml` file:

```yaml
devDpendencies:
  grinder_php_minify: *
```

### 2. Install it
Install this package and its dependencies from a command prompt:

```shell
$ pub get
```

Once the plug-in has been installed, it may be enabled inside your `grind.dart` file:

```dart
import 'package:grinder_php_minify/php_minify.dart' as php_minify;
```

## Usage
The plug-in takes a list of [PHP](https://secure.php.net) scripts as input, and removes the comments and whitespace in these files by applying the [`php_strip_whitespace()`](https://secure.php.net/manual/en/function.php-strip-whitespace.php) function on their contents.

Two functions are dedicated to this feature:
- `compress()`: minifies the PHP files of a given source directory and saves the resulting output to a destination directory.
- `compressFile()`: minifies a single PHP source file and saves the resulting output to a given destination file.

Their usage is the same, only their options differ:

```dart
import 'dart:async';
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/php_minify.dart' as php_minify;

@Task('Compress the PHP scripts from a given directory recursively')
Future phpDirectory() => php_minify.compress('path/to/src', 'path/to/out');

@Task('Compress a given PHP script')
Future phpFile() => php_minify.compressFile('path/to/src/file.php', 'path/to/out/file.php');
```

## Common options
These options are shared by the two functions: `compress()` and `compressFile()`.

### `binary`
The plug-in relies on the availability of the [PHP](https://secure.php.net) executable on the target system. By default, the plug-in will use the `php` binary found on the system path.

If the plug-in cannot find the default `php` binary, or if you want to use a different one, you can provide the path to the `php` executable by using the `binary` option:

```dart
php_minify.compress('path/to/src', 'path/to/out', binary: r'C:\Program Files\PHP\php.exe');
php_minify.compressFile('path/to/src/file.php', 'path/to/out/file.php', binary: r'C:\Program Files\PHP\php.exe');
```

### `mode`
The plug-in can work in two manners, which can be selected using the `mode` option:

- the `safe` mode: as its name implies, this mode is very reliable. But it is also very slow as it spawns a new PHP process for every file to be processed. This is the default mode.
- the `fast` mode: as its name implies, this mode is very fast, but it is not very reliable. It spawns a PHP web server that processes the input files, but on some systems this fails. This mode requires a [PHP](https://secure.php.net) runtime version **7.0 or later**.

```dart
php_minify.compress('path/to/src', 'path/to/out', mode: 'fast');
php_minify.compressFile('path/to/src/file.php', 'path/to/out/file.php', mode: 'fast');
```

### `silent`
By default, the plug-in prints to the standard output the paths of the minified scripts. You can disable this output by setting the `silent` option to `true`.

```dart
php_minify.compress('path/to/src', 'path/to/out', silent: true);
php_minify.compressFile('path/to/src/file.php', 'path/to/out/file.php', silent: true);
```

## Directory options
These options are specific to the `compress()` function.

### `pattern`
When processing a directory, a filter is applied on the names of the processed files to determine whether they are PHP scripts. A filename pattern is used to match the eligible PHP scripts.

By default, it's set to `"*.php"`. You can change this pattern to select a different set of PHP scripts:

```dart
php_minify.compress('path/to/src', 'path/to/out', pattern: '*.inc.php7');
```

### `recurse`
By default, a source directory is scanned recursively. You can force the minifier to only process the files located at the root of the source directory by setting the `recurse` option to `false`.

```dart
php_minify.compress('path/to/src', 'path/to/out', recurse: false);
```

## See also
- [API reference](https://cedx.github.io/grinder-php-minify)
- [Code coverage](https://coveralls.io/github/cedx/grinder-php-minify)
- [Continuous integration](https://travis-ci.org/cedx/grinder-php-minify)

## License
[Grinder-PHP-Minify](https://github.com/cedx/grinder-php-minify) is distributed under the Apache License, version 2.0.
