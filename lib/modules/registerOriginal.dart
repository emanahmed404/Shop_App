import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/login.dart';
import 'package:shopapp/modules/registerBloc/cubit.dart';
import 'package:shopapp/modules/registerBloc/states.dart';
import '../layout/shoplayout.dart';
import '../shared/components/components.dart';
import '../shared/constants/constants.dart';
import '../shared/network/remote/cachehelper.dart';

class RegisterOriginalScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController =TextEditingController();
  var phoneController =TextEditingController();
  var emailController =TextEditingController();
  var passwordController =TextEditingController();
  var confirmController =TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ShopRegisterCubit(),
  child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
  listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginDataModel.status!) {
              print(state.loginDataModel.message);
              print(state.loginDataModel.data!.token);
              showToast(
                  msg: state.loginDataModel.message!,
                  state: ToastStates.SUCESS);
              CacheHelper.saveData(
                      key: 'token', value: state.loginDataModel.data!.token).then((value) {
                token = state.loginDataModel.data!.token;
                navigateandfinish(context, ShopLayOutScreen());
              });
            }
      else{
        print(state.loginDataModel.message!);
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
          key: formKey,
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
                    left: 45,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        'hey , join us and create a new acc !',
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
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          lable: 'User Name',
                          prefix: Icons.person,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                            else
                              return null ;
                          }
                          ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          lable: 'Phone Number',
                          prefix: Icons.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }
                            else
                              return null ;
                          }
                          ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          lable: 'Email Address',
                          prefix: Icons.email_outlined,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'email must be not null';
                            }
                            else
                              return null ;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'password is too weak ';
                          }
                          else
                            return null ;
                        },
                        type: TextInputType.text,
                        lable: 'Password',
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            ShopRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text
                            );
                          }
                        },
                        prefix: Icons.lock_outline,
                        suffix:  ShopRegisterCubit.get(context).suffix,
                        IsObscure:  ShopRegisterCubit.get(context).isPasswordObsecure,
                        suffixPressed:  ShopRegisterCubit.get(context).changeIconVisibility,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: confirmController,
                        validate: (String? value) {
                          // if(value != passwordController){
                          //   return'confirmation password must match password';
                          // }
                          if (value!.isEmpty) {
                            return 'confirmation password must match password';
                          }
                          else
                            return null ;
                        },
                        type: TextInputType.text,
                        lable: 'Confirm Password',
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            ShopRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text
                            );
                          }
                        },
                        prefix: Icons.lock_outline,
                        suffix:  ShopRegisterCubit.get(context).suffix,
                        IsObscure:  ShopRegisterCubit.get(context).isPasswordObsecure,
                        suffixPressed:  ShopRegisterCubit.get(context).changeIconVisibility,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) => defaultButton(
                          text: 'Register',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                              );
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
                            ' you already have an account ? ,..',
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateto(context, LoginScreen());
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
