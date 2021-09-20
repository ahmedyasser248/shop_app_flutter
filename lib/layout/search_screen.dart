import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/cubit/search/cubit.dart';
import 'package:shop_app/shared/cubit/search/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget{

  var fomrKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:
    (BuildContext context)=> SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
       builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: fomrKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                      defaultFormField(controller:searchController ,
                          type: TextInputType.text,
                          validate: (String? value){
                                if(value!.isEmpty){
                                  return 'enter text to search';
                                }
                                return null;
                          },
                          label: 'Search',
                          prefix: Icons.search,
                        onSubmit: (String? text){
                          SearchCubit.get(context).search(text!);
                        },
                      ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator()
                    ,
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(child: ListView.separated(
                        itemBuilder: (context,index) => buildListProduct(SearchCubit.get(context).model!.data!.data![index], context,isOldPrice: false),
                        separatorBuilder: (context,index)=>myDivider(),
                        itemCount: SearchCubit.get(context).model?.data?.data?.length == null ? 0:SearchCubit.get(context).model!.data!.data!.length
                    )
                    ),
                  ],
                ),
              ),
            ),
          );

        },
      ),

    );
  }

}