import 'package:doity_test/routes.dart';
import 'package:doity_test/views/splash_view.dart';
import 'package:doity_test/views/widgets/custom/custom_text_theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doity Event',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          textTheme: CustomTextTheme(),
        ),
        onGenerateRoute: (route) => onGenerateRoute(route),
        home: const SplashView());
  }
}
