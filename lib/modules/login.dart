import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shoplayout.dart';
import 'package:shopapp/modules/registerOriginal.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/constants/constants.dart';
import 'package:shopapp/shared/network/remote/cachehelper.dart';
import 'loginBloc/cubit.dart';
import 'loginBloc/states.dart';

class LoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
            if(state.loginDataModel.status!){
              print(state.loginDataModel.message!);
              showToast(
                  msg: state.loginDataModel.message!,
                  state: ToastStates.SUCESS);
              CacheHelper.saveData(key: 'token', value: state.loginDataModel.data!.token)
                  .then((value){
                    token=state.loginDataModel.data!.token;
                navigateandfinish(context, ShopLayOutScreen());
              });
            }
            else{
              print(state.loginDataModel.message);
              showToast(
                  msg: state.loginDataModel.message!,
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.pinkAccent,
              iconTheme: IconThemeData(
                  color: Colors.white
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Stack(children: [
                      Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(120),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0.0,
                          left: 50,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                            Text(
                              'Log in now to see our hot offers !',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              lable: 'Email Address',
                              prefix: Icons.email_outlined,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'email must be not null';
                                }
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'password must be not null';
                              }
                            },
                            type: TextInputType.text,
                            lable: 'Password',
                            onSubmit: (value) {
                              if (formkey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            prefix: Icons.lock_outline,
                            suffix: ShopLoginCubit.get(context).suffix,
                            IsObscure: ShopLoginCubit.get(context).isPasswordobsecure,
                            suffixPressed: ShopLoginCubit.get(context).changeIconVisibility,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) => defaultButton(
                              text: 'Login',
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              width: 290,
                              isUpper: false,
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' Don\'t have an account ? ,..',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateto(context, RegisterOriginalScreen());
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
