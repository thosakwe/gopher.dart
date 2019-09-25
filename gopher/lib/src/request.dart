import 'dart:async';
import 'dart:io';
import 'package:async/async.dart';

class GopherRequest {
  final String path;
  final Socket socket;
  final StreamQueue<String> lines;

  GopherRequest(this.path, this.socket, this.lines);

  Future<void> close() {
    socket.writeln('.');
    socket.close();
    lines.rest.drain();
    return Future.value();
  }
}
