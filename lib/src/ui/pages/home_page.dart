import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/src/config/injector.dart';
import 'package:tractian_challenge/src/interactors/cubits/home_cubit.dart';

import '../../interactors/states/home_state.dart';
import '../widgets/company_list.dart';
import '../widgets/home_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    var homeCubit = injector.get<HomeCubit>();

    homeCubit.loadHomeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (ctx, state) {
      var body = switch (state) {
        (LoadingHomeState _) =>
          const Center(child: CircularProgressIndicator()),
        (GettedHomeState state) => CompanyList(companies: state.companies),
        (FailureHomeState state) => Center(child: Text(state.message)),
      };

      return Scaffold(appBar: const HomeAppBar(), body: body);
    });
  }
}
