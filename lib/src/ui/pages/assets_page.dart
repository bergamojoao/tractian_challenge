import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../config/injector.dart';
import '../../data/models/company.dart';
import '../../interactors/states/asset_tree_state.dart';
import '../../interactors/stores/asset_tree_store.dart';
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
  final assetTreeStore = injector.get<AssetTreeStore>();
  @override
  void initState() {
    super.initState();

    assetTreeStore.loadAssetTree(company: widget.company);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        var body = switch (assetTreeStore.state) {
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
