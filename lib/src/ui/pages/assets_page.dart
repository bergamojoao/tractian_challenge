import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/src/config/injector.dart';
import 'package:tractian_challenge/src/interactors/cubits/asset_tree_cubit.dart';
import 'package:tractian_challenge/src/interactors/states/asset_tree_state.dart';
import 'package:tractian_challenge/src/ui/widgets/default_app_bar.dart';

class AssetsPage extends StatefulWidget {
  final String companyId;
  const AssetsPage({super.key, required this.companyId});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  @override
  void initState() {
    super.initState();

    var assetTreeCubit = injector.get<AssetTreeCubit>();

    assetTreeCubit.loadAssetTree(companyId: widget.companyId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetTreeCubit, AssetTreeState>(
      builder: (context, state) {
        var body = switch (state) {
          (LoadingAssetTreeState _) =>
            const Center(child: CircularProgressIndicator()),
          (GettedAssetTreeState _) => const Text('OK'),
          (FailureAssetTreeState state) => Center(child: Text(state.message)),
        };

        return Scaffold(
          appBar: const DefaultAppBar(
            title: 'Assets',
          ),
          body: body,
        );
      },
    );
  }
}
