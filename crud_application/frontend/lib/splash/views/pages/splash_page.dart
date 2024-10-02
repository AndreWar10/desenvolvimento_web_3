import 'package:example_10_09/auth/views/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();


    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Color.fromARGB(255, 144, 95, 249), Color.fromARGB(255, 62, 20, 214)],
        ),
      ),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Lottie.asset('assets/animations/animation_splash.json'),
        ),
      ),
    );
  }
}