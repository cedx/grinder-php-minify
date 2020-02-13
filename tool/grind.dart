import 'package:grinder/grinder.dart';

/// Starts the build system.
Future main(List<String> args) => grind(args);

@Task('Deletes all generated files and reset any saved state')
void clean() {
  defaultClean();
  delete(getFile('var/lcov.info'));
  ['.dart_tool/build', 'var/test', webDir.path].map(getDir).forEach(delete);
}

@Task('Uploads the results of the code coverage')
void coverage() {
  final arguments = ['--in=var/test', '--lcov', '--out=var/lcov.info', '--packages=.packages', '--report-on=lib'];
  Pub.run('coverage', script: 'format_coverage', arguments: arguments);
  Pub.run('coveralls', arguments: ['var/lcov.info']);
}

@Task('Builds the documentation')
Future<void> doc() async {
  for (final path in ['CHANGELOG.md', 'LICENSE.md']) await getFile(path).copy('doc/about/${path.toLowerCase()}');
  run('mkdocs', arguments: ['build', '--config-file=doc/mkdocs.yaml']);
  ['doc/about/changelog.md', 'doc/about/license.md', '${webDir.path}/mkdocs.yaml'].map(getFile).forEach(delete);
}

@Task('Fixes the coding standards issues')
void fix() => DartFmt.format(existingSourceDirs);

@Task('Performs the static analysis of source code')
void lint() => Analyzer.analyze(existingSourceDirs);

@Task('Publishes the package to the registry')
@Depends(clean, fix)
void publish() => run('pub', arguments: ['publish', '--force'], runOptions: RunOptions(runInShell: true));

@Task('Starts the development server')
Future<void> serve() => runAsync('php', arguments: ['-S', '127.0.0.1:8000', '-t', '${libDir.path}/php']);

@Task('Runs the test suites')
void test() => Pub.run('test', arguments: ['--coverage=var']);

@Task('Upgrades the project to the latest revision')
void upgrade() {
  run('git', arguments: ['reset', '--hard']);
  run('git', arguments: ['fetch', '--all', '--prune']);
  run('git', arguments: ['pull', '--rebase']);
  Pub.upgrade();
}
