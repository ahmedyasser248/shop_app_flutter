
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/cubit/shoplayout/cubit.dart';
import 'package:shop_app/shared/cubit/shoplayout/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
              builder: (context) =>
                  productsBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!,context),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        },
        listener: (context, state) {

          if(state is ShopSuccessChangeFavoriteState)
          {
            if(!state.model.status!){
              Fluttertoast.showToast(
                  msg: state.model.message! ,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        });
  }

  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal),
            ),

            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories'
                        ,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=> buildCategoryItem(categoriesModel.data!.data[index]),
                        separatorBuilder:(context,index)=>SizedBox(
                          width: 10.0,
                        ),
                        itemCount: categoriesModel.data!.data.length),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Products'
                    ,
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: GridView.count(
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.58,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                      model.data.products.length,
                      (index) =>
                          buildGridProduct(model.data.products[index],context))),
            )
          ],
        ),
      );

  Widget buildGridProduct(ProductModel model,context) => Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart ,
              children:[
                Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200.0,
               ),
                 if(model.discount != 0)
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Row(children: [
                    Text(
                      '${model.price.round()}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
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
                        backgroundColor: ShopCubit.get(context).favorites[model.id]!?defaultColor :Colors.grey ,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                        ),
                      ) ,
                      onPressed:(){
                            ShopCubit.get(context).changeFavorites(model.id);
                      }
                      ,)
                  ]),
                ],
              ),
            ),
          ],
        ),
      );
  Widget buildCategoryItem(DataModel dataModel)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(dataModel.image!),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: 100,
        child: Text(
          dataModel.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color : Colors.white
          ),
        ),
      )

    ],
  );
}
