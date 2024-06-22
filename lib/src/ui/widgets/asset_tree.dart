import 'package:flutter/material.dart';
import 'package:tractian_challenge/src/data/models/asset.dart';
import 'package:tractian_challenge/src/data/models/location.dart';
import 'package:tractian_challenge/src/data/models/tree_node.dart';
import 'package:tractian_challenge/src/ui/widgets/custom_expansion_tile.dart';

class AssetTree extends StatelessWidget {
  final TreeNode assetTree;
  const AssetTree({super.key, required this.assetTree});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          children:
              assetTree.children.map((node) => _getNodeWidget(node)).toList(),
        ),
      ),
    );
  }

  Widget _getNodeWidget(TreeNode node) {
    var content = node.content;

    if (content is Location || content is Asset) {
      return CustomExpansionTile(
        title: Row(
          children: [
            _getContentIcon(content),
            const SizedBox(width: 6),
            Text(content.name),
          ],
        ),
        children:
            node.children.map((child) => AssetTree(assetTree: child)).toList(),
      );
    }

    return Container();
  }

  Widget _getContentIcon(Object content) {
    return switch (content) {
      (Location _) => Image.asset('assets/images/location.png', width: 22),
      (Asset asset) => asset.sensorType != null
          ? Image.asset('assets/images/component.png', width: 22)
          : Image.asset('assets/images/asset.png', width: 22),
      _ => const SizedBox.shrink(),
    };
  }
}
