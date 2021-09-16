import 'package:shop_app/layout/login_screen.dart';

import 'components.dart';
import 'network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value){
    navigateAndFinish(context, ShopLoginScreen());
  });
}
String? token ='';