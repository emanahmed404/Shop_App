import '../../models/loginmodel.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{
   final ShopLoginModel loginDataModel ;
  ShopRegisterSuccessState(this.loginDataModel);
}
class ShopRegisterErrorState extends ShopRegisterStates{
  final String error ;
  ShopRegisterErrorState(this.error);
}
class ShopChangePasswordVisibilityState extends ShopRegisterStates{}

