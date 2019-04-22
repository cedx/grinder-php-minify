@TestOn('vm')
import 'package:test/test.dart';
import 'factory_test.dart' as factory_test;
import 'fast_transformer_test.dart' as fast_transformer_test;
import 'minifier_test.dart' as minifier_test;
import 'safe_transformer_test.dart' as safe_transformer_test;

/// Tests all the features of the package.
void main() {
  safe_transformer_test.main();
  fast_transformer_test.main();

  minifier_test.main();
  factory_test.main();
}
