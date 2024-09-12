import 'dart:io';
import 'package:example_10_09/admin/views/pages/admin_page.dart';
import 'package:example_10_09/auth/controllers/user_controller.dart';
import 'package:example_10_09/auth/views/pages/user_not_logged_in.dart';
import 'package:example_10_09/desktop_store/views/pages/attendant_page.dart';
import 'package:example_10_09/online_store/views/pages/online_store_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerLogin extends StatefulWidget {
  const ContainerLogin({super.key});

  @override
  State<ContainerLogin> createState() => _ContainerLoginState();
}

class _ContainerLoginState extends State<ContainerLogin> {

  late UserController userController;

  @override
  void initState() {
    userController = context.read<UserController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(userController.userIsLoggedIn) {
      if(kIsWeb) {
        return const OnlineStorePage(); 
      } else if(Platform.isAndroid || Platform.isIOS) {
        if(userController.user!.type == 'admin') {
          return const AdminPage();
        } 
        return const OnlineStorePage(); 
      } else {
        if(userController.user!.type == 'attendant') {
          return const AttendantPage();
        } else {
          //deslogar
          debugPrint('deslogar');
        }
      } 
    }
    return const UserNotLoggedIn();
  }
}

