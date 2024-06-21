import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'config/injector.dart';
import 'interactors/cubits/asset_tree_cubit.dart';
import 'interactors/cubits/home_cubit.dart';
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
        path: '/assets/:company_id',
        builder: (context, state) => AssetsPage(
          companyId: state.pathParameters['company_id']!,
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
            create: (BuildContext context) => injector.get<HomeCubit>()),
        BlocProvider<AssetTreeCubit>(
            create: (BuildContext context) => injector.get<AssetTreeCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Tractian Challenge',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}
