import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  print("no image");
}

Future<XFile?> fileImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? image = await imagePicker.pickImage(source: source);
  return image; 
}

getImagePath(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    // The file path of the picked image
    String imagePath = file.path;
    return imagePath;

    // Now you can use this imagePath to upload or display the image.
  } else {
    print('No image selected');
  }
}

Future<void> updateUserInformation(XFile? imageFile) async {
  try {
    var uri =
        Uri.parse("https://marham-backend.onrender.com/update/userinformation");

    // Create a new multipart request
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'jwt');
    var request = http.MultipartRequest("PATCH", uri);
    request.headers['Authorization'] = 'Alaa__$token';
    request.headers['Content-Type'] = 'application/json';

    // Add the image file to the request
    if (imageFile != null) {
      var file = await http.MultipartFile.fromPath('image', imageFile.path,
          contentType:
              MediaType('image', 'jpeg')); // Adjust content type as needed
      request.files.add(file);
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      print(data); // Handle the response from the server as needed
    } else {
      print(
          'Failed to update user information. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
