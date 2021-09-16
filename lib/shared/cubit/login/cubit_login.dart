import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/cubit/login/states_login.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>
{
  ShopLoginCubit():super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  void userLogin({
  required String email,
   required String password
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data:
        {
          'email':email,
          'password':password
        }
    ).then((value) {
        print(value.data);
        loginModel = ShopLoginModel.fromJson(value.data);
       // print(loginModel.data != null ?loginModel.data!.token  : 'problem in token');
        emit(ShopLoginSuccessState(loginModel));
        print('kolo tmam');
    }).catchError((error){
      print('got error');
      print(error);
      emit(ShopLoginErrorState(error.toString()));
    });

  }
  //added Icon because it is changed during using
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){

    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    emit(ShopLoginChangePasswordVisibilityState());
  }
}