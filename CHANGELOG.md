# Changelog

## Version [6.2.0](https://git.belin.io/cedx/grinder-php-minify/compare/v6.1.0...v6.2.0)
- Updated the documentation.
- Updated the package dependencies.

## Version [6.1.0](https://git.belin.io/cedx/grinder-php-minify/compare/v6.0.0...v6.1.0)
- Raised the [Dart SDK](https://dart.dev/tools/sdk) constraint.
- Updated the package dependencies.

## Version [6.0.0](https://git.belin.io/cedx/grinder-php-minify/compare/v5.0.0...v6.0.0)
- Breaking change: renamed the `compress()` function to `phpMinify()`.
- Breaking change: renamed the `FastTransformer.defaultAddress` static property to `address`.
- Breaking change: replaced the `compressDirectory()`, `compressFile()` and `compressFiles()` methods from the `Minifier` class by the `run()` one.
- Breaking change: using [`glob`](https://pub.dev/packages/glob) patterns instead of `FileSystemEntity` parameters for providing the list of files to be processed.
- Raised the [Dart SDK](https://dart.dev/tools/sdk) constraint.
- Replaced [Travis CI](https://travis-ci.com) by [GitHub Actions](https://github.com/features/actions) for the continuous integration.
- Updated the package dependencies.

## Version [5.0.0](https://git.belin.io/cedx/grinder-php-minify/compare/v4.3.0...v5.0.0)
- Breaking change: merged all the functions into the `compress()` function.
- Raised the [Dart SDK](https://dart.dev/tools/sdk) constraint.
- Updated the package dependencies.

## Version [4.3.0](https://git.belin.io/cedx/grinder-php-minify/compare/v4.2.0...v4.3.0)
- Raised the [Dart SDK](https://dart.dev/tools/sdk) constraint.
- Updated the package dependencies.

## Version [4.2.0](https://git.belin.io/cedx/grinder-php-minify/compare/v4.1.0...v4.2.0)
- Updated the package dependencies.
- Updated the URL of the Git repository.

## Version [4.1.0](https://git.belin.io/cedx/grinder-php-minify/compare/v4.0.0...v4.1.0)
- Updated the package dependencies.

## Version [4.0.0](https://git.belin.io/cedx/grinder-php-minify/compare/v3.5.0...v4.0.0)
- Raised the [Dart SDK](https://dart.dev/tools/sdk) constraint.
- Updated the package dependencies.

## Version [3.5.0](https://git.belin.io/cedx/grinder-php-minify/compare/v3.4.0...v3.5.0)
- Updated the package dependencies.

## Version [3.4.0](https://git.belin.io/cedx/grinder-php-minify/compare/v3.3.0...v3.4.0)
- Updated the package dependencies.

## Version [3.3.0](https://git.belin.io/cedx/grinder-php-minify/compare/v3.2.0...v3.3.0)
- Updated the package dependencies.

## Version [3.2.0](https://git.belin.io/cedx/grinder-php-minify/compare/v3.1.0...v3.2.0)
- Raised the [Dart SDK](https://dart.dev/tools/sdk) constraint.
- Updated the package dependencies.

## Version [3.1.0](https://git.belin.io/cedx/grinder-php-minify/compare/v3.0.0...v3.1.0)
- Added an example code.
- Raised the [Dart SDK](https://dart.dev/tools/sdk) constraint.
- Updated the package dependencies.

## Version [3.0.0](https://git.belin.io/cedx/grinder-php-minify/compare/v2.0.0...v3.0.0)
- Breaking change: starting to use and support the [Dart 2 SDK](https://dart.dev/tools/sdk).
- Raised the required [PHP](https://www.php.net) version.
- Added a user guide based on [MkDocs](http://www.mkdocs.org).
- Using optional `const` and `new`.
- Using PHP 7.1 features, like void functions.
- Updated the package dependencies.

## Version [2.0.0](https://git.belin.io/cedx/grinder-php-minify/compare/v1.0.1...v2.0.0)
- Breaking change: changed the signature of the `Minifier` and `Transformer` constructors.
- Breaking change: renamed the `Minifier.processDirectory()` method to `compressDirectory`.
- Breaking change: renamed the `Minifier.processFile()` method to `compressFile`.
- Breaking change: splitted the `phpMinify()` function into the `compressDirectory()`, `compressFile()` and `compressFiles()` functions.
- Added the `Minifier.compressFiles()` method.
- Added the `TransformMode` enumeration.

## Version [1.0.1](https://git.belin.io/cedx/grinder-php-minify/compare/v1.0.0...v1.0.1)
- Fixed a bug with relative file paths.

## Version [1.0.0](https://git.belin.io/cedx/grinder-php-minify/compare/v0.2.0...v1.0.0)
- Breaking change: changed the signature of most class constructors.
- Breaking change: merged the `compress()` and `compressFile()` functions into the `phpMinify()` function.
- Raised the required [Dart](https://dart.dev) version.
- Breaking change: removed the `binary` and `mode` properties from the `Minifier` class.
- Breaking change: the `Minifier.transformer` property is now `final`.
- Added a factory constructor to the `Transformer` class.
- Added new unit tests.
- Changed licensing for the [MIT License](https://opensource.org/licenses/MIT).
- Updated the package dependencies.

## Version [0.2.0](https://git.belin.io/cedx/grinder-php-minify/compare/v0.1.0...v0.2.0)
- Breaking change: renamed the main script to `grinder_php_minify.dart`.

## Version 0.1.0
- Initial release.
