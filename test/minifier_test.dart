import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the [Minifier] class.
void main() => group('Minifier', () {
  group('.processDirectory()', () {
    var minifier = new Minifier(silent: true);
    var testDir = getDir('var/test/processDirectory');
    tearDownAll(minifier.transformer.close);

    test('should remove the comments and whitespace from the scripts of a directory', () async {
      var output = joinFile(testDir, ['sample.php']);
      await minifier.processDirectory(getDir('test/fixtures'), testDir);
      expect(await output.readAsString(), allOf(
        contains("<?= 'Hello World!' ?>"),
        contains('namespace dummy; class Dummy'),
        contains(r'$className = get_class($this); return $className;'),
        contains('__construct() { }')
      ));
    });
  });

  group('.processFile()', () {
    var minifier = new Minifier(silent: true);
    var testDir = getDir('var/test/processFile');
    tearDownAll(minifier.transformer.close);

    test('should remove the comments and whitespace from a file', () async {
      var output = joinFile(testDir, ['sample.php']);
      await minifier.processFile(getFile('test/fixtures/sample.php'), output);
      expect(await output.readAsString(), allOf(
        contains("<?= 'Hello World!' ?>"),
        contains('namespace dummy; class Dummy'),
        contains(r'$className = get_class($this); return $className;'),
        contains('__construct() { }')
      ));
    });
  });
});
