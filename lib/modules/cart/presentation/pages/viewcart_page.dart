// Path: lib/features/viewcart/presentation/pages/viewcart_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/viewcart_bloc.dart';
import '../bloc/viewcart_event.dart';
import '../bloc/viewcart_state.dart';
import '../../domain/entities/viewcart_entity.dart';

class ViewCartPage extends StatefulWidget {


  const ViewCartPage({super.key});

  @override
  State<ViewCartPage> createState() => _ViewCartPageState();
}

class _ViewCartPageState extends State<ViewCartPage> {
  @override
  void initState() { 
    super.initState();
     Future.microtask(() {
      context.read<ViewCartBloc>().add(LoadViewCart(userId: "U-0001"));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ViewCartBloc>().add(LoadViewCart(userId: "U-0001", forceRefresh: true));
            },
          )
        ],
      ),
      body: BlocBuilder<ViewCartBloc, ViewCartState>(
        builder: (context, state) {
          if (state.status == ViewCartStatus.loading && state.cart == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ViewCartStatus.failure) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state.cart == null) {
            return const Center(child: Text('No items in cart'));
          } else {
            final cart = state.cart!;
            return Column(
              children: [
                Expanded(child: _CartList(cart: cart)),
                _CartSummary(cart: cart),
              ],
            );
          }
        },
      ),
    );
  }
}

class _CartList extends StatefulWidget {
  final ViewCartEntity cart;
  const _CartList({required this.cart});

  @override
  State<_CartList> createState() => _CartListState();
}

class _CartListState extends State<_CartList> {
  final Map<String, int> _quantities = {};

  @override
  void initState() {
    super.initState();
    for (var item in widget.cart.cartList) {
      _quantities[item.productId] = item.quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cart.cartList.isEmpty) {
      return const Center(child: Text('Cart is empty'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: widget.cart.cartList.map((item) {
          final qty = _quantities[item.productId] ?? item.quantity;

          return _CartItemCard(
            imageUrl: item.productImage,
            name: item.productName,
            subtitle: item.productId ?? "1 Pack", // fallback
            quantity: qty,
            price: item.discountPrice,
            originalPrice: item.price,
            onIncrease: () {
              setState(() {
                _quantities[item.productId] = qty + 1;
              });
            },
            onDecrease: () {
              if (qty > 1) {
                setState(() {
                  _quantities[item.productId] = qty - 1;
                });
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
class _CartItemCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String subtitle;
  final num quantity;
  final num price;
  final num originalPrice;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const _CartItemCard({
    required this.imageUrl,
    required this.name,
    required this.subtitle,
    required this.quantity,
    required this.price,
    required this.originalPrice,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image, size: 60, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 14),

          // Product Name + Subtitle (stacked)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle, // e.g., "1 Pack / 900-1000 gm"
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Stepper + Price Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  // Stepper
                 // Stepper Container
Container(
  height: 28, // chhota height
 
 
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(6),
    color: Colors.green,
  ),
  child: Row(
  
    children: [
     
       Icon(Icons.remove, size: 14, color: Colors.white), // chhota icon
       
      
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          "$quantity",
          style: const TextStyle(fontSize: 12, color: Colors.white), // chhota text
        ),
      ),
      Icon(
      
      Icons.add, size: 14, color: Colors.white), // chhota icon

    
    ],
  ),
),

                  const SizedBox(width: 8),

                  // Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹$price",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      if (originalPrice > price)
                        Text(
                          "₹$originalPrice",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  final ViewCartEntity cart;
  const _CartSummary({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Subtotal'),
            Text('₹${cart.cartTotalAmount.toString()}'),
          ]),
          const SizedBox(height: 6),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Total Savings'),
            Text('₹${cart.totalSaveAmount.toString()}'),
          ]),
          const Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Grand Total', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('₹${cart.grandTotal.toString()}', style: const TextStyle(fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // proceed to order flow
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Proceed to checkout')));
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(44)),
            child: const Text('Place Order'),
          )
        ],
      ),
    );
  }
}
