import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class OrderNowSubmitted extends OrderEvent {
  final String userId;
   final String useraddress;

  const OrderNowSubmitted(this.userId,this.useraddress);

  @override
  List<Object?> get props => [userId,useraddress];
}
