import 'package:equatable/equatable.dart';

/// ===============================
/// RegisterEvent
/// ===============================
/// Event = User ne registration screen par kya action kiya?
/// Example:
/// - Form submit kiya
/// - Ya future me resend verification code kiya
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

/// ===============================
/// RegisterSubmitted Event
/// ===============================
/// Ye event tab fire hoga jab user register form submit karega.
/// Matlab: user ne firstName, lastName, email, password, phone likha
/// aur "Register" button dabaya.
class RegisterSubmitted extends RegisterEvent {
  final String name;
  final String password;
  final String phone;
  final String fcmtoken;

  const RegisterSubmitted({
    required this.name,
    required this.password,
    required this.phone,
    required this.fcmtoken,
  });

  @override
  List<Object?> get props => [name, password, phone,fcmtoken];
}
