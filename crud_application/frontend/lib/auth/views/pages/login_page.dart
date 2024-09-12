import 'package:example_10_09/core/utils/components/default_button.dart';
import 'package:example_10_09/core/utils/components/default_snackbar.dart';
import 'package:example_10_09/core/utils/components/default_text_form_field.dart';
import 'package:example_10_09/auth/controllers/login_controller.dart';
import 'package:example_10_09/auth/controllers/user_controller.dart';
import 'package:example_10_09/auth/models/user_model.dart';
import 'package:example_10_09/auth/views/pages/container_login.dart';
import 'package:example_10_09/auth/views/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginController(),
      child: Consumer<LoginController>(
        builder: (context, controller, __) {
          return Scaffold(
            appBar: AppBar(title: const Text('Login')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DefaultTextFormField( 
                    textController: controller.emailController,
                    labelText: 'Email',
                    padding: const EdgeInsets.only(bottom: 8),
                    onChanged: () {},
                  ),
                  DefaultTextFormField( 
                    textController: controller.passwordController,
                    labelText: 'Senha',
                    onChanged: () {},
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
                          onTap: () => controller.login(
                            (bool sucess, String msg) {
                              DefaultSnackBar.snackBarOf(text: msg, isSucess: sucess, context: context);
                            },
                            (UserModel user) {
                              context.read<UserController>().setUser(user);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ContainerLogin()));
                            }
                          ),
                          textButton: 'Login',
                        ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignupScreen()),
                      );
                    },
                    child: const Text('Criar conta'),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
