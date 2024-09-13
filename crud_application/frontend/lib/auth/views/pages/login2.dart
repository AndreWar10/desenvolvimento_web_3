import 'package:example_10_09/core/utils/components/default_text_form_field.dart';
import 'package:example_10_09/core/utils/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class Login2 extends StatelessWidget {
  const Login2({super.key});

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
                    child: Row(
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
                          onPressed: () {}, 
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
                  ),
                  Text(
                    'Web 3 Store',
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
                              textController: TextEditingController(),
                              labelText: 'Email',
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              onChanged: () {},
                            ),
                            DefaultTextFormField( 
                              textController: TextEditingController(),
                              labelText: 'Senha',
                              onChanged: () {},
                              // sufix: IconButton(
                              //   icon: Icon(
                              //     controller.obscure ? Icons.visibility_off : Icons.visibility,
                              //     color: Colors.grey,
                              //   ),
                              //   onPressed: controller.setObscure,
                              // ),
                              obscureText: true,
                            ),
                        
                            Container(
                              height: 64,
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 24),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [Color.fromARGB(255, 247, 163, 255), Color.fromARGB(255, 57, 19, 225)],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: AppFonts.poppins600,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
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
