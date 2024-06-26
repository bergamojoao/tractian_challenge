import 'package:flutter/material.dart';

import '../../data/models/asset.dart';
import '../../data/models/location.dart';
import '../../data/models/tree_node.dart';
import 'custom_expansion_tile.dart';

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
        isExpanded: true,
        title: Row(
          children: [
            _getContentHeadingIcon(content),
            const SizedBox(width: 6),
            Text(content.name),
            _getContentTrailingIcon(content),
          ],
        ),
        children:
            node.children.map((child) => AssetTree(assetTree: child)).toList(),
      );
    }

    return Container();
  }

  Widget _getContentHeadingIcon(Object content) {
    return switch (content) {
      (Location _) => Image.asset('assets/images/location.png', width: 22),
      (Asset asset) => asset.sensorType != null
          ? Image.asset('assets/images/component.png', width: 22)
          : Image.asset('assets/images/asset.png', width: 22),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _getContentTrailingIcon(Object content) {
    if (content is Asset) {
      if (content.status == 'alert') {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(left: 5),
          decoration: const BoxDecoration(
              color: Color(0xFFED3833),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        );
      }

      if (content.sensorType == 'energy') {
        return const Icon(Icons.bolt, color: Color(0xFF52C41A));
      }
    }

    return const SizedBox.shrink();
  }
}
