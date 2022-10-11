import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/searchBloc/cubit.dart';
import 'package:shopapp/modules/searchBloc/states.dart';
import 'package:shopapp/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 7
                ),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        lable: 'Search',
                        prefix:Icons.search,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Search about what ?!!';
                            }
                            else
                              return null ;
                          },
                      onSubmit: (String text){
                          SearchCubit.get(context).search(text);
                      }
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    if(state is SearchDataLoadingState)
                      LinearProgressIndicator(),

                    SizedBox(
                      height: 20,
                    ),
                    if(state is SearchDataSuccessState)
                       Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index,) => buildListItem(SearchCubit.get(context).model!.data!.data![index], context, isOldPrice: false),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            width: double.infinity,
                            color: Colors.grey[300],
                            height: 1,
                          ),
                        ),
                        itemCount: SearchCubit.get(context).model!.data!.data!.length,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
