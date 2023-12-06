
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> addPOST(String username, String email, String phone, String password) async {
  try {
    
    final url = Uri.parse("https://marham-backend.onrender.com/signup/user");

    final response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode({
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
    }));

    if (response.statusCode == 200) {
      var responseBody = response.body.toString(); // Convert response body to String
      responseBody = responseBody.trim();
      responseBody = responseBody.replaceAll('"', '');

      if (responseBody == "false1") {
        return "false1";
      } else if (responseBody == "false2") {
        return "false2";
      } else {
        return "true";
      }
    } else {
      print('A network error occurred');
      return "error"; // Return a default value
    }
  } catch (e) {
    print('Error during user registration: ${e.toString()}');
    return "error"; // Return a default value in case of an error
  }
}
