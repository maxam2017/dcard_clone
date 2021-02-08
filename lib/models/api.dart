import 'dart:convert';
import 'dart:io';

class ApiModel {
  HttpClient client = new HttpClient();

  Future<dynamic> fetch(String endpoint) async {
    final request = await client.getUrl(Uri.parse(endpoint));
    final response = await request.close();
    final data = await utf8.decodeStream(response);
    return json.decode(data);
  }
}
