import 'package:flutter/material.dart';
import 'package:tractian_challenge/src/data/models/company.dart';

import '../../data/models/asset.dart';
import '../../data/models/location.dart';
import '../../data/models/tree_node.dart';

class AssetTree extends StatefulWidget {
  final TreeNode assetTree;
  const AssetTree({super.key, required this.assetTree});

  @override
  State<AssetTree> createState() => _AssetTreeState();
}

class _AssetTreeState extends State<AssetTree> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _buildTreeItem(context, widget.assetTree, index);
            },
            childCount: _calculateVisibleNodes(widget.assetTree).length,
          ),
        ),
      ],
    );
  }

  Widget _buildTreeItem(BuildContext context, TreeNode node, int index) {
    List<TreeNode> visibleNodes = _calculateVisibleNodes(widget.assetTree);
    TreeNode currentNode = visibleNodes[index];
    int level = _getNodeLevel(widget.assetTree, currentNode, 0);

    if (currentNode.content is Company) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(left: level * 16, top: 5, bottom: 5),
      child: InkWell(
        child: Row(
          children: [
            if (currentNode.children.isNotEmpty)
              currentNode.isExpanded
                  ? const Icon(Icons.keyboard_arrow_down)
                  : const Icon(Icons.chevron_right)
            else
              const SizedBox(width: 24),
            _getContentHeadingIcon(currentNode.content),
            Text(currentNode.content.name),
            _getContentTrailingIcon(currentNode.content),
          ],
        ),
        onTap: () {
          setState(() {
            currentNode.isExpanded = !currentNode.isExpanded;
          });
        },
      ),
    );
  }

  List<TreeNode> _calculateVisibleNodes(TreeNode node) {
    List<TreeNode> nodes = [node];
    if (node.isExpanded || node.content is Company) {
      for (var child in node.children) {
        nodes.addAll(_calculateVisibleNodes(child));
      }
    }
    return nodes;
  }

  int _getNodeLevel(TreeNode root, TreeNode node, int level) {
    if (root == node) {
      return level;
    }
    for (var child in root.children) {
      int childLevel = _getNodeLevel(child, node, level + 1);
      if (childLevel != -1) {
        return childLevel;
      }
    }
    return -1;
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
      return Row(
        children: [
          if (content.sensorType == 'energy')
            const Icon(Icons.bolt, color: Color(0xFF52C41A)),
          if (content.status == 'alert')
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(left: 5),
              decoration: const BoxDecoration(
                  color: Color(0xFFED3833),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
