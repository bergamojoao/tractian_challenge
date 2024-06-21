import '../models/asset.dart';
import '../models/company.dart';
import '../models/location.dart';

abstract class CompanyRepository {
  Future<List<Company>> findAll();

  Future<List<Location>> findLocations({required String companyId});

  Future<List<Asset>> findAssets({required String companyId});
}
