/// User entity (Domain में हमेशा साफ और simple class होती है)
class User {
  final String id;
  final String name;
  final String phone;

  const User({
    required this.id,
    required this.name,
    required this.phone,
  });
}
