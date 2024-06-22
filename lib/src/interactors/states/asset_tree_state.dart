import 'package:tractian_challenge/src/data/models/tree_node.dart';

sealed class AssetTreeState {}

class LoadingAssetTreeState implements AssetTreeState {
  const LoadingAssetTreeState();
}

class GettedAssetTreeState implements AssetTreeState {
  final TreeNode assetTree;
  const GettedAssetTreeState({required this.assetTree});
}

class FailureAssetTreeState implements AssetTreeState {
  final String message;
  const FailureAssetTreeState(this.message);
}
