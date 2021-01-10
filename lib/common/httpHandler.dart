import 'dart:async';
import 'dart:convert';
import 'package:apm_pip/models/apmModel.dart';
import 'package:http/http.dart' as http;
import 'package:apm_pip/common/constants.dart';

class HttpHandler {
  final String _baseUrl = API_URL;

  Future<List<Apm>> getAll() async {
    var endpoint = new Uri.http(_baseUrl, '/api/v1/apm');
    print(endpoint);

    final res = await http.get(endpoint);
    print(res);
    final resBody = json.decode(res.body);

    if (res.statusCode == 200) {
      print(resBody);

      return resBody['data'].map<Apm>((item) => 
        Apm.fromJson(item)
      ).toList();
    }
  }
}
