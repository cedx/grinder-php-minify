import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the functions.
void main() {
  group('compressDirectory()', () {
    var testDir = getDir('var/test/compressDirectory');
    var output = joinFile(testDir, ['sample.php']);

    test('should remove the comments and whitespace from the scripts of a directory', () async {
      await compressDirectory('test/fixtures', testDir.path, mode: 'fast', silent: true);
      expect(await output.readAsString(), allOf(
        contains("<?= 'Hello World!' ?>"),
        contains('namespace dummy; class Dummy'),
        contains(r'$className = get_class($this); return $className;'),
        contains('__construct() { }')
      ));
    });
  });

  group('compressFile()', () {
    var testDir = getDir('var/test/compressFile');
    var output = joinFile(testDir, ['sample.php']);

    test('should remove the comments and whitespace from a file', () async {
      await compressFile('test/fixtures/sample.php', output.path, mode: 'safe', silent: true);
      expect(await output.readAsString(), allOf(
        contains("<?= 'Hello World!' ?>"),
        contains('namespace dummy; class Dummy'),
        contains(r'$className = get_class($this); return $className;'),
        contains('__construct() { }')
      ));
    });
  });

  group('compressFiles()', () {
    var testDir = getDir('var/test/compressFiles');
    var output = joinFile(testDir, ['sample.php']);

    test('should remove the comments and whitespace from a set of files', () async {
      await compressFiles(<String>['test/fixtures/sample.php'], testDir.path, base: 'test/fixtures', silent: true);
      expect(await output.readAsString(), allOf(
        contains("<?= 'Hello World!' ?>"),
        contains('namespace dummy; class Dummy'),
        contains(r'$className = get_class($this); return $className;'),
        contains('__construct() { }')
      ));
    });
  });
}
