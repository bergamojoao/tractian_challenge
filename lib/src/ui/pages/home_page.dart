import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../config/injector.dart';
import '../../interactors/states/home_state.dart';
import '../../interactors/stores/home_store.dart';
import '../widgets/company_list.dart';
import '../widgets/home_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeStore = injector.get<HomeStore>();

  @override
  void initState() {
    super.initState();
    homeStore.loadHomeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (ctx) {
      var body = switch (homeStore.state) {
        (LoadingHomeState _) =>
          const Center(child: CircularProgressIndicator()),
        (GettedHomeState state) => CompanyList(companies: state.companies),
        (FailureHomeState state) => Center(child: Text(state.message)),
      };

      return Scaffold(appBar: const HomeAppBar(), body: body);
    });
  }
}
