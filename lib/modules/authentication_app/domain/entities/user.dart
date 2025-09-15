/// User entity (Domain में हमेशा साफ और simple class होती है)
class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });
}
