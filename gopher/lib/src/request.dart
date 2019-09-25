import 'dart:async';
import 'dart:io';
import 'package:charcode/ascii.dart';
import 'package:async/async.dart';

abstract class GopherItemType {
  static const String file = '0',
      directory = '1',
      csoPhoneBookServer = '2',
      error = '3',
      binHexedMacintoshFile = '4',
      dosBinaryArchive = '5',
      unixUUEncodedFile = '6',
      indexSearchServer = '7',
      textBasedTelnetSession = '8',
      binaryFile = '9',
      redundantServer = '+',
      textBasedTN3270Session = 'T',
      gifFormatGraphicsFile = 'g',
      imageFile = 'I';
}

class GopherRequest {
  final String path;
  final Socket socket;
  final StreamQueue<String> lines;

  GopherRequest(this.path, this.socket, this.lines);

  Future<void> writeStream(type, Stream<List<int>> stream) async {
    socket.write(type);
    await socket.addStream(stream);
  }

  void writeCrlf() => socket.add([$cr, $lf]);

  void writeItem(type, [Iterable values]) {
    var v = values?.join('F');
    socket.write(type);
    if (v != null) socket.write(v);
    writeCrlf();
  }

  Future<void> close() {
    socket.writeln('.');
    socket.close();
    lines.rest.drain();
    return Future.value();
  }
}
