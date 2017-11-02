import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the [phpMinify] function.
void main() => group('phpMinify()', () {
  var testDir = getDir('var/test/phpMinify');
  var output = joinFile(testDir, const ['sample.php']);

  test('should remove the comments and whitespace from the scripts of a directory', () async {
    await phpMinify('test/fixtures', testDir.path, silent: true);
    expect(await output.readAsString(), allOf(
      contains("<?= 'Hello World!' ?>"),
      contains('namespace dummy; class Dummy'),
      contains(r'$className = get_class($this); return $className;'),
      contains('__construct() { }')
    ));
  });

  test('should remove the comments and whitespace from a file', () async {
    await phpMinify('test/fixtures/sample.php', testDir.path, silent: true);
    expect(await output.readAsString(), allOf(
      contains("<?= 'Hello World!' ?>"),
      contains('namespace dummy; class Dummy'),
      contains(r'$className = get_class($this); return $className;'),
      contains('__construct() { }')
    ));
  });
});
