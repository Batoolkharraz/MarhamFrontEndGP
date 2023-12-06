import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<String?> checkEmail(String email) async {
  var url = Uri.parse("https://marham-backend.onrender.com/updatePassword/confirmEmail");
  try {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode({
        "email": email,
      }),
    );

    
      var responseBody = response.body.toString(); // Convert response body to String
     
      if(responseBody=="User not found")
      { print("resppppppppp$responseBody");
        return "false";
      }
      else
      { var codeIs = responseBody;
        if (codeIs != null) {
        // Return the code if successful
        return codeIs;
      } else {
        // Return null for invalid data
        return null;
      }}
   
  } catch (e) {
    print('An exception occurred: $e');
    return null; // Return null for any exceptions
  }
}
