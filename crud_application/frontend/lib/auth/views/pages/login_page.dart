import 'package:example_10_09/auth/controllers/login_controller.dart';
import 'package:example_10_09/auth/controllers/user_controller.dart';
import 'package:example_10_09/auth/models/user_model.dart';
import 'package:example_10_09/auth/views/pages/container_login.dart';
import 'package:example_10_09/auth/views/pages/sign_up_page.dart';
import 'package:example_10_09/core/utils/components/default_button.dart';
import 'package:example_10_09/core/utils/components/default_snackbar.dart';
import 'package:example_10_09/core/utils/components/default_text_form_field.dart';
import 'package:example_10_09/core/utils/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginController(),
      child: Consumer<LoginController>(
        builder: (context, controller, __) {
          return AuthScaffoldPageWrapper(
            upWidget: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Ainda não tem uma conta?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: AppFonts.poppins300,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 137, 123, 255).withOpacity(.99),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12)
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                    );
                  }, 
                  child: Text(
                    'Criar Conta',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppFonts.poppins500,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
            title: 'Web 3 Store',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 48),
                  Text(
                    'Bem vindo de volta',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontFamily: AppFonts.poppins600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Acesse abaixo com seu login',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontFamily: AppFonts.poppins400,
                    ),
                  ),
                  DefaultTextFormField( 
                    textController: controller.emailController,
                    labelText: 'Email',
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    onChanged: () {},
                  ),
                  DefaultTextFormField( 
                    textController: controller.passwordController,
                    labelText: 'Senha',
                    onChanged: () {},
                    sufix: GestureDetector(
                      onTap: controller.setObscure,
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          size: 24,
                          controller.obscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    obscureText: controller.obscure,
                  ),
                  DefaultButton(
                    textButton: 'Login',
                    height: 64,
                    width: double.infinity,
                    loading: controller.loading,
                    onTap: () {
                      controller.login(
                        (bool success, String msg) {
                          DefaultSnackBar.snackBarOf(text: msg, isSucess: success, context: context);
                        },
                        (UserModel user) {
                          context.read<UserController>().setUser(user);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ContainerLogin()));
                        },
                      );
                    },
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



                    

                    


class AuthScaffoldPageWrapper extends StatelessWidget {
  final Widget upWidget;
  final String title;
  final Widget child;

  const AuthScaffoldPageWrapper({super.key, required this.upWidget, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Color.fromARGB(255, 144, 95, 249), Color.fromARGB(255, 62, 20, 214)],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: upWidget,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontFamily: AppFonts.poppins700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                        color: const Color.fromARGB(255, 137, 123, 255).withOpacity(.99),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: child,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}