import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/search_screen.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/cubit/shoplayout/cubit.dart';
import 'package:shop_app/shared/cubit/shoplayout/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'login_screen.dart';

class ShopLayout extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'salla'
            ),
            actions: [
              IconButton(icon: Icon(Icons.search),onPressed: (){
                navigateTo(context, SearchScreen());
              },)
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
              currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(
                  Icons.home
                ),
                label: 'Home'
              ),
              BottomNavigationBarItem(icon: Icon(
                Icons.apps
              ),
                label: 'Categories'
              ),
              BottomNavigationBarItem(icon: Icon(
                  Icons.favorite),
                label: 'Favourite'

              ),
              BottomNavigationBarItem(icon: Icon(
                Icons.settings
              ),
                label: 'settings'
              )
            ],

          ),
        );
      },
    );
  }
}