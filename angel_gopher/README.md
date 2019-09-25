# angel_gopher
[Angel](https://angel-dart.dev) bindings for the
[Gopher](https://tools.ietf.org/html/rfc1436) protocol.

```dart
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_gopher/angel_gopher.dart';
import 'package:logging/logging.dart';
import 'package:pretty_logging/pretty_logging.dart';

// Fetch JSON in bash using `nc`:
//  * `echo '/json' | nc 127.0.0.1 7070 | jq .`
//  * `curl -s gopher://127.0.0.1:7070/0/json | jq .`
//
// View in Lynx browser:
//  * `lynx gopher://127.0.0.1:7070`
//  * `lynx gopher://127.0.0.1:7070/0/hello`
//  * `lynx gopher://127.0.0.1:7070/0/json`

main() async {
  var logger = Logger('example')..onRecord.listen(prettyLog);
  var app = Angel(logger: logger), gopher = AngelGopher(app);

  app.get('/', (req, res) {
    if (res is GopherResponseContext) {
      res..writeFileItem('Hello', '/hello')..writeFileItem('JSON', '/json');
    } else {
      res.write('Endpoints: /hello and /json');
    }
  });

  app.get('/hello', (req, res) => res.write('Hello, Gopher world!'));

  app.get('/json', (req, res) => {'this': 'is json!!!'});

  app.fallback((req, res) => throw AngelHttpException.notFound(
      message: 'No file exists at path ${req.uri.path}.'));

  await gopher.startServer('127.0.0.1', 7070);
  print('angel_gopher example listening at ${gopher.uri}');
}
```