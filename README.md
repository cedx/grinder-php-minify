# Grinder-PHP-Minify
![Runtime](https://img.shields.io/badge/dart-%3E%3D1.23-brightgreen.svg) ![Release](https://img.shields.io/pub/v/grinder_php_minify.svg) ![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg) ![Coverage](https://coveralls.io/repos/github/cedx/grinder-php-minify.dart/badge.svg) ![Build](https://travis-ci.org/cedx/grinder-php-minify.dart.svg)

TODO

## Getting started
If you haven't used Grinder before, be sure to check out the [related documentation](https://google.github.io/grinder.dart), as it explains how to create a `grind.dart` file and to define project tasks. Once you're familiar with that process, you may install this plug-in.

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

## Usage
The plug-in takes a list of [PHP](https://secure.php.net) scripts as input, and removes the comments and whitespace in these files by applying the [`php_strip_whitespace()`](https://secure.php.net/manual/en/function.php-strip-whitespace.php) function on their contents:

```dart
phpMinify('path/to/src', 'path/to/out');
```

## Options

### `binary`
The plug-in relies on the availability of the [PHP](https://secure.php.net) executable on the target system. By default, the plug-in will use the `php` binary found on the system path.

If the plug-in cannot find the default `php` binary, or if you want to use a different one, you can provide the path to the `php` executable by using the `binary` option:

```dart
phpMinify('path/to/src', 'path/to/out', binary: r'C:\Program Files\PHP\php.exe');
```

### `mode`
The plug-in can work in two manners, which can be selected using the `mode` option:

- the `safe` mode: as its name implies, this mode is very reliable. But it is also very slow as it spawns a new PHP process for every file to be processed. This is the default mode.
- the `fast` mode: as its name implies, this mode is very fast, but it is not very reliable. It spawns a PHP web server that processes the input files, but on some systems this fails. This mode requires a [PHP](https://secure.php.net) runtime version **7.0 or later**.

```dart
phpMinify('path/to/src', 'path/to/out', mode: 'fast');
```

### `silent`
By default, the plug-in prints to the standard output the paths of the minified scripts. You can disable this output by setting the `silent` option to `true`.

```dart
phpMinify('path/to/src', 'path/to/out', silent: true);
```

## See also
- [API reference](https://cedx.github.io/grinder-php-minify)
- [Code coverage](https://coveralls.io/github/cedx/grinder-php-minify)
- [Continuous integration](https://travis-ci.org/cedx/grinder-php-minify)

## License
[Grinder-PHP-Minify](https://github.com/cedx/grinder-php-minify) is distributed under the Apache License, version 2.0.
