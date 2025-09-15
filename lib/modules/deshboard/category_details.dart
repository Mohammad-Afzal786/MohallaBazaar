import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key});

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  // Scroll/selection sync
  final ScrollController _scrollController = ScrollController();
  bool _isScrollingByTap = false;
  int selectedCategoryIndex = 0;

  // Stability timers
  Timer? _throttle;
  Timer? _tapLock;

  // Sort/data notifiers
  late final ValueNotifier<String> sortNotifier;
  late final ValueNotifier<Map<String, List<Map<String, dynamic>>>>
  groupedNotifier;

  // Section header keys (optional)
  late final List<GlobalKey> _productCategoryKeys;

  // Item visibility tracking
  final Map<int, GlobalKey> _itemKeys = {}; // flat index -> key
  final Map<int, String> _itemCatByFlat = {}; // flat index -> category
  final List<int> _sectionStartFlatIndex =
      []; // per category section start flat index
  List<Map<String, dynamic>> _flat = []; // flattened products in render order

  // Categories
  final List<Map<String, String>> categories = [
    {
      "name": "chips-crisps",
      "image":
          "https://cdn.zeptonow.com/production/tr:w-90,ar-120-121,pr-true,f-auto,q-80/cms/sub_category/106.png",
    },
    {
      "name": "namkeens",
      "image":
          "https://cdn.zeptonow.com/production/tr:w-90,ar-120-121,pr-true,f-auto,q-80/cms/sub_category/107.png",
    },
    {
      "name": "Popcorn",
      "image":
          "https://cdn.zeptonow.com/production/tr:w-90,ar-1470-1470,pr-true,f-auto,q-80/cms/sub_category/69a02067-858e-4264-91da-3acad395941e.png",
    },
  ]; // [13]

  // Mock products (trimmed for brevity) [20]
  // Mock products
  /// 🔹 Mock Products with Categories
  final List<Map<String, dynamic>> products = [
    {
      "category": "chips-crisps",
      "image": "image 31.png",
      "productName": "Uncle Chipps Spicy Treat Flavour Potato Chips",
      "quantity": "1 pc",
      "price": 25,
      "discountPrice": 20,
      "saveAmount": 5,
      "rating": 4.4,
      "reviews": "2.08 lac",
      "time": "10 mins",
    },
    {
      "category": "chips-crisps",
      "image": "image 31.png",
      "productName": "Uncle Chipps Spicy Treat Flavour Potato Chips",
      "quantity": "1 pc",
      "price": 25,
      "discountPrice": 20,
      "saveAmount": 5,
      "rating": 4.4,
      "reviews": "2.08 lac",
      "time": "10 mins",
    },
    {
      "category": "chips-crisps",
      "image": "image 31.png",
      "productName": "Uncle Chipps Spicy Treat Flavour Potato Chips",
      "quantity": "1 pc",
      "price": 25,
      "discountPrice": 20,
      "saveAmount": 5,
      "rating": 4.4,
      "reviews": "2.08 lac",
      "time": "10 mins",
    },
    {
      "category": "chips-crisps",
      "image": "image 31.png",
      "productName": "Uncle Chipps Spicy Treat Flavour Potato Chips",
      "quantity": "1 pc",
      "price": 25,
      "discountPrice": 20,
      "saveAmount": 5,
      "rating": 4.4,
      "reviews": "2.08 lac",
      "time": "10 mins",
    },

    {
      "category": "chips-crisps",
      "image": "image 31.png",
      "productName": "Uncle Chipps Spicy Treat Flavour Potato Chips",
      "quantity": "1 pc",
      "price": 25,
      "discountPrice": 20,
      "saveAmount": 5,
      "rating": 4.4,
      "reviews": "2.08 lac",
      "time": "10 mins",
    },

    {
      "category": "chips-crisps",
      "image": "image 31.png",
      "productName": "Uncle Chipps Spicy Treat Flavour Potato Chips",
      "quantity": "1 pc",
      "price": 25,
      "discountPrice": 20,
      "saveAmount": 5,
      "rating": 4.4,
      "reviews": "2.08 lac",
      "time": "10 mins",
    },

    {
      "category": "chips-crisps",
      "image": "image 31.png",
      "productName": "Uncle Chipps Spicy Treat Flavour Potato Chips",
      "quantity": "1 pc",
      "price": 25,
      "discountPrice": 20,
      "saveAmount": 5,
      "rating": 4.4,
      "reviews": "2.08 lac",
      "time": "10 mins",
    },

    {
      "category": "namkeens",
      "image": "image 31.png",
      "productName": "Haldiram’s Aloo Bhujia",
      "quantity": "200 g",
      "price": 55,
      "discountPrice": 48,
      "saveAmount": 7,
      "rating": 4.7,
      "reviews": "3.2 lac",
      "time": "10 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 25,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
    {
      "category": "Popcorn",
      "image": "image 31.png",
      "productName": "Act II Classic Salted Popcorn",
      "quantity": "1 pc",
      "price": 30,
      "discountPrice": 2,
      "saveAmount": 5,
      "rating": 4.6,
      "reviews": "1.2 lac",
      "time": "8 mins",
    },
  ];

  @override
  void initState() {
    super.initState();
    _productCategoryKeys = List.generate(categories.length, (_) => GlobalKey());
    _scrollController.addListener(_onScroll); // [20]

    sortNotifier = ValueNotifier<String>("Relevance (default)"); // [21]
    groupedNotifier = ValueNotifier<Map<String, List<Map<String, dynamic>>>>(
      {},
    ); // [21]
    _rebuildGroupedAndSort(sortNotifier.value); // [17]

    sortNotifier.addListener(() {
      _rebuildGroupedAndSort(sortNotifier.value); // [17]
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll); // [20]
    _scrollController.dispose(); // [20]
    _throttle?.cancel(); // [18]
    _tapLock?.cancel(); // [18]
    sortNotifier.dispose(); // [21]
    groupedNotifier.dispose(); // [21]
    super.dispose();
  }

  // Group + sort + flatten with keys
  void _rebuildGroupedAndSort(String criterion) {
    final groupedRaw = {
      for (var c in categories)
        c['name']!: products.where((p) => p['category'] == c['name']).toList(),
    }; // [10]

    final sortedMap = <String, List<Map<String, dynamic>>>{};
    for (final e in groupedRaw.entries) {
      sortedMap[e.key] = _sortedList(e.value, criterion); // [17]
    }

    _flat = [];
    _itemKeys.clear();
    _itemCatByFlat.clear();
    _sectionStartFlatIndex.clear();

    for (int ci = 0; ci < categories.length; ci++) {
      final cat = categories[ci]['name']!;
      _sectionStartFlatIndex.add(_flat.length);
      final list = sortedMap[cat] ?? const [];
      for (int j = 0; j < list.length; j++) {
        final flatIndex = _flat.length;
        _flat.add(list[j]);
        _itemKeys[flatIndex] = GlobalKey();
        _itemCatByFlat[flatIndex] = cat;
      }
    }

    groupedNotifier.value = sortedMap; // [17]
  }

  List<Map<String, dynamic>> _sortedList(
    List<Map<String, dynamic>> list,
    String criterion,
  ) {
    final copy = List<Map<String, dynamic>>.from(list); // [17]
    switch (criterion) {
      case "Price (low to high)":
        copy.sort(
          (a, b) =>
              (a['discountPrice'] as num).compareTo(b['discountPrice'] as num),
        );
        break;
      case "Price (high to low)":
        copy.sort(
          (a, b) =>
              (b['discountPrice'] as num).compareTo(a['discountPrice'] as num),
        );
        break;
      case "Discount (high to low)":
        copy.sort((a, b) {
          final da = (a['price'] as num) - (a['discountPrice'] as num);
          final db = (b['price'] as num) - (b['discountPrice'] as num);
          return db.compareTo(da);
        });
        break;
      default:
        break;
    }
    return copy;
  }

  // Throttled scroll listener
  void _onScroll() {
    if (_isScrollingByTap || (_tapLock?.isActive ?? false)) return; // [16]
    if (_throttle?.isActive ?? false) return; // [18]
    _throttle = Timer(
      const Duration(milliseconds: 80),
      _updateActiveByTopItem,
    ); // [18]
  }

  // Exact animateTo to align item top with sticky boundary
  Future<void> _scrollItemToStickyTop(GlobalKey itemKey) async {
    final ctx = itemKey.currentContext;
    if (ctx == null) return;

    // Sticky boundary: status + AppBar + pinned sort header [16]
    final double statusTop = MediaQuery.of(context).padding.top;
    const double appBarH = kToolbarHeight; // 56
    const double stickyH = 90; // SliverPersistentHeader height
    final double boundary = statusTop + appBarH + stickyH;

    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;

    final double itemTop = box.localToGlobal(Offset.zero).dy; // [8]
    final double current = _scrollController.position.pixels;
    final double delta = itemTop - boundary;
    final double target = (current + delta).clamp(
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );

    await _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeInOut,
    ); // [16][5]
  }

  // Detect top-most visible product card and set its category active
  void _updateActiveByTopItem() {
    final double statusTop = MediaQuery.of(context).padding.top;
    const double appBarH = kToolbarHeight; // 56
    const double stickyH = 50; // pinned sort header height
    final double boundary = statusTop + appBarH + stickyH; // [16]

    double bestTop = double.infinity;
    int? bestFlat;

    _itemKeys.forEach((flat, key) {
      final ctx = key.currentContext;
      if (ctx == null) return;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) return;

      final top = box.localToGlobal(Offset.zero).dy; // [8]
      final bottom = top + box.size.height;

      if (bottom <= boundary) return; // fully above

      if (top <= boundary && bottom > boundary) {
        bestTop = boundary;
        bestFlat = flat;
        return;
      }

      if (top >= boundary && top < bestTop) {
        bestTop = top;
        bestFlat = flat;
      }
    });

    if (bestFlat != null) {
      final cat = _itemCatByFlat[bestFlat]!;
      final newIndex = categories.indexWhere((c) => c['name'] == cat);
      if (newIndex != -1 && newIndex != selectedCategoryIndex) {
        setState(() => selectedCategoryIndex = newIndex); // [16]
      }
    }
  }

  // Category tap → snap first product to sticky boundary
  void _onCategoryTap(int index) async {
    if (index < 0 || index >= categories.length) return;

    setState(() => selectedCategoryIndex = index); // immediate highlight [16]

    _tapLock?.cancel();
    _isScrollingByTap =
        true; // ignore scroll updates during programmatic jump [16]

    if (index < _sectionStartFlatIndex.length) {
      final flatStart = _sectionStartFlatIndex[index];
      final key = _itemKeys[flatStart];
      if (key?.currentContext != null) {
        await _scrollItemToStickyTop(key!); // exact sticky snap [16][5]
      } else {
        // Fallback to header if item not built yet
        final headerCtx = _productCategoryKeys[index].currentContext;
        if (headerCtx != null) {
          await Scrollable.ensureVisible(
            headerCtx,
            duration: const Duration(milliseconds: 400),
            alignment: 0.0,
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
            curve: Curves.easeInOut,
          ); // [16][4]
        }
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateActiveByTopItem(); // resync after layout [16]
    });

    _tapLock = Timer(const Duration(milliseconds: 140), () {
      _isScrollingByTap = false; // resume detection [18]
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) NavHelper.backTocategorydetails();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: 12.w,
              right: 12.w,
            ),
            color: AppsColors.primary,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 27.sp,
                            color: Colors.white,
                          ),
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
          ),
        ),
       
        body: Row(
          children: [
            // Left Category Menu
            Container(
              width: 86,
              color: Colors.white,
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  bool isSelected = index == selectedCategoryIndex;
                  var category = categories[index];
                  return GestureDetector(
                    onTap: () => _onCategoryTap(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedScale(
                                  scale: isSelected ? 1.1 : 1.0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  child: Image.network(
                                    category['image']!,
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  style: TextStyle(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                  child: Text(
                                    category['name']!,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              width: 4,
                              height: 90,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Divider
            Container(width: 1, color: Colors.grey.withOpacity(0.3)),

            // Right side
            Expanded(
              child: Column(
                children: [
                  // Sticky sort header
                  SizedBox(
                    height: 50,
                    child: ValueListenableBuilder<String>(
                      valueListenable: sortNotifier,
                      builder: (context, currentSort, _) {
                        return Container(
                          color: Colors.white,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // _buildChip(label: "Filters", icon: Icons.filter_list, onTap: () {}),
                                _buildChip(
                                  label: "Sort: $currentSort",
                                  icon: Icons.swap_vert,
                                  onTap: () async {
                                    final selected = await _showSortBottomSheet(
                                      context,
                                      currentSort,
                                    );
                                    if (selected != null)
                                      sortNotifier.value = selected; // [17]
                                  },
                                ),
                                // _buildChip(label: "Brand", onTap: () {}),
                                // _buildChip(label: "More", onTap: () {}),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Products area
                  Expanded(
                    child:
                        ValueListenableBuilder<
                          Map<String, List<Map<String, dynamic>>>
                        >(
                          valueListenable: groupedNotifier,
                          builder: (context, groupedProductsSorted, _) {
                            return CustomScrollView(
                              controller: _scrollController,
                              slivers: [
                                for (int i = 0; i < categories.length; i++) ...[
                                  SliverToBoxAdapter(
                                    child: Container(
                                      key: _productCategoryKeys[i],
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Divider(
                                              color: Colors.grey.shade400,
                                              thickness: 0.8,
                                              endIndent: 10,
                                            ),
                                          ),
                                          ShaderMask(
                                            shaderCallback: (bounds) =>
                                                const LinearGradient(
                                                  colors: [
                                                    Colors.green,
                                                    AppsColors.primary,
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ).createShader(bounds),
                                            child: Text(
                                              categories[i]['name']!,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Divider(
                                              color: Colors.grey.shade400,
                                              thickness: 0.8,
                                              indent: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SliverGrid(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        final cat = categories[i]['name']!;
                                        final list =
                                            groupedProductsSorted[cat] ??
                                            const [];
                                        final product = list[index];
                                        final flatIndex =
                                            _sectionStartFlatIndex[i] + index;
                                        final itemKey = _itemKeys[flatIndex]!;
                                        return KeyedSubtree(
                                          key: itemKey,
                                          child: BestsellerCard1(
                                            product: product,
                                          ),
                                        );
                                      },
                                      childCount:
                                          (groupedProductsSorted[categories[i]['name']!] ??
                                                  const [])
                                              .length,
                                    ),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 12,
                                          crossAxisSpacing: 12,
                                          childAspectRatio: 0.52,
                                        ),
                                  ),
                                ],
                              ],
                            );
                          },
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip({
    IconData? icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: Colors.black87),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(Icons.arrow_drop_down, size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}

// Bottom sheet same as before [16]
Future<String?> _showSortBottomSheet(BuildContext context, String current) {
  String selectedOption = current;

  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: false,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sort by",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  for (final opt in const [
                    "Relevance (default)",
                    "Price (low to high)",
                    "Price (high to low)",
                    "Discount (high to low)",
                  ])
                    RadioListTile<String>(
                      activeColor: Colors.green,
                      title: Text(opt),
                      value: opt,
                      groupValue: selectedOption,
                      onChanged: (val) {
                        setModalState(() => selectedOption = val!);
                        Navigator.pop(context, val); // [16]
                      },
                    ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class BestsellerCard1 extends StatefulWidget {
  final Map<String, dynamic> product;
  const BestsellerCard1({super.key, required this.product});

  @override
  State<BestsellerCard1> createState() => _BestsellerCard1State();
}

class _BestsellerCard1State extends State<BestsellerCard1> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image + Wishlist + Tag
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: Colors.grey.withOpacity(0.6),
                width: 0.5,
              ),
            ),
           child: ClipRRect(
  borderRadius: BorderRadius.circular(8.r),
  child: Stack(
    children: [
      Positioned.fill(
        child: GestureDetector(
          onTap: () async {
            NavHelper.goToproducsdetails();
          },
          child: Image.asset(
            "assets/images/${widget.product["image"]}",
            fit: BoxFit.contain,
          ),
        ),
      ),
      Positioned(
        top: 6,
        right: 6,
        child: GestureDetector(
          onTap: () async {
            HapticFeedback.selectionClick();
            setState(() => isFavorite = !isFavorite);
          },
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
            size: 18.sp,
          ),
        ),
      ),
      Positioned(
        top: 6,
        left: 6,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            "Bestseller",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  ),
),

         
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "₹${widget.product['discountPrice']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.sp,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (widget.product["price"] !=
                        widget.product["discountPrice"])
                      Text(
                        "₹${widget.product['price']}",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppsColors.textclourgray,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.product['quantity'],
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppsColors.textclourgray,
                  ),
                ),
                const SizedBox(height: 4),
                if (widget.product["saveAmount"] != null &&
                    widget.product["saveAmount"] > 0)
                  Text(
                    "SAVE ₹${widget.product["saveAmount"]}",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppsColors.savetextclour,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  widget.product['productName'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.sp),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.green, size: 16.sp),
                    const SizedBox(width: 3),
                    Text(
                      widget.product['rating'].toString(),
                      style: TextStyle(fontSize: 12.sp, color: Colors.green),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "(${widget.product['reviews']})",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppsColors.textclourgray,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  widget.product['time'],
                  style: TextStyle(
                    color: AppsColors.textclourgray,
                    fontSize: 10.sp,
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
