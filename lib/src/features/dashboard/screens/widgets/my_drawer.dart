import 'package:catering_service_app/src/features/auth/screens/auth_provider.dart';
import 'package:catering_service_app/src/features/menu/screens/create_menu.dart';
import 'package:catering_service_app/src/features/menu/screens/menu_screen.dart';
import 'package:catering_service_app/src/shared/data/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authData = ref.watch(authProvider);
    final userData = ref.watch(userProvider);
    return Drawer(
      child: userData.when(
        data: (data) {
          return ListView(
            children: [
              DrawerHeader(
                decoration: data.imageUrl != null ? BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data.imageUrl!),
                    fit: BoxFit.cover,
                  ),
                ) : BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.4),
                ) ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Text(
                      data.metadata!['phone'],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      data.metadata!['email'],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              ListTile(
                trailing: const Icon(Icons.add_box_outlined),
                title: const Text('Create Menu'),
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
                trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 20,),
                title: const Text('My Menus'),
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
                trailing: const Icon(Icons.logout),
                title: const Text('Log out'),
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
