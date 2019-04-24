import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the [Minifier] class.
void main() => group('Minifier', () {
  group('.compressDirectory()', () {
    final testDir = getDir('var/test/Minifier.compressDirectory');
    final output = joinFile(testDir, ['sample.php']);

    test('should remove the comments and whitespace from the scripts of a directory', () async {
      await Minifier().compressDirectory(getDir('test/fixtures'), testDir);
      expect(await output.readAsString(), allOf(
        contains("<?= 'Hello World!' ?>"),
        contains('namespace dummy; class Dummy'),
        contains(r'$className = get_class($this); return $className;'),
        contains('__construct() { }')
      ));
    });
  });

  group('.compressFile()', () {
    final testDir = getDir('var/test/Minifier.compressFile');
    final output = joinFile(testDir, ['sample.php']);

    test('should remove the comments and whitespace from a file', () async {
      await Minifier().compressFile(getFile('test/fixtures/sample.php'), output);
      expect(await output.readAsString(), allOf(
        contains("<?= 'Hello World!' ?>"),
        contains('namespace dummy; class Dummy'),
        contains(r'$className = get_class($this); return $className;'),
        contains('__construct() { }')
      ));
    });
  });

  group('.compressFiles()', () {
    final testDir = getDir('var/test/Minifier.compressFiles');
    final output = joinFile(testDir, ['sample.php']);

    test('should remove the comments and whitespace from a set of files', () async {
      await Minifier().compressFiles([getFile('test/fixtures/sample.php')], testDir, base: 'test/fixtures');
      expect(await output.readAsString(), allOf(
        contains("<?= 'Hello World!' ?>"),
        contains('namespace dummy; class Dummy'),
        contains(r'$className = get_class($this); return $className;'),
        contains('__construct() { }')
      ));
    });
  });
});
