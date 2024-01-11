import 'package:catering_service_app/src/common/common_export.dart';
import 'package:catering_service_app/src/features/auth/screens/auth_provider.dart';
import 'package:catering_service_app/src/features/dashboard/screens/widgets/my_drawer.dart';
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
                child: SvgPicture.asset("assets/icons/menu.svg"),
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
            letterSpacing: 1.8),
        actions: [
          InkWell(
            splashFactory: InkRipple.splashFactory,
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Container(
                padding: EdgeInsets.all(5.5.w),
                width: 40.h,
                height: 40.h,
                child: SvgPicture.asset("assets/icons/search.svg"),
              ),
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h,),
            const CarouselCard(),
            SizedBox(height: 20.h,),
            Text(
              'Choose Your Categories',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 18.sp
              ),
            ),
            SizedBox(height: 10.h,),
            buildCategories(),
            SizedBox(height: 20.h,),
            Text(
              'Hello Bishal Rumba',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18.sp,
                color: AppColor.greyColor,
              ),
            ),
            Text(
              'Planning A Fabulous Event?',
              style: Theme.of(context).textTheme.headlineSmall
            )
          ],
        ),
      ),
    );
  }

  SizedBox buildCategories() {
    return SizedBox(
            height: 90.h,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = index;
                    });
                    // Todo: add routing logic here
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 3.0,
                        child: Container(
                          height: 62.h,
                          width: 60.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhjY_J2A-6p8NNQGmCLfsSbjR8RaRinc1p2g")
                            ),
                            border: index == selectedCategory ? Border.all(
                              color: AppColor.primaryRed,
                              width: 1.8.w,
                            ) : const Border()
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Wedding',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          color: index == selectedCategory ? AppColor.primaryRed : AppColor.greyColor
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 15.w,),
            ),
          );
  }
}

class CarouselCard extends StatelessWidget {
  const CarouselCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow,
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.55),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        height: 130.h,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '30% OFF',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 17.sp
                        ),
                      ),
                      TextSpan(
                        text: ' on all \n categories',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ]
                  ),
                ),
                SizedBox(height: 12.h,),
                SizedBox(
                  width: 104.w,
                  height: 32.h,
                  child: BuildButton(
                    onPressed: (){},
                    buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.all(5.w),
                      textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                      ),
                    ),
                    buttonWidget: const Text('Accept Now',),
                  ),
                )
              ],
            ),
            SizedBox(width: 34.w,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhjY_J2A-6p8NNQGmCLfsSbjR8RaRinc1p2g",),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
