import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import '../bloc/category_details_bloc.dart';
import '../bloc/category_details_event.dart';
import '../bloc/category_details_state.dart';
import '../../domain/entities/category_details_entity.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryDetailsPage extends StatelessWidget {
  const CategoryDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger products fetch on page load
    context.read<CategoryDetailsBloc>().add(
      CategoryProductsRequested("C-0001"),
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
              color: AppsColors.primary,
            ),
            _buildAppBarContent(),
          ],
        ),
      ),
      body: BlocBuilder<CategoryDetailsBloc, CategoryDetailsState>(
        builder: (context, state) {
          if (state.status == CategoryDetailsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == CategoryDetailsStatus.failure) {
            return Center(
              child: Text(
                "Something went wrong!\n${state.error}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state.status == CategoryDetailsStatus.success) {
            final products = state.products;
            if (products.isEmpty) {
              return const Center(child: Text("No products available"));
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const minItemWidth = 150;

                  // Screen width / minItemWidth = number of columns
                  int crossAxisCount = (constraints.maxWidth / minItemWidth)
                      .floor();

                  // Minimum 4 columns on small screens, max 6
                  crossAxisCount = crossAxisCount.clamp(4, 6);

                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 0,
                      childAspectRatio: 60 / 120,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return BestsellerCard1(product);
                    },
                  );
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildAppBarContent() => Container(
    color: AppsColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
    child: Row(
      children: [
        GestureDetector(
          onTap: () => NavHelper.backTocategorydetails(),
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

/// BestsellerCard1 Widget
class BestsellerCard1 extends StatefulWidget {
  final ProductEntity product;
  const BestsellerCard1(this.product, {super.key});

  @override
  State<BestsellerCard1> createState() => _BestsellerCard1State();
}

class _BestsellerCard1State extends State<BestsellerCard1>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ValueNotifier<bool> isFavorite = ValueNotifier(false);

  @override
  void dispose() {
    isFavorite.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final p = widget.product;

    return GestureDetector(
      onTap: () {
        final box = GetStorage();
        box.write(
          'productslistfromcategorydetailspage',
          widget.product.toJson(),
        );
        NavHelper.goToproducsdetails(); // Navigation
      },

      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.6),
                        width: 0.5,
                      ),
                    ),
                    child: SizedBox(
                      child: Image.network(
                        p.productimage,
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 1,
                    right: 1,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: isFavorite,
                      builder: (_, fav, __) => GestureDetector(
                        onTap: () => isFavorite.value = !fav,
                        child: Icon(
                          fav ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 5,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.network(
                          'https://res.cloudinary.com/dlhbrpbfr/image/upload/v1758647486/a_v6boeq.svg',
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "9%\n OFF",
                          style: TextStyle(
                            fontSize: 9,

                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8), // background color
                      borderRadius: BorderRadius.circular(6), // rounded corners
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.watch_later_outlined, // watch/clock icon
                          size: 10, // icon size
                          color: Colors.black, // icon color
                        ),
                        const SizedBox(width: 4), // spacing between icon & text
                        Text(
                          p.producttime,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    p.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    p.productquantity,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppsColors.textclourgray,
                    ),
                  ),

                  if (p.productsaveAmount > 0) ...[
                    Text(
                      "SAVE ₹${p.productsaveAmount}",
                      style: const TextStyle(fontSize: 10, color: Colors.green),
                    ),
                  ],

                  _buildPriceRow(p),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildPriceRow(ProductEntity p) => Row(
    children: [
      Column(
        children: [
          Text(
            "₹${p.productdiscountPrice}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
          const SizedBox(width: 5),
          if (p.productprice != p.productdiscountPrice)
            Text(
              "₹${p.productprice}",
              style: const TextStyle(
                fontSize: 10,
                color: AppsColors.textclourgray,
                decoration: TextDecoration.lineThrough,
              ),
            ),
        ],
      ),
      Spacer(),
      Container(
        width: 50, // Approx image width
        height: 30, // Approx image height
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          // Light green bg
          border: Border.all(
            color: Color(0xffFB5D92),
            width: 1,
          ), // Green border
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            "ADD",
            style: TextStyle(
              fontSize: 10,
              color: Color(0xffFB5D92),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}
