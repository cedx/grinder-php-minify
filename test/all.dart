import 'fast_transformer_test.dart' as fast_transformer_test;
import 'functions_test.dart' as functions_test;
import 'minifier_test.dart' as minifier_test;
import 'safe_transformer_test.dart' as safe_transformer_test;

/// Tests all the features of the package.
void main() {
  fast_transformer_test.main();
  minifier_test.main();
  safe_transformer_test.main();
}
