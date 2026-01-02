import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Orders',
    'Payments',
    'Account',
    'Delivery',
  ];

  final List<_FAQItem> _faqItems = [
    _FAQItem(
      question: 'Kaise main order track karu?',
      answer:
          'Order screen par jaayiye → Orders → Select order → Track. Aapko live status aur ETA milega.',
      category: 'Orders',
    ),
    _FAQItem(
      question: 'Payment method kon kon sa h?',
      answer:
          'Payment method abhi sirf cash on delivery h future m online or upi feature b hoo jaayega',
      category: 'Payments',
    ),
    _FAQItem(
      question: 'Account ka password bhool gaya hu',
      answer:
          'Login screen par "Forgot Password" pe click karein aur registered email dale .sahi email hone pr new page open ho hoga jhn pr aap new pass enter kr skte h',
      category: 'Account',
    ),
    _FAQItem(
      question: 'Delivery late ho rahi hai',
      answer:
          'Sorry for inconvenience. Delivery may delay due to nny problem. Agar 30 min se zyada delay ho to "cutomer care pr cll krk " btaiye.',
      category: 'Delivery',
    ),
  ];

  List<_FAQItem> get _filteredFaqs {
    final q = _query.trim().toLowerCase();
    return _faqItems.where((f) {
      final matchCategory =
          _selectedCategory == 'All' || f.category == _selectedCategory;
      final matchQuery = q.isEmpty ||
          f.question.toLowerCase().contains(q) ||
          f.answer.toLowerCase().contains(q);
      return matchCategory && matchQuery;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showSnack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  void _openContactOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Contact Support',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
           SizedBox(
  width: double.infinity, // full width
  height: 45.h, // fixed responsive height
  child: ElevatedButton.icon(
    icon: Icon(Icons.call_outlined, size: 20.sp),
    label: Text(
      'Call Support',
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppsColors.primary, // your app’s main color
      foregroundColor: Colors.white, // icon & text color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 3, // soft shadow
    ),
    onPressed: () async {
      final Uri phoneUri = Uri(scheme: 'tel', path: '+918588003437');
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        _showSnack('Cannot make a call');
      }
      Navigator.pop(context);
    },
  ),
),
            SizedBox(height: 8.h),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(fontSize: 13.sp)),
            ),
          ],
        ),
      ),
    );
  }

  void openChat() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const _ChatDemoPage()));
  }

  void openCreateTicket() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _CreateTicketForm(onSubmit: (title, desc) {
          Navigator.pop(context);
          _showSnack('Ticket created: $title');
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppsColors.primary,
        iconTheme: IconThemeData(color: Colors.white, size: 22.sp),
        title: Row(
          children: [
            Icon(Icons.help_outline, color: Colors.white, size: 22.sp),
            SizedBox(width: 8.w),
            Text('Help Center',
                style: TextStyle(color: Colors.white, fontSize: 16.sp)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _openContactOptions,
            icon:
                Icon(Icons.headset_mic_outlined, color: Colors.white, size: 22.sp),
            tooltip: 'Contact Support',
          ),
        ],
      ),



      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Material(
  elevation: 1,
  borderRadius: BorderRadius.circular(12.r),
  child: SizedBox(
    height: 45.h, // 👈 fixed responsive height
    child: TextField(
      controller: _searchController,
      onChanged: (v) => setState(() => _query = v),
      style: TextStyle(fontSize: 13.sp),
      decoration: InputDecoration(
        hintText: 'Search help, topics, FAQs...',
        prefixIcon: Icon(
          Icons.search,
          size: 20.sp,
          color: Colors.grey,
        ),
        suffixIcon: _query.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.close, size: 20.sp),
                onPressed: () {
                  _searchController.clear();
                  setState(() => _query = '');
                },
              )
            : null,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          vertical: 0, // 👈 keep zero for perfect alignment
          horizontal: 8.w,
        ),
      ),
    ),
  ),
),

              SizedBox(height: 12.h),

              // Category Chips
              SizedBox(
                height: 40.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) {
                    final c = _categories[index];
                    final selected = c == _selectedCategory;
                    return ChoiceChip(
                      label: Text(c, style: TextStyle(fontSize: 13.sp)),
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedCategory = c),
                      selectedColor: Colors.green.shade100,
                      backgroundColor: Colors.grey.shade100,
                    );
                  },
                ),
              ),
              SizedBox(height: 12.h),

              // FAQs List
              Expanded(
                child: _filteredFaqs.isEmpty
                    ? Center(
                        child: Text('No results found',
                            style: TextStyle(fontSize: 13.sp)))
                    : ListView.separated(
                        itemCount: _filteredFaqs.length,
                        separatorBuilder: (_, __) => Divider(height: 12.h),
                        itemBuilder: (context, index) {
                          final faq = _filteredFaqs[index];
                          return _FaqTile(item: faq);
                        },
                      ),
              ),

              // Contact Footer
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Still need help?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13.sp)),
                    Container(
                      color: AppsColors.primary,
                      height: 40.h,
                      
                      child: TextButton(
                        onPressed: _openContactOptions,
                        child:
                            Text('Contact Us', style: TextStyle(fontSize: 13.sp,color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaqTile extends StatefulWidget {
  final _FAQItem item;
  const _FaqTile({required this.item});

  @override
  State<_FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<_FaqTile>
    with SingleTickerProviderStateMixin {
  bool _open = false;
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _open = !_open);
    if (_open) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(widget.item.question,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp))),
              RotationTransition(
                turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                child: Icon(Icons.expand_more, size: 22.sp),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          SizeTransition(
            sizeFactor: _controller,
            axisAlignment: -1.0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child:
                  Text(widget.item.answer, style: TextStyle(fontSize: 13.sp)),
            ),
          ),
        ],
      ),
    );
  }
}

// Create Ticket Form
class _CreateTicketForm extends StatefulWidget {
  final void Function(String title, String description) onSubmit;
  const _CreateTicketForm({required this.onSubmit});

  @override
  State<_CreateTicketForm> createState() => _CreateTicketFormState();
}

class _CreateTicketFormState extends State<_CreateTicketForm> {
  final _title = TextEditingController();
  final _desc = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_title.text.trim().isEmpty || _desc.text.trim().isEmpty) return;
    setState(() => _sending = true);
    await Future.delayed(const Duration(seconds: 1));
    widget.onSubmit(_title.text.trim(), _desc.text.trim());
    setState(() => _sending = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Create Support Ticket',
              style:
                  TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.h),
          TextField(
            controller: _title,
            style: TextStyle(fontSize: 13.sp),
            decoration: InputDecoration(hintText: 'Short title'),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _desc,
            maxLines: 5,
            style: TextStyle(fontSize: 13.sp),
            decoration: InputDecoration(hintText: 'Describe your issue in detail'),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 40.h,
            child: ElevatedButton(
              onPressed: _sending ? null : _submit,
              child: _sending
                  ? SizedBox(
                      height: 16.w,
                      width: 16.w,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('Submit', style: TextStyle(fontSize: 13.sp)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatDemoPage extends StatelessWidget {
  const _ChatDemoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support Chat')),
      body: const Center(
          child: Text('Chat UI placeholder - integrate your chat SDK here')),
    );
  }
}

class _FAQItem {
  final String question;
  final String answer;
  final String category;
  _FAQItem(
      {required this.question, required this.answer, required this.category});
}
