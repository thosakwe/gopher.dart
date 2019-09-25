import 'package:gopher/gopher.dart';

main() async {
  var server = await GopherServer.bind('127.0.0.1', 7070);
  print('Listening at gopher://127.0.0.1:7070');
  await for (var request in server) {
    if (request.path == '/hello') {
      request.writeText('Hello, Gopher world!');
    } else {
      request.writeItem(
          GopherItemType.file, ['Hello', '/hello', '127.0.0.1', '7070']);
    }

    await request.close();
  }
}
