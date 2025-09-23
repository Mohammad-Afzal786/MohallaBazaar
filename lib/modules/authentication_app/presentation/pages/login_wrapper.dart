import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/modules/deshboard/deshboard.dart';

// 👈 apne dashboard ka import lagao

class LoginWrapper extends StatelessWidget {
  const LoginWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read("accessToken");

    if (token != null) {
      // ✅ Agar token mila to sidha dashboard pe bhejo
      return const Dashboard();
    } else {
      // ✅ Agar token null hai to login pe bhejo
      return const Dashboard();
    }
  }
}
