import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mohalla_bazaar/core/network/sqlite_client.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/pages/createaccountpage.dart';

class AccurateLocationPage extends StatefulWidget {
  const AccurateLocationPage({super.key});

  @override
  State<AccurateLocationPage> createState() => _AccurateLocationPageState();
}

class _AccurateLocationPageState extends State<AccurateLocationPage> {
  final TextEditingController addressLine1Controller =
      TextEditingController();
  final TextEditingController addressLine2Controller =
      TextEditingController();

  GoogleMapController? _controller;

  // Static location
  final LatLng _staticLocation = const LatLng(27.8942, 79.1972);

  @override
  void dispose() {
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    _controller?.dispose();
    super.dispose();
  }

 /// ✅ SAVE ADDRESS (both fields mandatory)
Future<void> _saveAddress() async {
  final line1 = addressLine1Controller.text.trim();
  final line2 = addressLine2Controller.text.trim();

  if (line1.isEmpty || line2.isEmpty) {
    showErrorDialog(
      context,
      "Please fill both Address Line 1 and Address Line 2",
      success: false,
    );
    return;
  }

  // Combine address
  final fullAddress = "$line1, $line2";

  await SQLiteClient.insertAddress({
    'title': "Address",
    'detail': fullAddress,
    'latitude': _staticLocation.latitude,
    'longitude': _staticLocation.longitude,
    'isSelected': 0,
  });

  if (mounted) {
    Navigator.pop(context, true); // success
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Location",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
         leadingWidth: 45.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () => Navigator.pop(context,false ),
            child: Container(
              width: 38.w,
              height: 38.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18.sp,
                color: Colors.black,
              ),
            ),
          ),
        )
         
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              /// 🔹 Address Line 1
              Text(
                "Address Line 1",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              TextField(
                controller: addressLine1Controller,
                decoration: InputDecoration(
                  hintText: "Street, Area",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: AppsColors.primary,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                ),
              ),

              SizedBox(height: 14.h),

              /// 🔹 Address Line 2
              Text(
                "Address Line 2",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              TextField(
                controller: addressLine2Controller,
                decoration: InputDecoration(
                  hintText: "Near by Area",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: AppsColors.primary,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              /// 💾 Save Button
              SizedBox(
                width: 1.sw,
                height: 42.h,
                child: ElevatedButton(
                  onPressed: _saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppsColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    "Save Address",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
