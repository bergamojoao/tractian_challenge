import 'package:auto_injector/auto_injector.dart';

import '../data/repositories/company_repository.dart';
import '../data/repositories/company_repository_impl.dart';
import '../interactors/stores/asset_tree_store.dart';
import '../interactors/stores/home_store.dart';
import 'api.dart';

final injector = AutoInjector();

void registerInstances() {
  injector.addInstance(Api.getInstance());
  injector.addSingleton<CompanyRepository>(CompanyRepositoryImpl.new);
  injector.addSingleton(HomeStore.new);
  injector.addSingleton(AssetTreeStore.new);
  injector.commit();
}
