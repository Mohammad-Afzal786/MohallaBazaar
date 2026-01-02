import 'package:equatable/equatable.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/ragistar_result.dart';

/// ===============================
/// RegisterStatus Enum
/// ===============================
/// Registration process ke 4 possible states:
/// 1. initial → Form khula hai, kuch submit nahi hua
/// 2. loading → Request backend par ja rahi hai
/// 3. success → Registration successful (user created / verification mail sent)
/// 4. failure → Error aaya (email already exists, etc.)
enum RegisterStatus { initial, loading, success, failure }

/// ===============================
/// RegisterState Class
/// ===============================
class RegisterState extends Equatable {
  /// Abhi ki स्थिति (initial/loading/success/failure)
  final RegisterStatus status;

  /// Agar registration successful hua to server ka response
  final RegisterResult? data;

  /// Agar registration fail hua to error message
  final String? error;

  /// Default constructor
  const RegisterState({
    this.status = RegisterStatus.initial,
    this.data,
    this.error,
  });

  /// copyWith → immutable state ko naya state banane ke liye
  RegisterState copyWith({
    RegisterStatus? status,
    RegisterResult? data,
    String? error,
  }) {
    return RegisterState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, data, error];
}
