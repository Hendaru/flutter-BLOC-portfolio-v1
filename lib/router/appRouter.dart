import 'package:flutter/material.dart';
import 'package:transisi/router/routeName.dart';
import 'package:transisi/ui/auth/login.dart';
import 'package:transisi/ui/auth/register.dart';
import 'package:transisi/ui/home/createEmployee.dart';
import 'package:transisi/ui/home/detailEmployee.dart';
import 'package:transisi/ui/home/home.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => Home());
      case RouteName.createEmployee:
        return MaterialPageRoute(builder: (_) => CreateEmployee());
      case RouteName.detailEmployee:
        return MaterialPageRoute(builder: (_) => DetailEmployee());
      case RouteName.login:
        return MaterialPageRoute(builder: (_) => Login());
      case RouteName.register:
        return MaterialPageRoute(builder: (_) => Register());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Page invalid'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
