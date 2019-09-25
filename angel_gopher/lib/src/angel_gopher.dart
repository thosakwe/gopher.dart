import 'dart:async';
import 'dart:io';
import 'package:angel_framework/angel_framework.dart';
import 'package:gopher/gopher.dart';
import 'gopher_request_context.dart';
import 'gopher_response_context.dart';

class AngelGopher extends Driver<GopherRequest, GopherRequest, GopherServer,
    GopherRequestContext, GopherResponseContext> {
  factory AngelGopher(Angel app, {bool useZone = true}) {
    return AngelGopher.custom(app, GopherServer.bind, useZone: useZone);
  }

  factory AngelGopher.secure(Angel app, SecurityContext context,
      {bool useZone = true}) {
    return AngelGopher.custom(
        app, (addr, port) => GopherServer.bindSecure(addr, port, context),
        useZone: useZone);
  }

  AngelGopher.custom(
      Angel app, Future<GopherServer> Function(dynamic, int) serverGenerator,
      {bool useZone = true})
      : super(app, serverGenerator, useZone: useZone);

  @override
  Uri get uri =>
      Uri(scheme: 'gopher', host: server.address.address, port: server.port);

  @override
  void addCookies(GopherRequest response, Iterable<Cookie> cookies) {
    // Cookies don't exist in Gopher.
  }

  @override
  Future closeResponse(GopherRequest response) => response.close();

  @override
  Future<GopherRequestContext> createRequestContext(
          GopherRequest request, GopherRequest response) =>
      Future.value(GopherRequestContext(request, app.container.createChild()));

  @override
  Future<GopherResponseContext> createResponseContext(
          GopherRequest request, GopherRequest response,
          [GopherRequestContext correspondingRequest]) =>
      Future.value(GopherResponseContext(request, correspondingRequest));

  @override
  Stream<GopherRequest> createResponseStreamFromRawRequest(
          GopherRequest request) =>
      Stream.fromIterable([request]);

  @override
  void setChunkedEncoding(GopherRequest response, bool value) {
    // Non-existent in Gopher
  }

  @override
  void setContentLength(GopherRequest response, int length) {
    // Non-existent in Gopher
  }

  @override
  void setHeader(GopherRequest response, String key, String value) {
    // Non-existent in Gopher
  }

  @override
  void setStatusCode(GopherRequest response, int value) {
    // Non-existent in Gopher
  }

  @override
  void writeStringToResponse(GopherRequest response, String value) =>
      response.writeText(value);

  @override
  void writeToResponse(GopherRequest response, List<int> data) =>
      response.socket.add(data);
}
