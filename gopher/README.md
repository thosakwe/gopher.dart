# gopher.dart
An implementation of the [Gopher](https://tools.ietf.org/html/rfc1436)
protocol in Dart.

## Installation
In your `pubspec.yaml`:

```yaml
dependencies:
  gopher: ^1.0.0
```

## Simple Server

```dart
import 'package:gopher/gopher.dart';

main() async {
  var server = await GopherServer.bind('127.0.0.1', 7070);
  print('Listening at gopher://127.0.0.1:7070');
  await for (var request in server) {
    if (request.path == '/hello') {
      request.writeItem(GopherItemType.binaryFile, ['Hello, Gopher world!']);
    } else {
      request.writeItem(
          GopherItemType.file, ['Hello', '/hello', '127.0.0.1', '7070']);
    }

    await request.close();
  }
}
```
