import 'dart:async';
import 'dart:io';
import 'package:angel_framework/angel_framework.dart';
import 'package:gopher/gopher.dart';
import 'gopher_request_context.dart';

class GopherResponseContext extends ResponseContext<GopherRequest> {
  @override
  final GopherRequest rawResponse;
  @override
  final GopherRequestContext correspondingRequest;

  LockableBytesBuilder _buffer;
  bool _isDetached = false, _isClosed = false;

  GopherResponseContext(this.rawResponse, this.correspondingRequest);

  @override
  BytesBuilder get buffer => _buffer;

  @override
  FutureOr<GopherRequest> detach() {
    _isDetached = true;
    return rawResponse;
  }

  @override
  bool get isBuffered => _buffer != null;

  @override
  bool get isOpen => !_isClosed && !_isDetached;

  void writeFileItem(String selector, path) {
    if (!isOpen) {
      throw ResponseContext.closed();
    }
    rawResponse.writeItem(GopherItemType.file, [
      selector,
      path,
      rawResponse.socket.address.address,
      rawResponse.socket.port
    ]);
  }

  @override
  void useBuffer() {
    _buffer ??= LockableBytesBuilder();
  }

  @override
  Future close() async {
    if (!_isDetached && !_isClosed && !isBuffered) {
      await rawResponse.close();
    }

    _isClosed = true;
    await super.close();
  }

  @override
  void add(List<int> event) {
    if (!isOpen && isBuffered) {
      throw ResponseContext.closed();
    } else if (isBuffered) {
      buffer.add(event);
    } else {
      rawResponse.socket.add(event);
    }
  }

  @override
  Future addStream(Stream<List<int>> stream) {
    return stream.forEach(add);
  }
}
