import 'package:doity_test/views/home_view.dart';
import 'package:doity_test/views/login_view.dart';
import 'package:doity_test/views/speakers_view.dart';
import 'package:doity_test/views/widgets/custom/custom_page_route.dart';
import 'package:flutter/material.dart';

//Aqui são definidas todas a rotas de navegação do App
Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/speakers_view':
      return CustomPageRoute(child: const SpeakersView());
    case '/login_view':
      return CustomPageRoute(child: const LoginView());
    case '/home_view':
    default:
      return CustomPageRoute(child: const HomeView());
  }
}
