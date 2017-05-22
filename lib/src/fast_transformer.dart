part of grinder_php_minify;

/// Removes comments and whitespace from a PHP script, by calling a Web service.
class FastTransformer implements Function {

  /// The URL of the default API end point.
  static const String defaultAddress = '127.0.0.1';

  /// The instance providing access to the minifier settings.
  final Minifier _minifier;

  /// The underlying PHP process.
  Map _phpServer;

  /// Creates a new fast transformer.
  FastTransformer(this._minifier);

  /// Value indicating whether the PHP process is currently listening.
  bool get listening => _phpServer != null;

  /// Processes the specified PHP [script] and returns its minified contents.
  Future<String> call(File script) async {
    await listen();

    /* TODO
    var response = await superagent
      .get('http://${this._phpServer.address}:${this._phpServer.port}/index.php')
      .query({file: script});

    return response.text;*/
  }

  /// Terminates the underlying PHP process: stops the server from accepting new connections. It does nothing if the server is already closed.
  Future close() {
    if (listening) {}
    // TODO
  }

  /// Starts the underlying PHP process: begins accepting connections. It does nothing if the server is already started.
  Future listen() {
    // TODO
  }
}
