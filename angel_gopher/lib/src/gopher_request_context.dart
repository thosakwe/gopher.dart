import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:angel_container/angel_container.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:gopher/gopher.dart';
import 'package:mock_request/mock_request.dart';

class GopherRequestContext extends RequestContext<GopherRequest> {
  @override
  final GopherRequest rawRequest;

  @override
  final Container container;

  final String path;

  @override
  final HttpHeaders headers = MockHttpHeaders();

  Uri _uri;

  GopherRequestContext(this.rawRequest, this.container, this.path);

  @override
  Stream<List<int>> get body => rawRequest.lines.rest.transform(utf8.encoder);

  @override
  final List<Cookie> cookies = [];

  @override
  String get hostname => ip;

  @override
  String get method => 'GET';

  @override
  String get originalMethod => method;

  @override
  InternetAddress get remoteAddress => rawRequest.socket.remoteAddress;

  @override
  HttpSession get session => null;

  @override
  Uri get uri => _uri ??= Uri(
      scheme: 'gopher',
      host: rawRequest.socket.address.address,
      port: rawRequest.socket.port,
      path: rawRequest.path);
}
