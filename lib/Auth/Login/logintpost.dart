import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> postLogin(String email, String password) async {
  try {
    const storage = FlutterSecureStorage();
    var url = Uri.parse("https://marham-backend.onrender.com/signin/user");
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      var responseBody = response.body;
      final responseData = jsonDecode(response.body);
      if (responseData == false) {
        return false; // Return false for invalid data
      } else {
        var data = json.decode(responseBody);
        String token = data["token"];
        String role = data["role"];
        await storage.write(key: 'jwt', value: token);
        await storage.write(key: 'role', value: role);
        print("token is $token");
        print("role is $role");
        return true;
      } // Return true for successful response
    } else {
      print('A network error occurred');
      return false; // Return false for network error
    }
  } catch (e) {
    print('Error during user login: ${e.toString()}');
    return false; // Return false in case of an error
  }
}
