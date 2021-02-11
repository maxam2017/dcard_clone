import 'dart:convert';
import 'dart:io';
import 'package:dcard_clone/constants/host.dart';

class ApiModel {
  Host host;
  ApiModel([this.host = Host.dcard]);

  HttpClient client = new HttpClient();

  Future<dynamic> fetch(String path, [Map<String, dynamic> query]) async {
    final endpoint = Uri.https(
        hostMap[this.host],
        path,
        query is Map
            ? query.map((key, value) {
                return MapEntry(key, value.toString());
              })
            : null);

    try {
      final request = await client.getUrl(endpoint);
      final response = await request.close();
      return response;
    } catch (e) {
      print('⚠️ [ApiModel]: $e');
    }
  }
}

/// util for to json
Future<dynamic> toJson(dynamic response) async {
  final data = await utf8.decodeStream(response);
  return json.decode(data);
}
