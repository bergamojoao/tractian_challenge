import '../../data/models/company.dart';

sealed class HomeState {}

class LoadingHomeState implements HomeState {
  const LoadingHomeState();
}

class GettedHomeState implements HomeState {
  final List<Company> companies;
  const GettedHomeState({required this.companies});
}

class FailureHomeState implements HomeState {
  final String message;
  const FailureHomeState(this.message);
}
