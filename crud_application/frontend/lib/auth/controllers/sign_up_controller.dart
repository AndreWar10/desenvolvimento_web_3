import 'dart:convert';
import 'package:example_10_09/core/utils/routes/api_routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpController extends ChangeNotifier {
  SignUpController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();

  bool loading = false;
  bool obscure = true;

  bool isValid = false;

  void checkValid() {
    isValid = emailController.text.isNotEmpty && passwordController.text.isNotEmpty && displayNameController.text.isNotEmpty;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setObscure() {
    obscure = !obscure;
    notifyListeners();
  }

  Future<void> signup(Function showMessage, Function redirectLogin)  async {
    setLoading(true);

    final response = await http.post(
      Uri.parse(ApiRoutes.signup),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': emailController.text,
        'password': passwordController.text,
        'displayName': displayNameController.text,
        'levelAccess': 'customer',
      }),
    );

    setLoading(false);

    if (response.statusCode == 200) {
      debugPrint('SignUp successful!');
      showMessage(true, 'Cadastro efetuado com sucesso');
      redirectLogin();
    } else {
      final errorData = jsonDecode(response.body);
      debugPrint(errorData.toString());
      showMessage(false, 'Erro ao efetuar cadastro');
    }
  }

}