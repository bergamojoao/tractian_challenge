import 'package:flutter/material.dart';

import '../../config/injector.dart';
import '../../data/models/company.dart';
import '../../interactors/stores/asset_tree_store.dart';
import '../../utils/debouncer.dart';
import 'filter_button.dart';

class FilterWidget extends StatefulWidget {
  final Company company;
  const FilterWidget({
    super.key,
    required this.company,
  });

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  var assetTreeStore = injector.get<AssetTreeStore>();
  bool filterByEnergy = false;
  bool filterByCritical = false;
  final _searchController = TextEditingController();
  final debouncer = Debouncer();

  @override
  void initState() {
    super.initState();
  }

  _applyFilters() {
    assetTreeStore.filterAssetTree(
        search: _searchController.value.text,
        filterByEnergy: filterByEnergy,
        filterByCritical: filterByCritical);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _searchController,
            style: const TextStyle(
              color: Color(0xFF8E98A3),
            ),
            decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFEAEFF3),
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Color(0xFF8E98A3),
                hintText: 'Buscar Ativo ou Local',
                hintStyle: TextStyle(
                  color: Color(0xFF8E98A3),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.all(0)),
            onChanged: (value) => debouncer.debounce(() => _applyFilters()),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: [
              FilterButton(
                isSelected: filterByEnergy,
                icon: const Icon(Icons.bolt_outlined),
                label: const Text('Sensor de energia'),
                onPressed: () {
                  setState(() {
                    filterByEnergy = !filterByEnergy;
                    filterByCritical = false;
                  });
                  _searchController.clear();
                  _applyFilters();
                },
              ),
              FilterButton(
                isSelected: filterByCritical,
                icon: const Icon(Icons.error_outline),
                label: const Text('Crítico'),
                onPressed: () {
                  setState(() {
                    filterByCritical = !filterByCritical;
                    filterByEnergy = false;
                  });
                  _searchController.clear();
                  _applyFilters();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
