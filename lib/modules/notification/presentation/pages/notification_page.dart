import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/core/utils/smartcachedImag.dart';
import 'package:mohalla_bazaar/modules/notification/domain/entities/notification_entity.dart';
import 'package:mohalla_bazaar/modules/notification/presentation/pages/deletenotification.dart';
import 'package:mohalla_bazaar/presentation/widgets/noglowbehavour.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    final box = GetStorage();
    final userid = box.read("userid");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userid != null && userid is String && userid.isNotEmpty) {
        context.read<NotificationBloc>().add(NotificationRequested(userid));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return Column(
            children: [
              /// Status Bar
              Container(
                height: MediaQuery.of(context).padding.top,
                color: AppsColors.primary,
              ),

              /// Header
              const _NotificationHeader(),
 
              /// Notification List / Empty / Loader
              Expanded(
                child: state.status == NotificationStatus.loading
                    ? const Center(child: _EmptyNotificationView())
                    : state.status == NotificationStatus.failure
                        ? const Center(child: _EmptyNotificationView())
                        : state.notifications.isEmpty
                            ? const Center(child: _EmptyNotificationView())
                            : ScrollConfiguration(
                                behavior: NoGlowBehavior(),
                                child: ListView.separated(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 10.h,
                                  ),
                                  itemCount: state.notifications.length,
                                  separatorBuilder: (_, __) => Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    final n = state.notifications[index];
                                    return _NotificationItem(notif: n);
                                  },
                                ),
                              ),
              ),

              /// Bottom Promo
              const PromoBottomCard(
                message: "Har zaroorat,\nBas kuch minute mein\ndelivered",
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Header widget
class _NotificationHeader extends StatelessWidget {
  const _NotificationHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppsColors.primary,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => NavHelper.backTonotification(),
            child: Container(
              width: 35.w,
              height: 35.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  CupertinoIcons.back,
                  size: 22.sp,
                  color: AppsColors.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 27.sp, color: Colors.white),
                    children: const [
                      TextSpan(
                        text: "mohalla ",
                        style: TextStyle(fontFamily: 'Geometry'),
                      ),
                      TextSpan(
                        text: "bazaar",
                        style: TextStyle(
                          fontFamily: 'Geometry',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Delivery in 30 minutes",
                  style: TextStyle(fontSize: 12.sp, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Notification Item
class _NotificationItem extends StatelessWidget {
  final NotificationEntity notif;
  const _NotificationItem({required this.notif});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppsColors.primary,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(8.w),
          child: const Icon(
            Icons.notifications,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      notif.title,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    (() {
                      final createdAt =
                          DateTime.tryParse(notif.createdAt)?.toLocal() ??
                              DateTime.now();
                      final now = DateTime.now();
                      final diff = now.difference(createdAt);
                      if (diff.inMinutes < 1) return 'Just now';
                      if (diff.inHours < 1) return '${diff.inMinutes} min ago';
                      if (diff.inDays < 1) return '${diff.inHours} hour ago';
                      final daysAgo = now.difference(
                        DateTime(createdAt.year, createdAt.month, createdAt.day),
                      ).inDays;
                      if (daysAgo == 1) return 'Yesterday';
                      return '$daysAgo days ago';
                    })(),
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                notif.message,
                style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.more_vert, size: 22.sp, color: Colors.grey),
          onPressed: () => _showBottomSheet(context, notif),
        ),
      ],
    );
  }
}

/// Bottom Sheet for each notification
void _showBottomSheet(BuildContext context, NotificationEntity notif) {
  final box = GetStorage();
  final userid = box.read("userid");
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
    ),
    isScrollControlled: true,
    builder: (_) => Padding(
      padding: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(6.w),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.black87,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    notif.title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              notif.message,
              style: TextStyle(fontSize: 13.sp, color: Colors.black),
            ),
            SizedBox(height: 6.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: (notif.image.isNotEmpty)
                  ? SmartCachedImage(
                      imageUrl: notif.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      height: 150.h,
                      color: Colors.grey.shade300,
                      child: Icon(
                        Icons.image,
                        color: Colors.white54,
                        size: 40.sp,
                      ),
                    ),
            ),
            SizedBox(height: 22.h),
            Divider(color: Colors.grey.shade300),
            ListTile(
              leading: Icon(Icons.delete_outline, size: 22.sp),
              title: Text(
                "Delete this notification",
                style: TextStyle(fontSize: 13.sp),
              ),
              onTap: () async {
                Navigator.pop(context);
                await deleteNotification(
                  userId: userid,
                  notificationId: notif.id,
                );
                context.read<NotificationBloc>().add(NotificationRequested(userid));
              },
            ),
          ],
        ),
      ),
    ),
  );
}

/// Empty notification placeholder
class _EmptyNotificationView extends StatelessWidget {
  const _EmptyNotificationView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200.w,
                height: 200.w,
                decoration: BoxDecoration(
                  color: AppsColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: SmartCachedImage(
                  fit: BoxFit.contain,
                  height: 100.h,
                  imageUrl:
                      "https://img.freepik.com/premium-vector/social-media-marketing-audience-growth-angry-woman-sitting-with-mobile-browsing-net_531064-1094.jpg",
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "No Notifications Yet",
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                "You haven’t received any notifications yet.\nStay tuned for updates and offers!",
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey.shade600,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom Promo Card
class PromoBottomCard extends StatelessWidget {
  final String message;
  const PromoBottomCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                height: 1.3,
              ),
              children: [
                const TextSpan(text: "Har zaroorat,\n"),
                const TextSpan(text: "Bas kuch minute mein\n"),
                TextSpan(
                  text: "delivered ",
                  style: TextStyle(color: AppsColors.primary),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 10.sp, color: Colors.black87),
              children: [
                const TextSpan(text: "Thank you for your trust — with love, "),
                TextSpan(
                  text: "Mohalla Bazaar Team",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppsColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
