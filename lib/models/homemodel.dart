class HomeModel{
   bool? status ;
  HomeDataModel? data;

  HomeModel.fromJason(Map<String,dynamic> jason){
    status=jason['status'];
    data=HomeDataModel.fromJason(jason['data']);
  }
}
class HomeDataModel {

  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJason(Map<String, dynamic> jason){
    jason['banners'].forEach((element) {
      banners.add(BannerModel.fromJason(element));
    });

    jason['products'].forEach((element) {
      products.add(ProductModel.fromJason(element));
    });
  }


}

class BannerModel{
 late int id ;
 late String image;
  BannerModel.fromJason(Map<String,dynamic> jason){
    id=jason['id'];
    image=jason['image'];
  }
}
class ProductModel{
 late int id;
 late dynamic price ;
 late  dynamic old_price;
 late dynamic discount ;
 late String image;
 late String name ;
 late bool in_favorites;
 late bool in_cart ;

  ProductModel.fromJason(Map<String,dynamic> jason){
    id=jason['id'];
    price=jason['price'];
    old_price=jason['old_price'];
    discount=jason['discount'];
    image=jason['image'];
    name =jason['name'];
    in_favorites=jason['in_favorites'];
    in_cart=jason['in_cart'];

  }
}