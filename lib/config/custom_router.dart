import 'package:flutter/material.dart';
import 'package:flutter_instagram/screens/edit_profile/edit_profile_screen.dart';
import 'package:flutter_instagram/screens/login/login_screen.dart';
import 'package:flutter_instagram/screens/nav/nav_screen.dart';
import 'package:flutter_instagram/screens/signup/signup_screen.dart';
import 'package:flutter_instagram/screens/splash/splash_screen.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route : ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),
        );
      case SplashScreen.routeName:
        return SplashScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case SignupScreen.routeName:
        return SignupScreen.route();
      case NavScreen.routeName:
        return NavScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route onGenerateNestedRoute(RouteSettings settings) {
    print('nested Route : ${settings.name}');
    switch (settings.name) {
      case EditProfileScreen.routeName:
        return EditProfileScreen.route(args: settings.arguments);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong'),
        ),
      ),
    );
  }
}
