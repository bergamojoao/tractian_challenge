import '../../data/models/company.dart';
import '../../data/models/tree_node.dart';

sealed class AssetTreeState {}

class LoadingAssetTreeState implements AssetTreeState {
  const LoadingAssetTreeState();
}

class GettedAssetTreeState implements AssetTreeState {
  final Company company;
  final TreeNode assetTree;
  const GettedAssetTreeState({required this.company, required this.assetTree});
}

class FailureAssetTreeState implements AssetTreeState {
  final String message;
  const FailureAssetTreeState(this.message);
}
