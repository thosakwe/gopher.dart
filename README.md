# gopher.dart
An implementation of the [Gopher](https://tools.ietf.org/html/rfc1436)
protocol in Dart.

## Installation
In your `pubspec.yaml`:

```yaml
dependencies:
  gopher: ^1.0.0
```

## Server

```dart
import 'package:gopher/gopher.dart';

main() async {
  var server = await GopherServer.bind('127.0.0.1', 7070);
  await for (var request in server) {
    print('Got request to ${request.path}');
    // TODO: Code here...
  }
}
```
