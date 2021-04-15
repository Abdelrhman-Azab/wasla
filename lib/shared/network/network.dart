import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> getRequest(Uri url) async {
  http.Response response = await http.get(url);
  try {
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      return "Failed";
    }
  } catch (e) {
    return "Failed";
  }
}
