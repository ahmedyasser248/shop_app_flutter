import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/shoplayout/cubit.dart';
import 'package:shop_app/shared/cubit/shoplayout/states.dart';

class SettingScreen extends StatelessWidget{
  var nameController = TextEditingController();
  var emailController =TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){

      },
      builder: (context,state){
          var model = ShopCubit.get(context).userModel;
          nameController.text = model!.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context)=> Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String? value){
                      if(value!.isEmpty){
                        return'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String? value){
                      if(value!.isEmpty){
                        return'email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email
                ),
                SizedBox(
                  height: 20.0,

                )
                ,defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value){
                      if(value!.isEmpty){
                        return'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultButton(
                  text: 'Logout',
                 function: (){
                      signOut(context);
                 }
                )
              ],
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),

        );
      },

    );
  }
}