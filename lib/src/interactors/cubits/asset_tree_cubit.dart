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
      var assetTree = await _getAssetTree(company);

      emit(GettedAssetTreeState(company: company, assetTree: assetTree!));
    } catch (e) {
      emit(const FailureAssetTreeState('Error while loading asset tree'));
    }
  }

  _getAssetTree(Company company) async {
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

    return TreeNode.buildTree(data: nodeList, parentId: company.id);
  }

  filterAssetTree(
      {required Company company,
      required String search,
      required bool filterByEnergy,
      required bool filterByCritical}) async {
    emit(const LoadingAssetTreeState());
    try {
      var assetTree = await _getAssetTree(company);

      var filteredTree = TreeNode.filter(assetTree, (node) {
        var content = node.content;

        if ((filterByEnergy || filterByCritical) && content is! Asset) {
          return false;
        }

        if (search.isNotEmpty &&
            !content.name.toUpperCase().contains(search.toUpperCase())) {
          return false;
        }

        if (content is Asset) {
          if (filterByEnergy && content.sensorType != 'energy') {
            return false;
          }

          if (filterByCritical && content.status != 'alert') {
            return false;
          }
        }

        return true;
      });

      emit(GettedAssetTreeState(
          company: company,
          assetTree:
              filteredTree ?? TreeNode(content: company, id: company.id)));
    } catch (e) {
      emit(const FailureAssetTreeState('Error while loading asset tree'));
    }
  }
}
