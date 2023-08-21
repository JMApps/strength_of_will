import 'package:flutter/material.dart';
import 'package:of_will/data/arguments/strength_arguments.dart';
import 'package:of_will/presentation/pages/settings_page.dart';
import 'package:of_will/presentation/pages/strength_content_page.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/strength_content':
        final StrengthArguments strengthArguments = routeSettings.arguments as StrengthArguments;
        return MaterialPageRoute(
          builder: (_) => StrengthContentPage(
            paragraphId: strengthArguments.paragraphId,
          ),
        );
      case '/app_settings':
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
        );
      default:
        throw Exception('Invalid route ${routeSettings.name}');
    }
  }
}
