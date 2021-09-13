import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/theme.dart';

import 'layout/onboarding_screen.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp( MyApp(false));
}

class MyApp extends StatelessWidget {

  final bool? isDark;
  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:[

      BlocProvider(
        create : (BuildContext context )=>AppCubit()..changeMode(
            fromShared:  isDark
        ),)
    ] , child: BlocConsumer<AppCubit,States>(
      listener: (context, state){},
      builder: (context,state){
        return   MaterialApp(
          debugShowCheckedModeBanner:false ,

          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: AppCubit.get(context).isDark ?ThemeMode.dark :ThemeMode.light ,
          home: OnBoardingScreen(),
        );

      },
    )
    );
  }
}

