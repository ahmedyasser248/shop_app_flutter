import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/register_screen.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/cubit/login/cubit_login.dart';
import 'package:shop_app/shared/cubit/login/states_login.dart';

class ShopLoginScreen extends StatelessWidget{

 var emailController = TextEditingController();
 var passwordController = TextEditingController();
 var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        listener: (context,state){} ,
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'login now to brows our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey
                          )

                          ,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return 'please enter your email Address';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: Icons.visibility,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return 'password is too short';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outlined
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=>defaultButton(text: 'login',isUpperCase: true,function: ()
                          {
                            if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(email: emailController.text,
                                  password: passwordController.text);
                            }

                          }),
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(function: (){}, text: 'register')

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}