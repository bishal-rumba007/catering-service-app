import 'package:catering_service_app/src/common/common_export.dart';
import 'package:catering_service_app/src/features/dashboard/screens/widgets/carousel_card.dart';
import 'package:catering_service_app/src/features/dashboard/screens/widgets/category_card.dart';
import 'package:catering_service_app/src/features/dashboard/screens/widgets/menu_widget.dart';
import 'package:catering_service_app/src/features/dashboard/screens/widgets/my_drawer.dart';
import 'package:catering_service_app/src/features/menu/data/menu_data_provider.dart';
import 'package:catering_service_app/src/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedCategory = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final menuData = ref.watch(menuProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                padding: EdgeInsets.all(16.w),
                child: SvgPicture.asset(
                  "assets/icons/menu.svg",
                  colorFilter: ColorFilter.mode(
                    Colors.grey.shade700,
                    BlendMode.srcIn
                  ),
                ),
              ),
            );
          },
        ),
        title: const Text('Catering'),
        centerTitle: true,
        titleTextStyle: GoogleFonts.beauRivage(
            fontWeight: FontWeight.w700,
            fontSize: 36.sp,
            color: AppColor.primaryRed,
            letterSpacing: 1.8,
        ),
        actions: [
          InkWell(
            splashFactory: InkRipple.splashFactory,
            onTap: () {
              Navigator.pushNamed(context, '/search');
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Container(
                padding: EdgeInsets.all(5.5.w),
                width: 40.h,
                height: 40.h,
                child: SvgPicture.asset(
                    "assets/icons/search.svg",
                  colorFilter: ColorFilter.mode(
                      Colors.grey.shade700,
                      BlendMode.srcIn
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: menuData.when(
        data: (data) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                const CarouselCard(),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    children: [
                      const CategoryWidget(),
                      SizedBox(
                        height: 16.h,
                      ),
                      data.isEmpty ?
                      Column(
                        children: [
                          Text(
                            'Create menus so people discover\n your business more!',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                         SizedBox(
                           width: 160.w,
                           child: BuildButton(
                               onPressed: (){
                                  Navigator.pushNamed(context, '/create-menu');
                               },
                               buttonWidget: const Text(
                                 'Create Menu',
                               )
                           ),
                         ),
                        ],
                      )
                          : PopularMenuCard(menuData: data,),
                      SizedBox(
                        height: 200.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          print(stackTrace);
          return Center(
            child: Text('$error'),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
