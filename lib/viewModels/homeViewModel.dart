import '../repository/dataRepository.dart';
import 'dataViewModel.dart';

class HomeViewModel{
  final String title="Home";

  DataRepository? dataRepository;
  HomeViewModel({this.dataRepository});

  Future<List<DataViewModel>> getAllDataAPI() async {
    var dataFromAPI = await dataRepository!.getAllData();
    return dataFromAPI.map((data)=>DataViewModel(dataModel: data)).toList();
  }
  List<DataViewModel> getAllData()  {
    var dataFromLocal = dataRepository!.getAllData();
    return dataFromLocal.map((data)=>DataViewModel(dataModel: data)).toList();
  }
}