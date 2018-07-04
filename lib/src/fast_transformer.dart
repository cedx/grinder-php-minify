part of grinder_php_minify;

/// Removes comments and whitespace from a PHP script, by calling a Web service.
class FastTransformer implements Transformer {

  /// The default address that the server is listening on.
  static final InternetAddress defaultAddress = InternetAddress.loopbackIPv4;

  /// The path to the PHP executable.
  final String _executable;

  /// The port that the PHP process is listening on.
  int _port = -1;

  /// The underlying PHP process.
  Process _process;

  /// Creates a new fast transformer.
  FastTransformer([this._executable = 'php']);

  /// Value indicating whether the PHP process is currently listening.
  bool get listening => _process != null;

  /// Terminates the underlying PHP process: stops the server from accepting new connections.
  /// It does nothing if the server is already closed.
  @override
  Future<Null> close() async {
    if (!listening) return;
    _process.kill();
    _process = null;
  }

  /// Starts the underlying PHP process: begins accepting connections. Returns the port used by the PHP process.
  /// It does nothing if the server is already started.
  Future<int> listen() async {
    if (listening) return _port;

    var server = await Isolate.resolvePackageUri(Uri.parse('package:grinder_php_minify/php/'));
    _port = await _getPort();
    _process = await Process.start(_executable, ['-S', '${defaultAddress.host}:$_port', '-t', server.toFilePath()]);
    return Future.delayed(const Duration(seconds: 1), () => _port);
  }

  /// Processes the specified PHP [script] and returns its contents minified.
  @override
  Future<String> transform(File script) async {
    var file = Uri.encodeComponent(script.absolute.path);
    await listen();
    return http.read('http://${defaultAddress.host}:$_port/server.php?file=$file');
  }

  /// Gets an ephemeral port chosen by the system.
  Future<int> _getPort() async {
    var server = await ServerSocket.bind(defaultAddress, 0);
    var port = server.port;
    await server.close();
    return port;
  }
}
