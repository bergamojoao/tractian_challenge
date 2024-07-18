// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_tree_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetTreeStore on AssetTreeStoreBase, Store {
  late final _$stateAtom =
      Atom(name: 'AssetTreeStoreBase.state', context: context);

  @override
  AssetTreeState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AssetTreeState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$loadAssetTreeAsyncAction =
      AsyncAction('AssetTreeStoreBase.loadAssetTree', context: context);

  @override
  Future loadAssetTree({required Company company}) {
    return _$loadAssetTreeAsyncAction
        .run(() => super.loadAssetTree(company: company));
  }

  late final _$filterAssetTreeAsyncAction =
      AsyncAction('AssetTreeStoreBase.filterAssetTree', context: context);

  @override
  Future filterAssetTree(
      {required String search,
      required bool filterByEnergy,
      required bool filterByCritical}) {
    return _$filterAssetTreeAsyncAction.run(() => super.filterAssetTree(
        search: search,
        filterByEnergy: filterByEnergy,
        filterByCritical: filterByCritical));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
