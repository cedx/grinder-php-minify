import 'dart:async';
import 'dart:io';
import 'package:grinder/grinder.dart';

/// The list of source directories.
final Iterable<Directory> _sources = sourceDirs.where((dir) => dir.existsSync());

/// Starts the build system.
Future main(List<String> args) => grind(args);

/// Deletes all generated files and reset any saved state.
@Task('Delete the generated files')
void clean() {
  defaultClean();
  new FileSet.fromDir(getDir('var'), pattern: '*.{info,json}').files.forEach(delete);
}

/// Uploads the code coverage report.
@Task('Upload the code coverage')
@Depends(test)
void coverage() => Pub.run('coveralls', arguments: const ['var/lcov.info']);

/// Builds the documentation.
@Task('Build the documentation')
void doc() {
  delete(getDir('doc/api'));
  DartDoc.doc();
}

/// Fixes the coding standards issues.
@Task('Fix the coding issues')
void fix() => DartFmt.format(_sources);

/// Performs static analysis of source code.
@Task('Perform the static analysis')
void lint() => Analyzer.analyze(_sources);

/// Runs all the test suites.
@DefaultTask('Run the tests')
Future test() async {
  await Future.wait([
    Dart.runAsync('test/all.dart', vmArgs: const ['--enable-vm-service', '--pause-isolates-on-exit']),
    Pub.runAsync('coverage', script: 'collect_coverage', arguments: const ['--out=var/coverage.json', '--resume-isolates', '--wait-paused'])
  ]);

  delete(getDir('var/test'));
  return Pub.runAsync('coverage', script: 'format_coverage', arguments: const [
    '--in=var/coverage.json',
    '--lcov',
    '--out=var/lcov.info',
    '--packages=.packages',
    '--report-on=lib'
  ]);
}
