import 'package:equatable/equatable.dart';

/// ===============================
/// ForgetPassEvent
/// ===============================
/// Event = user ने UI पर कौन सा action किया
/// यहाँ सिर्फ 1 event है: user ने email डाला और submit किया
abstract class ForgotPassEvent extends Equatable {
  const ForgotPassEvent();

  @override
  List<Object?> get props => [];
}

/// जब user ने "Forgot Password" form submit किया
class ForgotPassSubmitted extends ForgotPassEvent {
  final String phone;

  const ForgotPassSubmitted(this.phone);

  @override
  List<Object?> get props => [phone];
}
