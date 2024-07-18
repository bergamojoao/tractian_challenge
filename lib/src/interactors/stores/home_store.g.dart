// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$stateAtom = Atom(name: 'HomeStoreBase.state', context: context);

  @override
  HomeState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(HomeState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$loadHomeDataAsyncAction =
      AsyncAction('HomeStoreBase.loadHomeData', context: context);

  @override
  Future loadHomeData() {
    return _$loadHomeDataAsyncAction.run(() => super.loadHomeData());
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
