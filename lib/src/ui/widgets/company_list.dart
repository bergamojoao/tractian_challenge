import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/company.dart';
import 'company_button.dart';

class CompanyList extends StatelessWidget {
  final List<Company> companies;
  const CompanyList({
    super.key,
    required this.companies,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 34, left: 21, right: 21),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: companies.length,
        itemBuilder: (ctx, index) {
          var company = companies[index];
          return CompanyButton(
            onPressed: () {
              context.push('/assets/${company.toJson()}');
            },
            title: company.name,
          );
        },
      ),
    );
  }
}
