import 'dart:convert';

import 'package:http/http.dart' as http;

Future<bool> sendUserData({String userId, String userName, int userAge}) async {
  String url =
      "https://ranjeetbihare.in/test/index.php?data=saveUserData&user_name=$userName&user_age=$userAge&user_id=$userId";
  http.Response res = await http.get(Uri.parse(url));
  print(url);
  Map resBody = json.decode(res.body);
  if (resBody['txn'].toString() == "1")
    return true;
  else
    return false;
}
