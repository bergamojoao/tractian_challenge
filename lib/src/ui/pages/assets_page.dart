import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/injector.dart';
import '../../data/models/company.dart';
import '../../interactors/cubits/asset_tree_cubit.dart';
import '../../interactors/states/asset_tree_state.dart';
import '../widgets/asset_tree.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/filter_widget.dart';

class AssetsPage extends StatefulWidget {
  final Company company;
  const AssetsPage({super.key, required this.company});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  @override
  void initState() {
    super.initState();

    var assetTreeCubit = injector.get<AssetTreeCubit>();

    assetTreeCubit.loadAssetTree(company: widget.company);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetTreeCubit, AssetTreeState>(
      builder: (context, state) {
        var body = switch (state) {
          (LoadingAssetTreeState _) =>
            const Center(child: CircularProgressIndicator()),
          (GettedAssetTreeState state) => AssetTree(assetTree: state.assetTree),
          (FailureAssetTreeState state) => Center(child: Text(state.message)),
        };

        return Scaffold(
          appBar: const DefaultAppBar(
            title: 'Assets',
          ),
          body: Column(
            children: [
              FilterWidget(company: widget.company),
              const Divider(height: 0),
              Expanded(child: body),
            ],
          ),
        );
      },
    );
  }
}
