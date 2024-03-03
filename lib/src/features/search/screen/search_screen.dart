import 'package:catering_service_app/src/features/order/data/order_provider.dart';
import 'package:catering_service_app/src/features/order/screens/order_detail_screen.dart';
import 'package:catering_service_app/src/themes/export_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final menuData = ref.watch(orderProvider);
    return GestureDetector(
      onTap: () async => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: SafeArea(
          child: menuData.when(
            data: (data) {
              final query = searchController.text.toLowerCase();
              final filteredMenu = data
                  .where(
                    (order) =>
                        order.user.firstName!.toLowerCase().contains(query) ||
                        order.categoryName.toLowerCase().contains(query) || order.menuName.toLowerCase().contains(query),
                  )
                  .toList();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    TextField(
                      autofocus: true,
                      controller: searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.r),
                            borderSide: BorderSide(
                              color: AppColor.primaryRed,
                              width: 1.w,
                              strokeAlign: BorderSide.strokeAlignInside,
                            )),
                        prefixIcon: Icon(
                          CupertinoIcons.search,
                          size: 28.h,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        hintText: 'Search by menu or category',
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
                        suffixIcon: searchController.text.isEmpty
                            ? const SizedBox()
                            : IconButton(
                          onPressed: () {
                            searchController.clear();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    if (filteredMenu.isEmpty && query.isNotEmpty)
                      Center(
                        child: Text('No matching items found.',
                            style: theme.textTheme.bodyLarge),
                      ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredMenu.length,
                        itemBuilder: (context, index) {
                          final order = filteredMenu[index];
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => OrderDetailScreen(
                                      orderId: order.orderId,
                                    ),
                                )
                              );
                            },
                            title: Text('${order.categoryName} event'),
                            subtitle: Text('By ${order.user.firstName}'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (error, stack) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}