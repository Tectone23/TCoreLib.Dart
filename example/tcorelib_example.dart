import 'package:tcorelib/tcorelib.dart';
import 'dart:convert';

Future<void> main() async {
  /// Create a client for TCore, 
  /// it'll populate itself with an empty Asgard object
  var client = Client();

  /// Update Asgard's contents, with the reponse from the server
  /// ie - Modules and etc
  await client.InitRest();

  /// Output each module seperately 
  for (final module in client.asgard.modules) {
      print(module);
  }

  /// Let's try to send a request to a sample ethereum cog
  var response = await client.sendRequest(
    {
      "hook": "ethereum",
      "action": "ethereum_balance",
      "function": "getBalance",
      "params": "0x00000000219ab540356cBB839Cbe05303d7705Fa"
    }
  );
  /// Decode response
  var data = jsonDecode(response.body);
  print(data);
}
