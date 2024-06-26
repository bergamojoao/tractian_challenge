import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/asset.dart';
import '../../data/models/company.dart';
import '../../data/models/location.dart';
import '../../data/models/tree_node.dart';
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

  Future<TreeNode?> _getAssetTree(Company company) async {
    company.locations =
        await companyRepository.findLocations(companyId: company.id);

    company.assets = await companyRepository.findAssets(companyId: company.id);

    List<TreeNode> nodeList = [
      TreeNode<Company>(
        content: company,
        id: company.id,
        isExpanded: true,
      )
    ];

    for (var location in company.locations) {
      nodeList.add(TreeNode<Location>(
        content: location,
        id: location.id,
        parentId: location.parentId ?? company.id,
      ));
    }

    for (var asset in company.assets) {
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
      {required String search,
      required bool filterByEnergy,
      required bool filterByCritical}) async {
    if (state is! GettedAssetTreeState) {
      return;
    }

    var currentState = state as GettedAssetTreeState;

    emit(const LoadingAssetTreeState());
    try {
      var assetTree = await _getAssetTree(currentState.company);

      var filteredTree = TreeNode.filter(assetTree!, (node) {
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

      emit(
        GettedAssetTreeState(
          company: currentState.company,
          assetTree: filteredTree ??
              TreeNode(
                content: currentState.company,
                id: currentState.company.id,
                isExpanded: true,
              ),
        ),
      );
    } catch (e) {
      emit(const FailureAssetTreeState('Error while loading asset tree'));
    }
  }
}
