import "dart:io";
import "package:grinder/grinder.dart";
import "package:grinder_php_minify/grinder_php_minify.dart";

@Task("Compresses a given set of PHP scripts")
Future<void> compressPhp() => phpMinify(
	"path/to/src/**.php",
	"path/to/out",
	base: "path/to/src",
	binary: Platform.isWindows ? r"C:\Program Files\PHP\php.exe" : "/usr/bin/php",
	mode: Platform.isWindows ? TransformMode.safe : TransformMode.fast,
	silent: stdout.hasTerminal
);
