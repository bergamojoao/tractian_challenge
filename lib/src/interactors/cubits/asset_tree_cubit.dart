import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/src/data/models/asset.dart';
import 'package:tractian_challenge/src/data/models/location.dart';
import 'package:tractian_challenge/src/data/models/tree_node.dart';

import '../../data/models/company.dart';
import '../../data/repositories/company_repository.dart';
import '../states/asset_tree_state.dart';

class AssetTreeCubit extends Cubit<AssetTreeState> {
  final CompanyRepository companyRepository;
  AssetTreeCubit(this.companyRepository) : super(const LoadingAssetTreeState());

  loadAssetTree({required Company company}) async {
    emit(const LoadingAssetTreeState());
    try {
      List<TreeNode> nodeList = [
        TreeNode<Company>(
          content: company,
          id: company.id,
        )
      ];

      var locations =
          await companyRepository.findLocations(companyId: company.id);

      for (var location in locations) {
        nodeList.add(TreeNode<Location>(
          content: location,
          id: location.id,
          parentId: location.parentId ?? company.id,
        ));
      }

      var assets = await companyRepository.findAssets(companyId: company.id);

      for (var asset in assets) {
        nodeList.add(
          TreeNode<Asset>(
            content: asset,
            id: asset.id,
            parentId: asset.locationId ?? asset.parentId ?? company.id,
          ),
        );
      }

      var assetTree = _buildTree(data: nodeList, parentId: company.id);

      emit(GettedAssetTreeState(assetTree: assetTree!));
    } catch (e) {
      emit(const FailureAssetTreeState('Error while loading asset tree'));
    }
  }

  TreeNode? _buildTree({required List<TreeNode> data, String? parentId}) {
    TreeNode? parentNode;
    for (var node in data) {
      if (node.id == parentId) {
        parentNode = node;
        break;
      }
    }

    if (parentNode == null) {
      return null;
    }

    for (var node in data) {
      if (node.parentId == parentNode.id) {
        TreeNode? childNode = _buildTree(data: data, parentId: node.id);
        if (childNode != null) {
          parentNode.children.add(childNode as TreeNode<Object>);
        }
      }
    }

    return parentNode;
  }
}
