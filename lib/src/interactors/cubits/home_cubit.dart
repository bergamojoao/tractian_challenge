import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/company_repository.dart';
import '../states/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CompanyRepository companyRepository;
  HomeCubit(this.companyRepository) : super(const LoadingHomeState());

  loadHomeData() async {
    emit(const LoadingHomeState());
    try {
      var companies = await companyRepository.findAll();
      emit(GettedHomeState(companies: companies));
    } catch (e) {
      emit(const FailureHomeState('Error while loading companies'));
    }
  }
}
