import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/categories_screen.dart';
import 'package:shop_app/layout/favourite_screen.dart';
import 'package:shop_app/layout/products_screen.dart';
import 'package:shop_app/layout/settings_screen.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/shoplayout/states.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/end_points.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens =
      [
        ProductScreen(),
        CategoriesScreen(),
        FavouriteScreen(),
        SettingScreen(),
      ];
  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
    HomeModel? homeModel;
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
      DioHelper.getData(url: HOME,token: token).then((value) {
        homeModel =HomeModel.fromJson(value.data);
        emit(ShopSuccessHomeDataState());
      }).catchError((error){
        print(error.toString());
        print('gab error');
        emit(ShopErrorHomeDataState());
      });
  }
}