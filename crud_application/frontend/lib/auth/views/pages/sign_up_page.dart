import 'package:example_10_09/core/utils/components/default_button.dart';
import 'package:example_10_09/core/utils/components/default_snackbar.dart';
import 'package:example_10_09/core/utils/components/default_text_form_field.dart';
import 'package:example_10_09/auth/controllers/sign_up_controller.dart';
import 'package:example_10_09/auth/views/pages/login_page.dart';
import 'package:example_10_09/core/utils/theme/app_fonts.dart';
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
          return AuthScaffoldPageWrapper(
            upWidget: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Já tem uma conta?',
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
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  }, 
                  child: Text(
                    'Fazer Login',
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
                    'Vamos começar',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontFamily: AppFonts.poppins600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Crie sua conta abaixo',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontFamily: AppFonts.poppins400,
                    ),
                  ),
                  DefaultTextFormField( 
                    textController: controller.displayNameController,
                    labelText: 'Nome',
                    onChanged: () => controller.checkValid(),
                    padding: const EdgeInsets.symmetric(vertical: 24),
                  ),
                  DefaultTextFormField( 
                    textController: controller.emailController,
                    labelText: 'Email',
                    padding: const EdgeInsets.only(bottom: 24),
                    onChanged: () => controller.checkValid(),
                  ),
                  DefaultTextFormField( 
                    textController: controller.passwordController,
                    labelText: 'Senha',
                    onChanged: () => controller.checkValid(),
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
                    onTap: !controller.isValid ? null : () {
                      controller.signup(
                        (bool sucess, String msg) {
                          DefaultSnackBar.snackBarOf(text: msg, isSucess: sucess, context: context);
                        },
                        () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginPage())),
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

  SizedBox spacer() => const SizedBox(height: 16);
}

