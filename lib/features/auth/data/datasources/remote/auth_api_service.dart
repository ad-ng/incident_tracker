import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthApiService {
  Future login(String email, String password) async {
    try {
      var url = Uri.http('197.243.1.84:3020', 'users/login');

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      var data = jsonDecode(response.body);

      if (data['error']) {
        print('Login failed: ${data['message']}');
        throw data['message'];
      } else {
        print('Login successful: ${data['message']}');
        return data['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
