import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shoplayout.dart';
import 'package:shopapp/modules/appcubit/appcubit.dart';
import 'package:shopapp/modules/appcubit/appstates.dart';
import 'package:shopapp/modules/intro.dart';
import 'package:shopapp/modules/onboarding.dart';
import 'package:shopapp/shared/components/blockobserver.dart';
import 'package:shopapp/shared/constants/constants.dart';
import 'package:shopapp/shared/network/remote/cachehelper.dart';
import 'package:shopapp/shared/network/remote/diohelper.dart';
import 'package:shopapp/shared/styles/appthemes/lighttheme.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await  CacheHelper.init();
  Widget ? StartWidget;
  bool? checkOnBoarding = CacheHelper.getData(key: 'onboardDone');
  token = CacheHelper.getData(key: 'token');
  print(token);
  print(checkOnBoarding);

  if(checkOnBoarding !=null){
    if(token !=null) StartWidget =ShopLayOutScreen();
    else StartWidget=IntroScreen();
  }
  else
    StartWidget=OnBoardingScreen();

  runApp(MyApp(StartWidget:StartWidget));

}

class MyApp extends StatelessWidget {
 final Widget ? StartWidget ;
  MyApp({this.StartWidget});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit()
        ..isOnboardDone(fromShared:CacheHelper.getData(key: 'onboardDone'))
        ..getHomeData()
        ..getCategoriesData()
        ..getFavoritesData()
        ..getUserData(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: StartWidget,
          );
        },
      ),
    );
  }
}