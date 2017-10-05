import 'fast_transformer_test.dart' as fast_transformer_test;
import 'minifier_test.dart' as minifier_test;
import 'php_minify_test.dart' as php_minify_test;
import 'safe_transformer_test.dart' as safe_transformer_test;

/// Tests all the features of the package.
void main() {
  fast_transformer_test.main();
  minifier_test.main();
  php_minify_test.main();
  safe_transformer_test.main();
}
