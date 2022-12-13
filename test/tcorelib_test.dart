import 'package:tcorelib/tcorelib.dart';
import 'package:test/test.dart';

void main() {
  group('[Test]', () {
    final TCoreClient = Client("192.168.2.9");

    setUp(() {
      // Additional setup goes here.
    });

    test('Check for connection to the local server', () async {
      expect(await TCoreClient.tryConnect(), true);
    });

    test('Init the client', () async {
      expect(await TCoreClient.InitRest(), true);
    });

    test('Init the for a specific cog', () async {
      expect(await TCoreClient.init(["test", "files"]), true);
    });

    test('Modules', () async {
      expect((await TCoreClient.getModules()).statusCode == 200, true);
    });
  });
}
