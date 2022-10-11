import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/categoriesmodel.dart';
import 'package:shopapp/models/changefavoritesmodel.dart';
import 'package:shopapp/models/favoritesmodel.dart';
import 'package:shopapp/models/homemodel.dart';
import 'package:shopapp/modules/categories.dart';
import 'package:shopapp/modules/favourits.dart';
import 'package:shopapp/modules/intro.dart';
import 'package:shopapp/modules/products.dart';
import 'package:shopapp/modules/settings.dart';
import 'package:shopapp/shared/constants/constants.dart';
import 'package:shopapp/shared/network/remote/diohelper.dart';
import 'package:shopapp/shared/network/remote/endpoints.dart';
import '../../models/loginmodel.dart';
import '../../shared/components/components.dart';
import '../../shared/network/remote/cachehelper.dart';
import 'appstates.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  //********************************************************
  void doneOnboarding(context) {
    CacheHelper.saveData(key: 'onboardDone', value: true).then((value) {
      navigateandfinish(context, IntroScreen());
      print('انا جوة ال save data ');
      emit(onboardingDoneAndSaveState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  bool? isOnBoarding = false;

  void isOnboardDone({bool? fromShared}) {
    if ((fromShared) != null) {
      isOnBoarding = fromShared;
      print('جالي قيمة من الشيرد زفت');
      emit(isOnBoardState());
    }
  }

  //********************************************************
  int currentIndex = 0;

  List<Widget> bottomNavBarList = [
    ProductsScreen(),
    CategoriesScreen(),
    FavScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottonNavBarState());
  }

  //***********************************************************
  ChangeFavoritesModel? changeFavoritesModel ;
  void changeFavorites(int productId) {
    favorites[productId]=!favorites[productId]!;
    emit(ShopChangeFavoriteState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {

      changeFavoritesModel=ChangeFavoritesModel.fromJason(value.data);
      if(!(changeFavoritesModel?.status!=null)){
        favorites[productId]=!favorites[productId]!;
      }
      else{
        getFavoritesData();
      }
      emit(ShopChangeFavoriteSuccessState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId]=!favorites[productId]!;
      emit(ShopChangeFavoriteErrorState());
    });
  }

  //***********************************************************

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopHomeDataLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJason(value.data);
      // print(homeModel!.status!);
      // printFullText(homeModel!.data!.banners[0].image);
      /* مش هتطبه هشان مينفعش اطبع اوبجكن
              printFullText(homemodel.toString());*/
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id: element.in_favorites});
      });
      print(favorites);
      emit(ShopHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeDataErrorState(error.toString()));
    });
  }

  //*********************************************************

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJason(value.data);
      print(categoriesModel!.status);
      emit(ShopCategoriesDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesDataErrorState());
    });
  }
  //*********************************************************
  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopGetFavoritesDataLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(categoriesModel!.status);
      emit(ShopGetFavoritesDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavoritesDataErrorState());
    });
  }

  //************************************************************
  late ShopLoginModel  shopLoginModel;
  void getUserData() {
    emit(ShopGetUserDataLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      shopLoginModel = ShopLoginModel.fromJason(value.data);
      print(shopLoginModel.data!.name.toString());
      emit(ShopGetUserDataSuccessState(shopLoginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetUserDataErrorState());
    });
  }

  //************************************************************
  void updateUserData({
    required String name ,
    required String phone ,
    required String email ,

  }) {
    emit(ShopUpdateUserDataLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'phone':phone,
        'email':email,
      }
    ).then((value) {
      shopLoginModel = ShopLoginModel.fromJason(value.data);
      print(shopLoginModel.data!.name.toString());
      emit(ShopUpdateUserDataSuccessState(shopLoginModel));
    }).catchError((error) {
       print(error.toString());
      emit(ShopUpdateUserDataErrorState());
    });
  }
}
