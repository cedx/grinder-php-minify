import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the [phpMinify] function.
void main() => group('phpMinify()', () {
  test('should remove the comments and whitespace using the fast transformer', () async {
    const testDir = 'var/test/phpMinify.fast';
    await phpMinify('test/**.php', testDir, base: 'test/fixtures', mode: TransformMode.fast, silent: true);
    expect(await joinFile(getDir(testDir), ['sample.php']).readAsString(), allOf(
      contains("<?= 'Hello World!' ?>"),
      contains('namespace dummy; class Dummy'),
      contains(r'$className = get_class($this); return $className;'),
      contains('__construct() { }')
    ));
  });

  test('should remove the comments and whitespace using the safe transformer', () async {
    const testDir = 'var/test/phpMinify.safe';
    await phpMinify('test/**.php', testDir, base: 'test/fixtures', mode: TransformMode.safe, silent: true);
    expect(await joinFile(getDir(testDir), ['sample.php']).readAsString(), allOf(
      contains("<?= 'Hello World!' ?>"),
      contains('namespace dummy; class Dummy'),
      contains(r'$className = get_class($this); return $className;'),
      contains('__construct() { }')
    ));
  });
});
