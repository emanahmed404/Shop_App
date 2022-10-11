class CategoriesModel{
  bool ?status ;
  CategoriesDataModel? data ;
  CategoriesModel.fromJason(Map<String , dynamic > jason){
    status=jason['status'];
    data=CategoriesDataModel.fromJason(jason['data']);
  }
}
class CategoriesDataModel {
  late int current_page;

  List<DataModel> data = [];

  CategoriesDataModel.fromJason(Map<String, dynamic> jason){
    current_page = jason['current_page'];

    jason['data'].forEach((element) {
      data.add(DataModel.fromJason(element));
    });
  }
}

class DataModel {
  late int id ;
   late String name ;
   late String image ;

  DataModel.fromJason(Map<String ,dynamic> jason){
    id=jason['id'];
    name=jason['name'];
    image=jason['image'];
  }
}