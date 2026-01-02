import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/forgetpassentity.dart';

/// सिर्फ forgot password API का response रखने के लिए
class ForgotPassResult {
  final bool success;
  final ForgetpassEntity data;

  const ForgotPassResult({
    required this.success,
    required this.data,
  });
}
