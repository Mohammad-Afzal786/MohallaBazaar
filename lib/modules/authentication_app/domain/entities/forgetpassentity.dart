
/// User entity (Domain में हमेशा साफ और simple class होती है)
class ForgetpassEntity {
 
  final String message;
  final String userId;

  const ForgetpassEntity({
  required this.message,
   required this.userId
  });
}
