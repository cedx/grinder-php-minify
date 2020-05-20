import "package:glob/glob.dart";
import "package:grinder/grinder.dart";
import "package:grinder_php_minify/grinder_php_minify.dart";
import "package:test/test.dart";

/// Tests the features of the [Minifier] class.
void main() => group("Minifier", () {
	group(".run()", () {
		test("should remove the comments and whitespace using the fast transformer", () async {
			final testDir = getDir("var/test/Minifier.run.fast");
			await Minifier(mode: TransformMode.fast, silent: true).run([Glob("test/**.php")], testDir, base: "test/fixtures");
			expect(await joinFile(testDir, ["sample.php"]).readAsString(), allOf(
				contains("<?= 'Hello World!' ?>"),
				contains("namespace dummy; class Dummy"),
				contains(r"$className = get_class($this); return $className;"),
				contains("__construct() { }")
			));
		});

		test("should remove the comments and whitespace using the safe transformer", () async {
			final testDir = getDir("var/test/Minifier.run.safe");
			await Minifier(mode: TransformMode.safe, silent: true).run([Glob("test/**.php")], testDir, base: "test/fixtures");
			expect(await joinFile(testDir, ["sample.php"]).readAsString(), allOf(
				contains("<?= 'Hello World!' ?>"),
				contains("namespace dummy; class Dummy"),
				contains(r"$className = get_class($this); return $className;"),
				contains("__construct() { }")
			));
		});
	});
});
