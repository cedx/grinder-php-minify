import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the [Minifier] class.
void main() => group('Minifier', () {
  group('.compressDirectory()', () {
    var testDir = getDir('var/test/Minifier.compressDirectory');
    var output = joinFile(testDir, const ['sample.php']);

    test('should remove the comments and whitespace from the scripts of a directory', () async {
      await Minifier(silent: true).compressDirectory(getDir('test/fixtures'), testDir);
      expect(await output.readAsString(), allOf(
        contains("<?= 'Hello World!' ?>"),
        contains('namespace dummy; class Dummy'),
        contains(r'$className = get_class($this); return $className;'),
        contains('__construct() { }')
      ));
    });
  });

  group('.compressFile()', () {
    var testDir = getDir('var/test/Minifier.compressFile');
    var output = joinFile(testDir, const ['sample.php']);

    test('should remove the comments and whitespace from a file', () async {
      await Minifier(silent: true).compressFile(getFile('test/fixtures/sample.php'), output);
      expect(await output.readAsString(), allOf(
        contains("<?= 'Hello World!' ?>"),
        contains('namespace dummy; class Dummy'),
        contains(r'$className = get_class($this); return $className;'),
        contains('__construct() { }')
      ));
    });
  });

  group('.compressFiles()', () {
    var testDir = getDir('var/test/Minifier.compressFiles');
    var output = joinFile(testDir, const ['sample.php']);

    test('should remove the comments and whitespace from a set of files', () async {
      await Minifier(silent: true).compressFiles([getFile('test/fixtures/sample.php')], testDir, base: 'test/fixtures');
      expect(await output.readAsString(), allOf(
        contains("<?= 'Hello World!' ?>"),
        contains('namespace dummy; class Dummy'),
        contains(r'$className = get_class($this); return $className;'),
        contains('__construct() { }')
      ));
    });
  });
});
