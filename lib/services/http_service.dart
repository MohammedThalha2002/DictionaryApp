import 'package:http/http.dart';
import 'dart:convert';

Future fetchData(String url) async {
  Response response = await get(Uri.parse("$url"));
  // print(jsonDecode(response.body));
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    return body;
  } else {
    print(response.statusCode);
  }
}
