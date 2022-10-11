class ChangeFavoritesModel{
  bool ?status ;
  String? message ;
  ChangeFavoritesModel.fromJason(Map<String , dynamic > jason){
    status=jason['status'];
    message=jason['message'];
  }
}