import 'package:catering_service_app/src/common/common_export.dart';
import 'package:catering_service_app/src/features/auth/screens/auth_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    final authData = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: Colors.white,
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
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            IconButton(
              onPressed: () async{
                await authData.logOut();
              },
              icon: Icon(Icons.logout),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            Card(
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
                            image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhjY_J2A-6p8NNQGmCLfsSbjR8RaRinc1p2g",),
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
