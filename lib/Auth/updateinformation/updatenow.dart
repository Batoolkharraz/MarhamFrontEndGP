import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
void updateinformation(String variable,String value)async{
    const storage = FlutterSecureStorage();
  String? toke2 = await storage.read(key: 'jwt');

  if (toke2 != null) {
    print('Token in local storage: $toke2 done');
    
    var url = Uri.parse("https://marham-backend.onrender.com/update/userinformation");
      var response = await http.patch(url,
      headers: {
        'Authorization': 'Alaa__$toke2',
        'Content-Type': 'application/json', // You may need to set the content type as per your API's requirements
      },
       body: jsonEncode({
      value:variable,
    }),
      );
         var responseBody = response.body;
      print(responseBody );
      
  } else {
    print('Token not found in local storage.');
  }
}