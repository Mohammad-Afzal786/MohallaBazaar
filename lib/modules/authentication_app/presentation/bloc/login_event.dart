import 'package:equatable/equatable.dart';

/// ===============================
/// EVENT क्या होता है?
/// ===============================
/// Event = User ने UI (screen) पर कौन सा action किया?
/// Example:
/// - Login button दबाया
/// - Logout button दबाया
/// - Profile update किया
///
/// Bloc इन Events को पकड़ेगा और फिर नया State देगा।
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
  // Equatable का काम:
  // Normally Dart objects memory से compare होते हैं,
  // लेकिन हम चाहते हैं "value से comparison" हो।
  // e.g. अगर दो LoginSubmitted events में
  // email और password same हैं,
  // तो उन्हें equal माना जाएगा।
}

/// ===============================
/// LoginSubmitted Event
/// ===============================
/// यह event तब fire होगा जब user login form submit करेगा।
/// मतलब user ने अपना email और password लिखा और
/// "Login" button दबाया → अब Bloc को बोलना है कि
/// "Login का काम करो"
class LoginSubmitted extends LoginEvent {
  final String phone; // user का email
  final String password; // user का password
  final String fcmtoken;

  // Constructor → जब event बनाएँगे तो email + password देना ज़रूरी है
  const LoginSubmitted(this.phone, this.password,this.fcmtoken);

  @override
  List<Object?> get props => [phone, password,fcmtoken];
  // Equatable यहाँ values को compare करेगा
  // Example:
  // LoginSubmitted("a@test.com","123") == LoginSubmitted("a@test.com","123")
  // ✅ true होगा क्योंकि values same हैं
}
