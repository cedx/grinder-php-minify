part of "../grinder_php_minify.dart";

/// Removes comments and whitespace from a PHP script.
abstract class Transformer {

	/// Creates a new transformer from the specified [mode], optionaly using the given PHP [executable].
	factory Transformer(TransformMode mode, {String executable = "php"}) =>
		mode == TransformMode.fast ? FastTransformer(executable) : SafeTransformer(executable);

	/// Closes this transformer and releases any resources associated with it.
	Future<void> close();

	/// Processes the specified PHP [script] and returns its contents minified.
	Future<String> transform(File script);
}
