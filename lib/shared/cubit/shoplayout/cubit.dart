import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/categories_screen.dart';
import 'package:shop_app/layout/favourite_screen.dart';
import 'package:shop_app/layout/products_screen.dart';
import 'package:shop_app/layout/settings_screen.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorite_models.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
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
  Map<int,bool> favorites={};
  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
    HomeModel? homeModel;
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
      DioHelper.getData(url: HOME,token: TOKEN).then((value) {
        homeModel =HomeModel.fromJson(value.data);
        homeModel!.data.products.forEach((element) {
          favorites.addAll({
            element.id:element.inFavourites
          });
        });

        emit(ShopSuccessHomeDataState());
      }).catchError((error){
        print(error.toString());
        emit(ShopErrorHomeDataState());
      });
  }
  CategoriesModel? categoriesModel;
  void getCategoriesData(){

    DioHelper.getData(url: GET_CATEGORIES).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      emit(ShopErrorCategoriesState());
    });
  }
  late ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId){
    favorites[productId] = !(favorites[productId]!);
    emit(ShopChangeFavoriteState());
    DioHelper.postData(url: FAVORITES, data: {
      'product_id':productId
    },
    token: TOKEN
    ).then((value) {

        changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
        if(!changeFavoritesModel.status!){
          favorites[productId]=!favorites[productId]!;
        }else{
          getFavorites();
        }
        emit(ShopSuccessChangeFavoriteState(changeFavoritesModel));
    }).catchError((error){
      favorites[productId]=!favorites[productId]!;
      print(error.toString());
      print('error hena ya 7ob');
        emit(ShopErrorChangeFavoriteState());
     });
  }
  FavoritesModel? favoritesModel;
  void getFavorites(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES,
        token: TOKEN
    ).then((value){
      print('wslna hena');
      print(TOKEN);
      favoritesModel = FavoritesModel.fromJson(value.data);

      print('mwslnash hena');
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      print('error hena agamel');
      emit(ShopErrorChangeFavoriteState());
    });
  }
  ShopLoginModel? userModel;
  void getUserData(){
    emit(ShopLoadingUserDataState());
      DioHelper.getData(url: PROFILE,
      token: TOKEN,
      ).then((value){
        userModel = ShopLoginModel.fromJson(value.data);
        print(value.data.toString());
        emit(ShopSuccessUserDataState());
      }).catchError((error){
        print(error.toString());
        emit(ShopErrorUserDataState());
      });
  }
}