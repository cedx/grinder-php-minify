# Grinder-PHP-Minify
![Runtime](https://img.shields.io/badge/dart-%3E%3D1.24-brightgreen.svg) ![Release](https://img.shields.io/pub/v/grinder_php_minify.svg) ![License](https://img.shields.io/badge/license-MIT-blue.svg) ![Coverage](https://coveralls.io/repos/github/cedx/grinder-php-minify/badge.svg) ![Build](https://travis-ci.org/cedx/grinder-php-minify.svg)

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
import 'package:grinder_php_minify/grinder_php_minify.dart' show phpMinify;
```

## Usage
The plug-in provides a single function, `phpMinify()`, that takes a [PHP](https://secure.php.net) script as input, and removes the comments and whitespace in this file by applying the [`php_strip_whitespace()`](https://secure.php.net/manual/en/function.php-strip-whitespace.php) function on its contents.

The resulting string is saved to a given output directory:

```dart
import 'dart:async';
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart' show phpMinify;

@Task('Compress a given PHP script') 
Future compressPhp() => phpMinify('path/to/src/file.php', 'path/to/out'); 
```

The `phpMinify()` function can also recursively operate on the contents of a directory containing PHP scripts:

```dart
@Task('Compress the PHP scripts from a given directory')
Future compressPhp() => phpMinify('path/to/src', 'path/to/out', pattern: '*.php');
```

## Options

### `String binary = "php"`
The plug-in relies on the availability of the [PHP](https://secure.php.net) executable on the target system. By default, the plug-in will use the `php` binary found on the system path.

If the plug-in cannot find the default `php` binary, or if you want to use a different one, you can provide the path to the `php` executable by using the `binary` option:

```dart
phpMinify('path/to/src', 'path/to/out', binary: r'C:\Program Files\PHP\php.exe');
```

### `String mode = "safe"`
The plug-in can work in two manners, which can be selected using the `mode` option:

- the `safe` mode: as its name implies, this mode is very reliable. But it is also very slow as it spawns a new PHP process for every file to be processed. This is the default mode.
- the `fast` mode: as its name implies, this mode is very fast, but it is not very reliable. It spawns a PHP web server that processes the input files, but on some systems this fails. This mode requires a [PHP](https://secure.php.net) runtime version **7.0 or later**.

```dart
phpMinify('path/to/src', 'path/to/out', mode: 'fast');
```

### `String pattern = "*.php"`
When processing a directory, a filter is applied on the names of the processed files to determine whether they are PHP scripts.

By default, the filename pattern `"*.php"` is used to match the eligible PHP scripts.
You can change this pattern to select a different set of files:

```dart
phpMinify('path/to/src', 'path/to/out', pattern: '*.inc.php7');
```

### `bool recurse = true`
By default, a source directory is scanned recursively. You can force the minifier to only process the files located at the root of the source directory by setting the `recurse` option to `false`:

```dart
phpMinify('path/to/src', 'path/to/out', recurse: false);
```

### `bool silent = false`
By default, the plug-in prints to the standard output the paths of the minified scripts. You can disable this output by setting the `silent` option to `true`.

```dart
phpMinify('path/to/src', 'path/to/out', silent: true);
```

## See also
- [API reference](https://cedx.github.io/grinder-php-minify)
- [Code coverage](https://coveralls.io/github/cedx/grinder-php-minify)
- [Continuous integration](https://travis-ci.org/cedx/grinder-php-minify)

## License
[Grinder-PHP-Minify](https://github.com/cedx/grinder-php-minify) is distributed under the MIT License.
