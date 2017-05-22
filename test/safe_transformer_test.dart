import 'dart:io';
import 'package:grinder_php_minify/php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the [SafeTransformer] class.
void main() => group('SafeTransformer', () {
  group('.call()', () {
    var script = new File('test/fixtures/sample.php');
    var transform = new SafeTransformer(new Minifier());

    test('should remove the inline comments', () async {
      expect(await transform(script), contains("<?= 'Hello World!' ?>"));
    });

    test('should remove the multi-line comments', () async {
      expect(await transform(script), contains('namespace dummy; class Dummy'));
    });

    test('should remove the single-line comments', () async {
      expect(await transform(script), contains(r'$className = get_class($this); return $className;'));
    });

    test('should remove the whitespace', () async {
      expect(await transform(script), contains('__construct() { }'));
    });
  });
});
