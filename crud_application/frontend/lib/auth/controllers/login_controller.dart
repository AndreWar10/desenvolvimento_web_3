import 'package:example_10_09/auth/models/user_model.dart';
import 'package:example_10_09/core/utils/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends ChangeNotifier {
  LoginController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;
  bool obscure = true;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setObscure() {
    obscure = !obscure;
    notifyListeners();
  }

  Future<void> login(Function showMessage, Function redirectLogin)  async {
    setLoading(true);

    final response = await http.post(
      Uri.parse('http://${Environment.ip}:3001/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': emailController.text, 'password': passwordController.text}),
    );

    setLoading(false);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint('Login successful! User: ${data['email']}');
      final user = UserModel.fromJson(data);
      showMessage(true, 'Login efetuado com sucesso');
      redirectLogin(user);
    } else {
      final errorData = jsonDecode(response.body);
      debugPrint(errorData.toString());
      showMessage(false, 'Login inválido');
    }
  }


}
