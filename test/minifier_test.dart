import 'dart:io';
import 'package:grinder_php_minify/php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the [Minifier] class.
void main() => group('Minifier', () {
  group('.mode', () {
    test('should be `safe` if the underlying transformer is a `SafeTransformer` one', () {
      var minifier = new Minifier();
      minifier.transform = new SafeTransformer(minifier);
      expect(minifier.mode, equals('safe'));
    });

    test('should be `fast` if the underlying transformer is a `FastTransformer` one', () {
      var minifier = new Minifier();
      minifier.transform = new FastTransformer(minifier);
      expect(minifier.mode, equals('fast'));
    });

    test('should change the underlying transformer on value update', () {
      var minifier = new Minifier();

      minifier.mode = 'fast';
      expect(minifier.transform, new isInstanceOf<FastTransformer>());

      minifier.mode = 'safe';
      expect(minifier.transform, new isInstanceOf<SafeTransformer>());
    });
  });

  group('.transform', () {
    var script = new File('test/fixtures/sample.php');
    var minifier = new Minifier()..silent = true;

    test('should remove the inline comments', () async {
      expect(await minifier.transform(script), contains("<?= 'Hello World!' ?>"));
    });

    test('should remove the multi-line comments', () async {
      expect(await minifier.transform(script), contains('namespace dummy; class Dummy'));
    });

    test('should remove the single-line comments', () async {
      expect(await minifier.transform(script), contains(r'$className = get_class($this); return $className;'));
    });

    test('should remove the whitespace', () async {
      expect(await minifier.transform(script), contains('__construct() { }'));
    });

    var transformer = minifier.transform as FastTransformer;
    if (transformer != null) transformer.close();
  });
});
