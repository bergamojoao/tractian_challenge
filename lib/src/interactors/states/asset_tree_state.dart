sealed class AssetTreeState {}

class LoadingAssetTreeState implements AssetTreeState {
  const LoadingAssetTreeState();
}

class GettedAssetTreeState implements AssetTreeState {
  const GettedAssetTreeState();
}

class FailureAssetTreeState implements AssetTreeState {
  final String message;
  const FailureAssetTreeState(this.message);
}
