import 'dart:convert';
import 'package:http/http.dart' as http;

class Asgard{
  List modules = [];

  updateModules(List modules){
    this.modules = modules;
    print("Loaded modules: $modules");
  }
}

class Client {
  bool   connected;
  String URI       = "http://0.0.0.0:8080";
  Asgard asgard;

  Client()
  : asgard = Asgard(),
    connected = false
  {}

  Future<bool> InitRest() async {
    var data = await getModules();
    var jsondata = jsonDecode(data.body);

    asgard.updateModules(
      jsondata["data"]["data"]
    );

    return true;
  }

  Future<http.Response> sendRequest() async {
    // Compose URL (URI, PATH, BODY)
    var response = await http.get(
        Uri.parse(URI)
    );
    return response;
  }

  Future<http.Response> getModules() async {
    // Compose URL (URI, PATH, BODY)
    var response = await http.get(
        Uri.parse(URI + "/list_asgard")
    );
    return response;
  }

  /* Testing */
  Future<bool> tryConnect() async {
    print("Trying to connect to $URI");
    var request = await http.get(
        Uri.parse(URI)
    );
    // Test specific only
    if (request.statusCode == 200) {
      return true;
    } else {
      print("Got code: ${request.statusCode}");
      return false;
    }
  }
}