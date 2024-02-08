import 'package:catering_service_app/src/features/auth/screens/auth_provider.dart';
import 'package:catering_service_app/src/features/menu/screens/create_menu.dart';
import 'package:catering_service_app/src/features/menu/screens/menu_screen.dart';
import 'package:catering_service_app/src/features/notification/screens/notification_screen.dart';
import 'package:catering_service_app/src/features/order/screens/order_screen.dart';
import 'package:catering_service_app/src/features/profile/screens/profile_screen.dart';
import 'package:catering_service_app/src/shared/data/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';



class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authData = ref.watch(authProvider);
    final userData = ref.watch(singleUserProvider);
    return Drawer(
      child: userData.when(
        data: (data) {
          final username = data.firstName!.split(' ');
          final String displayName = "${username[0][0]}${username[1][0]}";
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 200.h,
                decoration: const BoxDecoration(
                  color: Color(0xffffde8b),
                ),
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/backdrops/food.svg',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.25),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50.h,),
                          CircleAvatar(
                            backgroundColor: Theme.of(context).secondaryHeaderColor,
                            radius: 35,
                            child: Text(
                              displayName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            data.firstName!,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            data.metadata!['role'],
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.profile_circled),
                title: Text(
                  'Profile',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfileScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_box_outlined),
                title: Text(
                  'Create Menu',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CreateMenuScreen(),
                      ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.restaurant_menu, size: 24,),
                title: Text(
                  'My Menus',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MenuScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat_bubble_outline, size: 24,),
                title: Text(
                  'Recent Chat',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/recent-chat');
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.bell_fill),
                title: Text(
                  'Notification',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: Text(
                  'Orders',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OrderScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 10.h,),
              Divider(
                color: Colors.grey.shade400,
              ),
              SizedBox(height: 10.h,),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(
                  'Log out',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () async{
                  await authData.logOut();
                },
              ),
            ],
          );
        },
        error: (err, stack) => Text('$err'),
        loading: () => const Center(child: CircularProgressIndicator()),
      )
    );
  }
}
