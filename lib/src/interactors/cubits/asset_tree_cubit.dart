import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/company_repository.dart';
import '../states/asset_tree_state.dart';

class AssetTreeCubit extends Cubit<AssetTreeState> {
  final CompanyRepository companyRepository;
  AssetTreeCubit(this.companyRepository) : super(const LoadingAssetTreeState());

  loadAssetTree({required String companyId}) async {
    emit(const LoadingAssetTreeState());
    try {
      var locations =
          await companyRepository.findLocations(companyId: companyId);
      var assets = await companyRepository.findAssets(companyId: companyId);
      emit(const GettedAssetTreeState());
    } catch (e) {
      emit(const FailureAssetTreeState('Error while loading asset tree'));
    }
  }
}
