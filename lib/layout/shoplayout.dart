import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/appcubit/appstates.dart';
import 'package:shopapp/modules/search.dart';
import 'package:shopapp/shared/components/components.dart';

import '../modules/appcubit/appcubit.dart';

class ShopLayOutScreen extends StatelessWidget {
  const ShopLayOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
        actions: [
          IconButton(
              onPressed: (){
                navigateto(context, SearchScreen());
              },
              icon:
              Icon(
                  Icons.search
              ),
          ),
        ],
      ),
      body:
      AppCubit.get(context).bottomNavBarList[AppCubit.get(context).currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          AppCubit.get(context).changeBottomNav(index);
        },
        currentIndex: AppCubit.get(context).currentIndex,
        items: [
          BottomNavigationBarItem(
              icon :Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon :Icon(Icons.category_outlined),
              label: 'Category'),
          BottomNavigationBarItem(
              icon :Icon(Icons.favorite_border),
              label: 'favorite'),
          BottomNavigationBarItem(
              icon :Icon(Icons.settings),
              label: 'settings'),
        ],
      ),
    );
  },
);
  }
}
