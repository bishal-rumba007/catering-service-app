

import 'package:catering_service_app/src/common/splash_screen.dart';
import 'package:catering_service_app/src/features/auth/screens/login_screen.dart';
import 'package:catering_service_app/src/features/auth/screens/sign_up_screen.dart';
import 'package:catering_service_app/src/features/chat/screens/recent_chat_screen.dart';
import 'package:catering_service_app/src/features/dashboard/screens/home_screen.dart';
import 'package:catering_service_app/src/features/menu/screens/create_menu.dart';
import 'package:catering_service_app/src/features/menu/screens/menu_screen.dart';
import 'package:catering_service_app/src/features/notification/screens/notification_screen.dart';
import 'package:catering_service_app/src/features/order/screens/order_screen.dart';
import 'package:catering_service_app/src/features/payment/screens/payment_history_screen.dart';
import 'package:catering_service_app/src/features/profile/screens/profile_edit_screen.dart';
import 'package:catering_service_app/src/features/profile/screens/profile_screen.dart';
import 'package:catering_service_app/src/features/profile/screens/service_history_screen.dart';
import 'package:catering_service_app/src/features/profile/screens/support_screen.dart';
import 'package:catering_service_app/src/features/search/screen/search_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String menuRoute = '/menu';
  static const String notificationRoute = '/notification';
  static const String profileRoute = '/profile';
  static const String orderListRoute = '/order-list';
  static const String recentChats = '/recent-chat';
  static const String chatRoute = '/chat';
  static const String supportRoute = '/support';
  static const String profileEditRoute = '/profile-edit';
  static const String searchRoute = '/search';
  static const String paymentHistoryRoute = '/payment-history';
  static const String serviceHistoryRoute = '/service-history';
  static const String createMenuRoute = '/create-menu';
}

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.menuRoute:
        return MaterialPageRoute(builder: (_) => const MenuScreen());
      case Routes.notificationRoute:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Routes.orderListRoute:
        return MaterialPageRoute(builder: (_) => const OrderScreen());
      case Routes.recentChats:
        return MaterialPageRoute(builder: (_) => const RecentChatScreen());
      case Routes.supportRoute:
        return MaterialPageRoute(builder: (_) => const SupportScreen());
      case Routes.profileEditRoute:
        return MaterialPageRoute(builder: (_) => const ProfileEditScreen());
      case Routes.searchRoute:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case Routes.paymentHistoryRoute:
        return MaterialPageRoute(builder: (_) => const PaymentHistoryScreen());
      case Routes.serviceHistoryRoute:
        return MaterialPageRoute(builder: (_) => const ServiceHistoryScreen());
      case Routes.createMenuRoute:
        return MaterialPageRoute(builder: (_) => const CreateMenuScreen());
    ///Todo: Figure out route that requires parameters
    // case Routes.chatRoute:
    //   return MaterialPageRoute(builder: (_) => const ChatScreen(room: argument,));
      default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Invalid Route'),
        ),
        body: const Center(child: Text('Route does not exist')),
      ),
    );
  }
}
