@TestOn('vm')
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the [SafeTransformer] class.
void main() => group('SafeTransformer', () {
  group('.close()', () {
    final transformer = SafeTransformer();

    test('should complete without any error', () {
      expect(transformer.close(), completes);
    });

    test('should be callable multiple times', () {
      expect(transformer.close(), completes);
      expect(transformer.close(), completes);
    });
  });

  group('.transform()', () {
    final script = getFile('test/fixtures/sample.php');
    final transformer = SafeTransformer();
    tearDownAll(transformer.close);

    test('should remove the inline comments', () async {
      expect(await transformer.transform(script), contains("<?= 'Hello World!' ?>"));
    });

    test('should remove the multi-line comments', () async {
      expect(await transformer.transform(script), contains('namespace dummy; class Dummy'));
    });

    test('should remove the single-line comments', () async {
      expect(await transformer.transform(script), contains(r'$className = get_class($this); return $className;'));
    });

    test('should remove the whitespace', () async {
      expect(await transformer.transform(script), contains('__construct() { }'));
    });
  });
});
