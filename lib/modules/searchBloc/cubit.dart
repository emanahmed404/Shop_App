import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/searchmodel.dart';
import 'package:shopapp/modules/searchBloc/states.dart';
import 'package:shopapp/shared/constants/constants.dart';
import 'package:shopapp/shared/network/remote/diohelper.dart';
import 'package:shopapp/shared/network/remote/endpoints.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchDataInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchDataLoadingState());
    DioHelper.postData(url: SEARCH, data: {'text': text},
    token: token).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchDataSuccessState());
    }).catchError((error) {
      emit(SearchDataErrorState());
      print(error.toString());
    });
  }
}