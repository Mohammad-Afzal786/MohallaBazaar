import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cartcount_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cartcount_state.dart';




class CartCountText extends StatelessWidget {

   final double fontSize;
  const CartCountText({super.key,  required this.fontSize,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCountBloc, CartCountState>(
      builder: (context, state) {
        int count = 0;
        if (state is CartCountLoaded) count = state.count;

        return Text(
          '$count',
          style: TextStyle(
           
            fontSize: fontSize,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
