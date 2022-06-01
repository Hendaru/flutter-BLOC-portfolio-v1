import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transisi/bloc/loginCubit/login_cubit.dart';
import 'package:transisi/router/appRouter.dart';
import 'package:transisi/router/routeName.dart';

import 'bloc/detailEmployee/detailemployee_cubit.dart';
import 'bloc/homeCubit/home_cubit.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit(),
        ),
        BlocProvider<DetailEmployeeCubit>(
          create: (BuildContext context) => DetailEmployeeCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RouteName.login,
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
