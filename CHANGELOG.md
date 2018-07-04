# Changelog

## Version [3.0.0](https://github.com/cedx/grinder-php-minify/compare/v2.0.0...v3.0.0)
- Breaking change: starting to use and support the [Dart 2 SDK](https://www.dartlang.org/tools/sdk).
- Breaking change: raised the required [PHP](https://secure.php.net) version.
- Added a user guide based on [MkDocs](http://www.mkdocs.org).
- Using optional `const` and `new`.
- Using PHP 7.1 features, like void functions.
- Updated the package dependencies.

## Version [2.0.0](https://github.com/cedx/grinder-php-minify/compare/v1.0.1...v2.0.0)
- Breaking change: changed the signature of the `Minifier` and `Transformer` constructors.
- Breaking change: renamed the `Minifier.processDirectory()` method to `compressDirectory`.
- Breaking change: renamed the `Minifier.processFile()` method to `compressFile`.
- Breaking change: splitted the `phpMinify()` function into the `compressDirectory()`, `compressFile()` and `compressFiles()` functions.
- Added the `Minifier.compressFiles()` method.
- Added the `TransformMode` enumeration.

## Version [1.0.1](https://github.com/cedx/grinder-php-minify/compare/v1.0.0...v1.0.1)
- Fixed a bug with relative file paths.

## Version [1.0.0](https://github.com/cedx/grinder-php-minify/compare/v0.2.0...v1.0.0)
- Breaking change: changed the signature of most class constructors.
- Breaking change: merged the `compress()` and `compressFile()` functions into the `phpMinify()` function.
- Breaking change: raised the required [Dart](https://www.dartlang.org) version.
- Breaking change: removed the `binary` and `mode` properties from the `Minifier` class.
- Breaking change: the `Minifier.transformer` property is now `final`.
- Added a factory constructor to the `Transformer` class.
- Added new unit tests.
- Changed licensing for the [MIT License](https://opensource.org/licenses/MIT).
- Updated the package dependencies.

## Version [0.2.0](https://github.com/cedx/grinder-php-minify/compare/v0.1.0...v0.2.0)
- Breaking change: renamed the main script to `grinder_php_minify.dart`.

## Version 0.1.0
- Initial release.
