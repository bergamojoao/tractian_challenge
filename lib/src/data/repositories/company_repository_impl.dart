import 'package:dio/dio.dart';

import '../models/asset.dart';
import '../models/company.dart';
import '../models/location.dart';
import 'company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final Dio dio;
  CompanyRepositoryImpl(this.dio);

  @override
  Future<List<Company>> findAll() async {
    var response = await dio.get('/companies');

    if (response.statusCode != 200) throw Exception();

    var list = response.data as List;

    return list.map((json) => Company.fromMap(json)).toList();
  }

  @override
  Future<List<Location>> findLocations({required String companyId}) async {
    var response = await dio.get('/companies/$companyId/locations');

    if (response.statusCode != 200) throw Exception();

    var list = response.data as List;

    return list.map((json) => Location.fromMap(json)).toList();
  }

  @override
  Future<List<Asset>> findAssets({required String companyId}) async {
    var response = await dio.get('/companies/$companyId/assets');

    if (response.statusCode != 200) throw Exception();

    var list = response.data as List;

    return list.map((json) => Asset.fromMap(json)).toList();
  }
}
