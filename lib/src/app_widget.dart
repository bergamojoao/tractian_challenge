import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data/models/company.dart';
import 'ui/pages/assets_page.dart';
import 'ui/pages/home_page.dart';

class AppWidget extends StatelessWidget {
  AppWidget({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/assets/:company',
        builder: (context, state) {
          return AssetsPage(
            company: Company.fromJson(state.pathParameters['company']!),
          );
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tractian Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
