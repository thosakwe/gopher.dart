import 'package:angel_framework/angel_framework.dart';
import 'package:angel_gopher/angel_gopher.dart';
import 'package:logging/logging.dart';

main() async {
  var logger = Logger('example')..onRecord.listen(print);
  var app = Angel(logger: logger), gopher = AngelGopher(app);

  app.get('/', (req, res) => res.write('Hello, Gopher world!'));

  app.get('/json', (req, res) => {'this': 'is json!!!'});

  await gopher.startServer('127.0.0.1', 7070);
  print('angel_gopher example listening at ${gopher.uri}');
}
