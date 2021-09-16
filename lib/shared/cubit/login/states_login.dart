import 'package:shop_app/models/login_model.dart';

abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState{}

class ShopLoginLoadingState extends ShopLoginState{}

class ShopLoginSuccessState extends ShopLoginState{
  ShopLoginModel? loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginState{
  late final String error;
  ShopLoginErrorState(this.error);
}
class ShopLoginChangePasswordVisibilityState extends ShopLoginState{}
