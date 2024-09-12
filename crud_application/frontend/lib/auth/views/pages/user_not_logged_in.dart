import 'package:flutter/material.dart';

class UserNotLoggedIn extends StatelessWidget {
  const UserNotLoggedIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Usuário Deslogado')),
    );
  }
}