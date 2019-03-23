@TestOn('vm')
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the [FastTransformer] class.
void main() => group('FastTransformer', () {
  group('.close()', () {
    final transformer = FastTransformer();

    test('should complete without any error', () async {
      await transformer.listen();
      expect(transformer.close(), completes);
    });

    test('should be callable multiple times', () {
      expect(transformer.close(), completes);
      expect(transformer.close(), completes);
    });
  });

  group('.listen()', () {
    final transformer = FastTransformer();
    tearDownAll(transformer.close);

    test('should complete without any error', () {
      expect(transformer.listen(), completes);
    });

    test('should be callable multiple times', () {
      expect(transformer.listen(), completes);
      expect(transformer.listen(), completes);
    });
  });

  group('.listening', () {
    final transformer = FastTransformer();

    test('should return whether the server is listening', () async {
      expect(transformer.listening, isFalse);

      await transformer.listen();
      expect(transformer.listening, isTrue);

      await transformer.close();
      expect(transformer.listening, isFalse);
    });
  });

  group('.transform()', () {
    final script = getFile('test/fixtures/sample.php');
    final transformer = FastTransformer();
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
