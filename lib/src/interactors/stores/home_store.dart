import 'package:mobx/mobx.dart';

import '../../data/repositories/company_repository.dart';
import '../states/home_state.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final CompanyRepository companyRepository;

  HomeStoreBase(this.companyRepository);

  @observable
  HomeState state = const LoadingHomeState();

  @action
  loadHomeData() async {
    state = const LoadingHomeState();
    try {
      var companies = await companyRepository.findAll();
      state = GettedHomeState(companies: companies);
    } catch (e) {
      state = const FailureHomeState('Error while loading companies');
    }
  }
}
