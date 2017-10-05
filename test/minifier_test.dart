import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the [Minifier] class.
void main() => group('Minifier', () {
  group('.transformer', () {
    var script = getFile('test/fixtures/sample.php');
    var minifier = new Minifier(silent: true);
    tearDownAll(() => minifier.transformer.close());

    test('should remove the inline comments', () async {
      expect(await minifier.transformer.transform(script), contains("<?= 'Hello World!' ?>"));
    });

    test('should remove the multi-line comments', () async {
      expect(await minifier.transformer.transform(script), contains('namespace dummy; class Dummy'));
    });

    test('should remove the single-line comments', () async {
      expect(await minifier.transformer.transform(script), contains(r'$className = get_class($this); return $className;'));
    });

    test('should remove the whitespace', () async {
      expect(await minifier.transformer.transform(script), contains('__construct() { }'));
    });
  });
});
