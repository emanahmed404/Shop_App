import 'package:shopapp/models/changefavoritesmodel.dart';
import 'package:shopapp/models/loginmodel.dart';

abstract class AppStates {}

class AppInitialState extends AppStates{}
class isOnBoardState extends AppStates{}
class onboardingDoneAndSaveState extends AppStates{}
class ShopChangeBottonNavBarState extends AppStates{}

class ShopHomeDataLoadingState extends AppStates{}
class ShopHomeDataSuccessState extends AppStates{}
class ShopHomeDataErrorState extends AppStates{
  final String error ;
  ShopHomeDataErrorState(this.error);
}

class ShopCategoriesDataSuccessState extends AppStates{}
class ShopCategoriesDataErrorState extends AppStates{}

class ShopChangeFavoriteSuccessState extends AppStates{
  final ChangeFavoritesModel model ;

  ShopChangeFavoriteSuccessState(this.model);
}
class ShopChangeFavoriteErrorState extends AppStates{}
class ShopChangeFavoriteState extends AppStates{}

class ShopGetFavoritesDataLoadingState extends AppStates{}
class ShopGetFavoritesDataSuccessState extends AppStates{}
class ShopGetFavoritesDataErrorState extends AppStates{}


class ShopGetUserDataLoadingState extends AppStates{}
class ShopGetUserDataSuccessState extends AppStates{
  final ShopLoginModel loginModel;
  ShopGetUserDataSuccessState(this.loginModel);

}
class ShopGetUserDataErrorState extends AppStates{}


class ShopUpdateUserDataLoadingState extends AppStates{}
class ShopUpdateUserDataSuccessState extends AppStates{
  final ShopLoginModel loginModel;
  ShopUpdateUserDataSuccessState(this.loginModel);

}
class ShopUpdateUserDataErrorState extends AppStates{}

