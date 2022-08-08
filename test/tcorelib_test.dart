import 'package:tcorelib/tcorelib.dart';
import 'package:test/test.dart';

void main()  {
  group('[Test]', () {
    final TCoreClient = Client();

    setUp(() {
      // Additional setup goes here.
    });

    test('Check for connection to the local server', () async {
      expect(await TCoreClient.tryConnect(), true);
    });

    test('Init the client', () async {
      expect(await TCoreClient.InitRest(), true);
    });
  });
}
