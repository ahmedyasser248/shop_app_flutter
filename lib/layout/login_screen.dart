import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/register_screen.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/cubit/login/cubit_login.dart';
import 'package:shop_app/shared/cubit/login/states_login.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget{

 var emailController = TextEditingController();
 var passwordController = TextEditingController();
 var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        listener: (context,state){
          if(state is ShopLoginSuccessState){
            print('got here');
            if(state.loginModel != null && state.loginModel!.status!){
              print(state.loginModel!.data.toString());
              Fluttertoast.showToast(
                  msg: state.loginModel!.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              CacheHelper.saveData(key: 'token',
                  value: state.loginModel!.data!.token ).then((value)
              {
                navigateAndFinish(context, ShopLayout());
              });

              print('got here 2');
            }else{
              print(state.loginModel!.message);
              Fluttertoast.showToast(
                  msg: state.loginModel!.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              print('got here 3');
            }
          }
        } ,
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
                            onSubmit: (String value){
                              if(formKey.currentState!.validate()){
                                ShopLoginCubit.get(context).userLogin(email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            suffixPressed: ()
                            {
                              ShopLoginCubit.get(context).changePasswordVisibility();
                            },
                            suffix: ShopLoginCubit.get(context).suffix,
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
                            print('hot here5');
                            if(formKey.currentState!.validate()){
                              print('got here 6');
                              ShopLoginCubit.get(context).userLogin(email: emailController.text,
                                  password: passwordController.text);
                              print('hot here 7');
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