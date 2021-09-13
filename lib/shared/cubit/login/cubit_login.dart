import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/login/states_login.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>
{
  ShopLoginCubit():super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
  required String email,
   required String password
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data:
        {
          'email':'',
          'password':''
        }
    ).then((value) {
        print(value.data);
        emit(ShopLoginSuccessState());
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });


  }
}