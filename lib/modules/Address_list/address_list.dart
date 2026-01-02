import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohalla_bazaar/core/network/sqlite_client.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/modules/User_location/user_location.dart';
 
class AddressListPage extends StatefulWidget {
  const AddressListPage({super.key});

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List<Map<String, dynamic>> _addresses = [];
  bool _initialRedirectDone = false; // ✅ Track first redirect

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    final data = (await SQLiteClient.getAddresses())
        .map((addr) => Map<String, dynamic>.from(addr))
        .toList();

    // Auto select first address if only 1
    if (data.length == 1) {
      data[0]['isSelected'] = 1;
      await SQLiteClient.selectAddress(data[0]['id']);
    }

    setState(() => _addresses = data);

    // ✅ Redirect to location page only once if empty
    if (_addresses.isEmpty && !_initialRedirectDone) {
      _initialRedirectDone = true;
      _goToLocationPage();
    }
  }

  void _goToLocationPage() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const AccurateLocationPage()),
    );

    // Reload only if new address added
    if (result == true) {
      _loadAddresses();
    }
  }

  void _selectAddress(int id) async {
    for (var addr in _addresses) {
      addr['isSelected'] = addr['id'] == id ? 1 : 0;
    }
    setState(() {});
    await SQLiteClient.selectAddress(id);
  }

  void _deleteAddress(int id) async {
    await SQLiteClient.deleteAddress(id);
    _loadAddresses();
  }

  void _editAddress({required Map<String, dynamic> existing}) async {
    final detailController = TextEditingController(text: existing['detail']);

    await showDialog(
      context: context,
      builder: (ctx) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Edit Address",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: detailController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Detail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: AppsColors.primary),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                ),
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45.h,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 14.sp, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: SizedBox(
                      height: 45.h,
                      child: ElevatedButton(
                        onPressed: () async {
                          await SQLiteClient.updateAddress(existing['id'], {
                            'title': existing['title'],
                            'detail': detailController.text,
                            'latitude': existing['latitude'],
                            'longitude': existing['longitude'],
                            'isSelected': existing['isSelected'],
                          });
                          Navigator.pop(ctx);
                          _loadAddresses();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppsColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
        leadingWidth: 45.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () => Navigator.pop(context),
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
        ),
        title: Text(
          "My Addresses",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: _addresses.isEmpty
          ? Center(
              child: Text(
                "No addresses found.\nTap + to add a new address",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
              itemCount: _addresses.length,
              itemBuilder: (ctx, i) {
                final addr = _addresses[i];
                return Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.6),
                          width: 0.5.w,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.scale(
                              scale: 1,
                              child: Checkbox(
                                value: addr['isSelected'] == 1,
                                activeColor: AppsColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                onChanged: (bool? value) =>
                                    _selectAddress(addr['id']),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    addr['title'],
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    addr['detail'] ?? '',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 100.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () => _editAddress(existing: addr),
                                    child: Container(
                                      padding: EdgeInsets.all(6.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: AppsColors.primary,
                                        size: 22.sp,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => _deleteAddress(addr['id']),
                                    child: Container(
                                      padding: EdgeInsets.all(6.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                      ),
                                      child: Icon(
                                        Icons.delete,
                                        color: AppsColors.primary,
                                        size: 22.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: SizedBox(
        width: 60.w,
        height: 60.w,
        child: FloatingActionButton(
          backgroundColor: AppsColors.primary,
          onPressed: _goToLocationPage,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 28.sp,
          ),
        ),
      ),
    );
  }
}
