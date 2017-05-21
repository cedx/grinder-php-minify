import 'package:grinder_php_minify/php_minify.dart';
import 'package:test/test.dart';

/// Tests the features of the [SafeTransformer] class.
void main() => group('SafeTransformer', () {
  group('.transform()', () {
    var script = new File('test/fixtures/sample.php');
    var transformer = new SafeTransformer(new Minifier);

    test('should TODO', () {
    });
  });
});
