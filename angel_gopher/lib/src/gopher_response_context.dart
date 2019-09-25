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

  GopherResponseContext(this.rawResponse, this.correspondingRequest);

  @override
  void add(List<int> event) {
    // TODO: implement add
  }

  @override
  Future addStream(Stream<List<int>> stream) {
    // TODO: implement addStream
    return null;
  }

  @override
  // TODO: implement buffer
  BytesBuilder get buffer => null;

  @override
  FutureOr<GopherRequest> detach() {
    // TODO: implement detach
    return null;
  }

  @override
  // TODO: implement isBuffered
  bool get isBuffered => null;

  @override
  // TODO: implement isOpen
  bool get isOpen => null;

  @override
  void useBuffer() {
    // TODO: implement useBuffer
  }
}
