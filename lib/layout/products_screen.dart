import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/shoplayout/cubit.dart';
import 'package:shop_app/shared/cubit/shoplayout/states.dart';

class ProductScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(builder: (context,state){
      return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null,
          builder:(context)=>productsBuilder() ,
          fallback: (context)=> Center(child: CircularProgressIndicator())
      );
    }, listener: (context,state){

    });
  }
  Widget productsBuilder()=>Column(
    children: [],
  );
}