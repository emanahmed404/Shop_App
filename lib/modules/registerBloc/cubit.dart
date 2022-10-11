import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/loginmodel.dart';
import 'package:shopapp/modules/registerBloc/states.dart';
import 'package:shopapp/shared/network/remote/diohelper.dart';
import '../../shared/network/remote/endpoints.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=> BlocProvider.of(context);

  late ShopLoginModel loginDataModel ;

   void userRegister({
   required  String name,
     required  String phone,
     required  String email,
   required  String password,
}){
     emit(ShopRegisterLoadingState());
     DioHelper.postData(
         url: REGISTER,
         data: {
           'name' : name ,
           'phone' : phone,
           'email': email ,
           'password' :password ,
         }).then((value) {
           loginDataModel =ShopLoginModel.fromJason(value.data);
           print(loginDataModel.status.toString());
           print(loginDataModel.data!.token.toString());
           emit(ShopRegisterSuccessState(loginDataModel));
     }).catchError((error){
       print(error.toString());
       emit(ShopRegisterErrorState(error.toString()));
     });
   }


   IconData suffix = Icons.visibility_off_outlined;
   bool isPasswordObsecure =true ;
   void changeIconVisibility (){
     isPasswordObsecure=!isPasswordObsecure;
     suffix= isPasswordObsecure? Icons.visibility_off_outlined : Icons.visibility_outlined;
     emit(ShopChangePasswordVisibilityState());
   }

}