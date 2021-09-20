import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/search/states.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);
    SearchModel? model;
   void search(String text)
   {emit(SearchLoadingState());
     DioHelper.postData(url:SEARCH ,
         token: TOKEN,
         data: {
        'text':text
     }).then((value){
       model = SearchModel.fromJson(value.data);
       print('got here not an error');
       emit(SearchSuccessState());
     }).catchError((error){
       print('got here  an error');
       print(error.toString());
       emit(SearchErrorState());
     });
   }

}