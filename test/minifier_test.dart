import 'package:glob/glob.dart';
import 'package:grinder/grinder.dart';
import 'package:grinder_php_minify/grinder_php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the [Minifier] class.
void main() => group('Minifier', () {
  group('.run()', () {
    final testDir = getDir('var/test/Minifier.run');
    final output = joinFile(testDir, ['sample.php']);

    test('should remove the comments and whitespace from a set of files', () async {
      await Minifier().run([Glob('test/**.php')], testDir, base: 'test/fixtures');
      expect(await output.readAsString(), allOf(
        contains("<?= 'Hello World!' ?>"),
        contains('namespace dummy; class Dummy'),
        contains(r'$className = get_class($this); return $className;'),
        contains('__construct() { }')
      ));
    });
  });
});
