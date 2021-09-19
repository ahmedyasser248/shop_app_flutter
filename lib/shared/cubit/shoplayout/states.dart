import 'package:shop_app/models/change_favorite_models.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState  extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopChangeFavoriteState extends ShopStates{}

class ShopSuccessChangeFavoriteState extends ShopStates{
  late final ChangeFavoritesModel model;
  ShopSuccessChangeFavoriteState(this.model);
}

class ShopErrorChangeFavoriteState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{
 late final ShopLoginModel loginModel;
 ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates{}

class ShopLoadingUpdateUserState extends ShopStates{}

class ShopSuccessUpdateUserState extends ShopStates{}

class ShopErrorUpdateUserState extends ShopStates{}