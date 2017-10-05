import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the [compress] and [compressFile] functions.
void main() {
  group('compress()', () {
    var testDir = getDir('var/test/compress');
    tearDownAll(() => delete(testDir));

    test('should remove the comments and whitespace from the scripts of a directory', () async {
      var output = joinFile(testDir, ['sample.php']);
      await compress('test/fixtures', testDir.path, silent: true);
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
    tearDownAll(() => delete(testDir));

    test('should remove the comments and whitespace from a file', () async {
      var output = joinFile(testDir, ['sample.php']);
      await compressFile('test/fixtures/sample.php', output.path, silent: true);
      expect(await output.readAsString(), allOf(
        contains("<?= 'Hello World!' ?>"),
        contains('namespace dummy; class Dummy'),
        contains(r'$className = get_class($this); return $className;'),
        contains('__construct() { }')
      ));
    });
  });
}
