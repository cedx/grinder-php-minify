part of grinder_php_minify;

/// Removes comments and whitespace from a PHP script, by calling a Web service.
class FastTransformer implements Transformer {

  /// The default address that the server is listening on.
  static final InternetAddress defaultAddress = InternetAddress.LOOPBACK_IP_V4;

  /// The instance providing access to the minifier settings.
  final Minifier _minifier;

  /// The underlying PHP process.
  Map<String, dynamic> _phpServer;

  /// Creates a new fast transformer.
  FastTransformer(this._minifier);

  /// Value indicating whether the PHP process is currently listening.
  bool get listening => _phpServer != null;

  /// Terminates the underlying PHP process: stops the server from accepting new connections.
  /// It does nothing if the server is already closed.
  @override
  Future close() async {
    if (!listening) return;
    _phpServer['process'].kill();
    _phpServer = null;
  }

  /// Starts the underlying PHP process: begins accepting connections. Returns the port used by the PHP process.
  /// It does nothing if the server is already started.
  Future<int> listen() async {
    if (listening) return _phpServer['port'];

    var address = FastTransformer.defaultAddress.host;
    var port = await _getPort();
    var webroot = (await Isolate.resolvePackageUri(Uri.parse('package:grinder_php_minify/'))).resolve('../web');

    _phpServer = {
      'address': address,
      'port': port,
      'process': Process.start(_minifier.binary, ['-S', '$address:$port', '-t', webroot.toFilePath()])
    };

    return new Future.delayed(const Duration(seconds: 1), () => port);
  }

  /// Processes the specified PHP [script] and returns its contents minified.
  @override
  Future<String> transform(File script) async {
    await listen();

    var file = Uri.encodeComponent(script.path);
    var url = 'http://${_phpServer['address']}:${_phpServer['port']}/index.php?file=$file';
    return (await http.get(url)).body;
  }

  /// Gets an ephemeral port chosen by the system.
  Future<int> _getPort() async {
    var server = await ServerSocket.bind(FastTransformer.defaultAddress, 0);
    var port = server.port;
    await server.close();
    return port;
  }
}
