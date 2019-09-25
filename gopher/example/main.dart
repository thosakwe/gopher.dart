import 'package:gopher/gopher.dart';

main() async {
  var server = await GopherServer.bind('127.0.0.1', 7070);
  print('Listening at gopher://127.0.0.1:7070');
  await for (var request in server) {
    print('Got request to ${request.path}');
    await request.close();
  }
}
