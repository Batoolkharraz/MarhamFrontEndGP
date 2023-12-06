import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getUserName(String email) async {
  try {
    final url = Uri.parse("https://marham-backend.onrender.com/giveme/username");

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "email": email,
      }),
    );

    if (response.statusCode == 200) {
      var responseBody = response.body;
      final responseData = jsonDecode(responseBody);
      var data = json.decode(responseBody);
 // Replace 'username' with the actual key in the response
      print("Username: $data");
      return data;
    } else {
      print("Error: ${response.statusCode}");
      // Handle other status codes if needed
      return "error";
    }
  } catch (e) {
    print('Error during user registration: ${e.toString()}');
    // Handle the error appropriately
    return ' e.toString()';
  }
}

// Example usage

