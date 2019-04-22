@TestOn('vm')
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the functions.
void main() => group('compress()', () {
  test('should remove the comments and whitespace from the scripts of a directory', () async {
    final testDir = getDir('var/test/compress.directory');
    await compress(getDir('test/fixtures'), testDir, mode: TransformMode.fast, silent: true);
    expect(await joinFile(testDir, ['sample.php']).readAsString(), allOf(
      contains("<?= 'Hello World!' ?>"),
      contains('namespace dummy; class Dummy'),
      contains(r'$className = get_class($this); return $className;'),
      contains('__construct() { }')
    ));
  });

  test('should remove the comments and whitespace from a file', () async {
    final output = joinFile(getDir('var/test/compress.file'), ['sample.php']);
    await compress(getFile('test/fixtures/sample.php'), output, mode: TransformMode.safe, silent: true);
    expect(await output.readAsString(), allOf(
      contains("<?= 'Hello World!' ?>"),
      contains('namespace dummy; class Dummy'),
      contains(r'$className = get_class($this); return $className;'),
      contains('__construct() { }')
    ));
  });

  test('should remove the comments and whitespace from a set of files', () async {
    final testDir = getDir('var/test/compress.files');
    await compress(getDir('test/fixtures'), testDir, base: 'test/fixtures', pattern: 'sample.php', silent: true);
    expect(await joinFile(testDir, ['sample.php']).readAsString(), allOf(
      contains("<?= 'Hello World!' ?>"),
      contains('namespace dummy; class Dummy'),
      contains(r'$className = get_class($this); return $className;'),
      contains('__construct() { }')
    ));
  });
});
