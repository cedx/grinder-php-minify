part of '../grinder_php_minify.dart';

/// Removes comments and whitespace from a PHP script, by calling a Web service.
class FastTransformer implements Transformer {

  /// Creates a new fast transformer.
  FastTransformer([this._executable = 'php']);

  /// The address that the server is listening on.
  static InternetAddress address = InternetAddress.loopbackIPv4;

  /// The path to the PHP executable.
  final String _executable;

  /// The port that the PHP process is listening on.
  int _port = -1;

  /// The underlying PHP process.
  Process _process;

  /// Value indicating whether the PHP process is currently listening.
  bool get listening => _process != null;

  /// Terminates the underlying PHP process: stops the server from accepting new connections.
  /// It does nothing if the server is already closed.
  @override
  Future<void> close() async {
    if (!listening) return;
    _process.kill();
    _process = null;
  }

  /// Starts the underlying PHP process: begins accepting connections. Returns the port used by the PHP process.
  /// It does nothing if the server is already started.
  Future<int> listen() async {
    if (listening) return _port;

    final documentRoot = await Isolate.resolvePackageUri(Uri.parse('package:grinder_php_minify/php/'));
    _port = await _getPort();
    _process = await Process.start(p.normalize(_executable), ['-S', '${address.host}:$_port', '-t', documentRoot.toFilePath()]);
    return Future.delayed(const Duration(seconds: 1), () => _port);
  }

  /// Processes the specified PHP [script] and returns its contents minified.
  @override
  Future<String> transform(File script) async {
    final file = Uri.encodeComponent(script.absolute.path);
    await listen();
    return http.read('http://${address.host}:$_port/server.php?file=$file');
  }

  /// Gets an ephemeral port chosen by the system.
  Future<int> _getPort() async {
    final server = await ServerSocket.bind(address, 0);
    final port = server.port;
    await server.close();
    return port;
  }
}
