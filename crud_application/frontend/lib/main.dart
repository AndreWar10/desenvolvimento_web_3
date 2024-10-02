import 'package:example_10_09/auth/controllers/user_controller.dart';
import 'package:example_10_09/auth/views/pages/login_page.dart';
import 'package:example_10_09/core/controllers/platform_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserController()),
        ChangeNotifierProvider(create: (context) => PlatformController()),
      ],
      child: ResponsiveBuilder(
      builder: (context, sizingInformation) {
        context.read<PlatformController>().updatePlatform(sizingInformation);
          return MaterialApp(
            title: 'Web 3',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, primary: Colors.deepPurple),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                color: Colors.deepOrange,
                centerTitle: true,
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              ),
            ),
            home: const LoginPage(),
          );
        }
      ),
    );
  }
}

