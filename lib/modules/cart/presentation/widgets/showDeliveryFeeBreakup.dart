import 'package:flutter/material.dart';

class DeliveryFeeBreakupDialog extends StatelessWidget {
  const DeliveryFeeBreakupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Delivery Fee Breakup",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(0xFF23262F)),
                  ),
                  Spacer(),
                  Text(
                    "₹25",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF23262F)),
                  ),
                ],
              ),
              SizedBox(height: 11),
              Divider(color: Colors.grey.shade300, thickness: 0.3),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "For orders below ₹99",
                      style: TextStyle(color: Color(0xFF23262F), fontSize: 12),
                    ),
                  ),
                  Text(
                    "₹25",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xFF23262F)),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "For orders above ₹99",
                      style: TextStyle(color: Color(0xFF23262F), fontSize: 12),
                    ),
                  ),
                  Text(
                    "FREE",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(0xFF27A844)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper to show dialog
  static void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) => const DeliveryFeeBreakupDialog(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
            reverseCurve: Curves.easeIn,
          ),
          child: child,
        );
      },
    );
  }
}
