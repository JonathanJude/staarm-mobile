import 'package:flutter/material.dart';

import 'ui/views/auth/login_or_signup/login_or_signup_view.dart';
import 'ui/views/main_page/main_page.dart';
import 'ui/views/splash_screen/splash_screen.dart';
import 'utils/staarm_page_route.dart';


class StaarmRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return StaarmPageRoute.routeTo(builder: (_) => SplashPage());
      case '/login':
        return StaarmPageRoute.routeTo(builder: (_) => LoginOrSignupView());
      case '/main':
        return StaarmPageRoute.routeTo(builder: (_) => MainPage());
      default:
        return StaarmPageRoute.routeTo(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          ),
        );
    }
  }
}
