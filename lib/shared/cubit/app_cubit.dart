import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';



class AppCubit extends Cubit<States> {
  AppCubit() : super(IntialStates());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark =false;
  void changeMode({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
    }else{
      isDark =!isDark;
    }

  }


}