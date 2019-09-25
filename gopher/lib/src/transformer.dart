import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'request.dart';

class GopherRequestTransformer
    extends StreamTransformerBase<Socket, GopherRequest> {
  const GopherRequestTransformer();

  @override
  Stream<GopherRequest> bind(Stream<Socket> stream) async* {
    await for (var sock in stream) {
      var lineStream = sock.transform(utf8.decoder).transform(LineSplitter());
      var lines = StreamQueue(lineStream);
      var requestLine = await lines.next;
      yield GopherRequest(requestLine, sock, lines);
    }
  }
}
