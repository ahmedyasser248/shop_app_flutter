import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/cubit/shoplayout/cubit.dart';
import 'package:shop_app/shared/cubit/shoplayout/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavouriteScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
              itemBuilder: (context,index)=>buildFavItem(ShopCubit.get(context).favoritesModel!.data!.data![index]!,context),
              separatorBuilder: (context,index)=> myDivider(),
              itemCount:ShopCubit.get(context).favoritesModel!.data!.data!.length
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),

        );
      },

    );

  }
  Widget buildFavItem(FavoritesData model,context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 100.0,
      child: Row(
        children: [
          Stack(
              alignment: AlignmentDirectional.bottomStart ,
              children:[
                Image(
                  image: NetworkImage(model.product!.image!),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                if(model.product!.discount! != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white
                      ),
                    ),
                  )
              ]
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  model.product!.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(children: [
                  Text(
                    '${model.product!.price!.round()}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (model.product!.discount! != 0)
                    Text(
                      '${model.product!.oldPrice!.round()}',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    icon:CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).favorites[model.product!.id]!?defaultColor :Colors.grey ,
                      child: Icon(
                        Icons.favorite_border,
                        size: 14.0,
                      ),
                    ) ,
                    onPressed:(){
                      ShopCubit.get(context).changeFavorites(model.product!.id!);
                    }
                    ,)
                ]),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}