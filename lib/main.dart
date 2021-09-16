import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/login_screen.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/shoplayout/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/theme.dart';

import 'layout/onboarding_screen.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  late Widget widget;
  if(onBoarding != null){
    if(token != null) widget = ShopLayout();
    else widget = ShopLoginScreen();
  }else
    {
      widget = OnBoardingScreen();
    }
  runApp( MyApp(
  isDark : false,
  startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final bool? isDark;
  final Widget? startWidget;
  MyApp({this.isDark,this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:[

      BlocProvider(
        create : (BuildContext context )=>AppCubit()..changeMode(
            fromShared:  isDark
        ),),
      BlocProvider(
        create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategoriesData(),
      )
    ] , child: BlocConsumer<AppCubit,States>(
      listener: (context, state){},
      builder: (context,state){
        return   MaterialApp(
          debugShowCheckedModeBanner:false ,

          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: AppCubit.get(context).isDark ?ThemeMode.dark :ThemeMode.light ,
          home:  startWidget ,
        );

      },
    )
    );
  }
}

