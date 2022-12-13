import 'dart:convert';
import 'package:tcorelib/extras/todo.dart';
import 'package:http/http.dart' as http;

class Asgard {
  List modules = [];

  updateModules(List modules) {
    this.modules = modules;
    print("Loaded modules: $modules");
  }
}

class Client {
  bool connected;
  String URI = "0.0.0.0";
  int Port = 8080;
  Asgard asgard;

  Client([this.URI = "0.0.0.0"])
      : asgard = Asgard(),
        connected = false;

  /// Wrapper base for initialization and getting a cog
  Future<bool> init(List<String> cogNames) async {
    if (await InitRest()) {
      for (final cogName in cogNames) {
        if (!asgard.modules.contains(cogName)) {
          return false;
        }
      }
      return true;
    } else {
      throw Exception("Failed to initalize TCore.Lib");
    }
  }

  /// Initialize components for use later
  /// Did this due to the constructor
  /// not being async
  Future<bool> InitRest() async {
    var data = await getModules();
    Map<String, dynamic> jsondata = jsonDecode(data.body);
    asgard.updateModules(jsondata["data"].keys.toList());

    return true;
  }

  /// Create and send a request.
  /// Uses [body] in Map format
  /// Following this scheme
  /// {
  ///   "hook":...
  ///   "action":...
  ///   "function":...
  ///   "params":...
  /// }
  Future<http.Response> sendRequest(Map<String, String> bbody) async {
    TODO("Add more requirements to the request body");

    Uri _myUri = Uri(
        scheme: 'http',
        host: URI,
        port: Port,
        path: '/asgard',
        queryParameters: bbody);
    var response = await http.get(_myUri);
    return response;
  }

  /* Get modules, no body needed for this currently.
  /// Expect a Response object. Use .body and
  /// jsonDecode to convert to a Map
  */
  Future<http.Response> getModules() async {
    // TODO("Add more requirements to the request body");
    // Compose URL (URI, PATH, BODY)
    var response = await http.get(Uri.parse("http://$URI:$Port" + "/asgard"));
    if (response.statusCode != 200) {
      throw Exception(
          "Failed to get the module list. Return code is ${response.statusCode}");
    }
    return response;
  }

  /// Testing
  Future<bool> tryConnect() async {
    print("Trying to connect to $URI");
    var response = await http.get(Uri.parse("http://$URI:$Port"));
    // Test specific only
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Got code: ${response.statusCode}");
      return false;
    }
  }
}
