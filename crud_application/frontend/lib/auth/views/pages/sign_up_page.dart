import 'package:example_10_09/core/utils/components/default_button.dart';
import 'package:example_10_09/core/utils/components/default_snackbar.dart';
import 'package:example_10_09/core/utils/components/default_text_form_field.dart';
import 'package:example_10_09/auth/controllers/sign_up_controller.dart';
import 'package:example_10_09/auth/views/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpController(),
      child: Consumer<SignUpController>(
        builder: (context, controller, __) {
          return Scaffold(
            appBar: AppBar(title: const Text('Cadastrar Usuário')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DefaultTextFormField( 
                    textController: controller.displayNameController,
                    labelText: 'Nome',
                    onChanged: () => controller.checkValid(),
                  ),
                  DefaultTextFormField(
                    textController: controller.emailController,
                    labelText: 'Email',
                    onChanged: () => controller.checkValid(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  DefaultTextFormField(
                    textController: controller.passwordController,
                    labelText: 'Senha',
                    onChanged: () => controller.checkValid(),
                    sufix: IconButton(
                      icon: Icon(
                        controller.obscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: controller.setObscure,
                    ),
                    obscureText: controller.obscure,
                  ),
                  const SizedBox(height: 20),
                  controller.loading
                    ? const CircularProgressIndicator()
                    : DefaultButton(
                      textButton: 'Criar usuário',
                      onTap: !controller.isValid ? null : () => controller.signup(
                        (bool sucess, String msg) {
                          DefaultSnackBar.snackBarOf(text: msg, isSucess: sucess, context: context);
                        },
                        () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginPage()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  SizedBox spacer() => const SizedBox(height: 16);
}

