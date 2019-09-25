import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';

class GopherRequest implements IOSink {
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

  @override
  Encoding get encoding => socket.encoding;

  @override
  set encoding(Encoding value) => socket.encoding = value;

  @override
  void add(List<int> data) => socket.add(data);

  @override
  void addError(Object error, [StackTrace stackTrace]) =>
      socket.addError(error, stackTrace);

  @override
  Future addStream(Stream<List<int>> stream) => socket.addStream(stream);

  @override
  Future get done => socket.done;

  @override
  Future flush() => socket.flush();

  @override
  void write(Object obj) => socket.write(obj);

  @override
  void writeAll(Iterable objects, [String separator = ""]) =>
      socket.writeAll(objects, separator);

  @override
  void writeCharCode(int charCode) => socket.writeCharCode(charCode);

  @override
  void writeln([Object obj = ""]) => socket.writeln(obj);
}
