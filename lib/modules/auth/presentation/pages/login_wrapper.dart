import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/modules/auth/auth_injection.dart';
import 'package:mohalla_bazaar/modules/auth/presentation/bloc/login_bloc.dart';
import 'package:mohalla_bazaar/modules/auth/presentation/pages/login.dart';
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
      return BlocProvider(
        create: (_) => sl<LoginBloc>(),
        child: const LoginPage(),
      );
    }
  }
}
