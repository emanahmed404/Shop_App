import '../../models/loginmodel.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates{
   final ShopLoginModel loginDataModel ;
  ShopLoginSuccessState(this.loginDataModel);
}
class ShopLoginErrorState extends ShopLoginStates{
  final String error ;
  ShopLoginErrorState(this.error);
}
class ShopChangePasswordVisibilityState extends ShopLoginStates{}

