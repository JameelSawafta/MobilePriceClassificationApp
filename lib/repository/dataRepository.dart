import '../models/dataModel.dart';

abstract class DataRepository {
  Future<List<DataModel>> getAllDataAPI();
  List<DataModel> getAllData();
  //Future<DataModel> getDataById(int id);
}