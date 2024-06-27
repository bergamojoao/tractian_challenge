import 'package:auto_injector/auto_injector.dart';

import '../data/repositories/company_repository.dart';
import '../data/repositories/company_repository_impl.dart';
import '../interactors/cubits/asset_tree_cubit.dart';
import '../interactors/cubits/home_cubit.dart';
import 'api.dart';

final injector = AutoInjector();

void registerInstances() {
  injector.addInstance(Api.getInstance());
  injector.addSingleton<CompanyRepository>(CompanyRepositoryImpl.new);
  injector.addSingleton(HomeCubit.new);
  injector.addSingleton(AssetTreeCubit.new);
  injector.commit();
}
