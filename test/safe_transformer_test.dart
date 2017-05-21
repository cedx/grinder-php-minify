import 'dart:io';
import 'package:grinder_php_minify/php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the [SafeTransformer] class.
void main() => group('SafeTransformer', () {
  group('.transform()', () {
    var script = new File('test/fixtures/sample.php');
    var transform = new SafeTransformer(new Minifier());

    test('should remove the inline comments', () async {
      var output = await transform(script);
      expect(output, contains("<?= 'Hello World!' ?>"));
    });

    test('should remove the multi-line comments', () async {
      var output = await transform(script);
      expect(output, contains('namespace dummy; class Dummy'));
    });

    test('should remove the single-line comments', () async {
      var output = await transform(script);
      expect(output, contains(r'$className = get_class($this); return $className;'));
    });

    test('should remove the whitespace', () async {
      var output = await transform(script);
      expect(output, contains('__construct() { }'));
    });
  });
});
