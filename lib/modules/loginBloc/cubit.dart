import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/loginmodel.dart';
import 'package:shopapp/modules/loginBloc/states.dart';
import 'package:shopapp/shared/network/remote/diohelper.dart';
import '../../shared/network/remote/endpoints.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context)=> BlocProvider.of(context);

  late ShopLoginModel loginDataModel ;
   void userLogin({
   required  String email,
   required  String password,
}){
     emit(ShopLoginLoadingState());
     DioHelper.postData(
         url: LOGIN,
         data: {
           'email': email ,
           'password' :password ,
         }).then((value) {
           loginDataModel =ShopLoginModel.fromJason(value.data);
           print(loginDataModel.status.toString());
           print(loginDataModel.data!.token.toString());
          // print(value.toString());
           emit(ShopLoginSuccessState(loginDataModel));
     }).catchError((error){
       print(error.toString());
       emit(ShopLoginErrorState(error.toString()));
     });
   }


   IconData suffix = Icons.visibility_off_outlined;
   bool isPasswordobsecure =true ;
   void changeIconVisibility (){
     isPasswordobsecure=!isPasswordobsecure;
     suffix= isPasswordobsecure? Icons.visibility_off_outlined : Icons.visibility_outlined;
     emit(ShopChangePasswordVisibilityState());
   }

}