import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/pages/createaccountpage.dart';
import 'package:mohalla_bazaar/modules/deshboard/deshboard.dart';

class LoginWrapper extends StatelessWidget {
  const LoginWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read("userid");

    if (token != null) {
      // ✅ Agar token mila to sidha daashboard pe bhejo
      return const Dashboard();
    } else {
      // ✅ Agar token null hai to login pe bhejo
      return CreateAccountPage();
    }
  }
}
