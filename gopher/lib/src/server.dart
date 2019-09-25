import 'dart:async';
import 'dart:io';

class GopherServer {
  ServerSocket _serverSocket;
  SecureServerSocket _secureServerSocket;
  Stream<Socket> _socketStream;

  InternetAddress get address =>
      _secureServerSocket?.address ?? _serverSocket?.address;

  int get port => _secureServerSocket?.port ?? _serverSocket?.port;

  GopherServer.listenOn(this._serverSocket) : _socketStream = _serverSocket;

  GopherServer.listenOnSecure(this._secureServerSocket)
      : _socketStream = _secureServerSocket;

  static Future<GopherServer> bind(address, int port,
      {int backlog = 0, bool shared = false, bool v6Only = false}) async {
    var socket = await ServerSocket.bind(address, port,
        backlog: backlog, shared: shared, v6Only: v6Only);
    return GopherServer.listenOn(socket);
  }

  static Future<GopherServer> bindSecure(
      address, int port, SecurityContext context,
      {int backlog: 0,
      bool v6Only: false,
      bool requestClientCertificate: false,
      bool requireClientCertificate: false,
      List<String> supportedProtocols,
      bool shared: false}) async {
    var socket = await SecureServerSocket.bind(address, port, context,
        backlog: backlog,
        shared: shared,
        v6Only: v6Only,
        requestClientCertificate: requestClientCertificate,
        requireClientCertificate: requireClientCertificate,
        supportedProtocols: supportedProtocols);
    return GopherServer.listenOnSecure(socket);
  }

  Future<void> close() async {
    await _serverSocket?.close();
    await _secureServerSocket?.close();
  }
}
