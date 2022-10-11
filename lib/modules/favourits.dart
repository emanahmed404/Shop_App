import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/components/components.dart';
import 'appcubit/appcubit.dart';
import 'appcubit/appstates.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopGetFavoritesDataLoadingState ,
          builder: (context)=>ListView.separated(
            itemBuilder: (context, index) => buildListItem(AppCubit.get(context).favoritesModel!.data!.data![index].product!,context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                    width: double.infinity,
                    color: Colors.grey[300],
                    height: 1,
                  ),
            ),
            itemCount: AppCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
    );  }

}
