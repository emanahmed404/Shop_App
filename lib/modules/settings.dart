import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/appcubit/appcubit.dart';
import 'package:shopapp/modules/appcubit/appstates.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/constants/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var imageController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = AppCubit
              .get(context)
              .shopLoginModel;
          nameController.text = model.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
          return Scaffold(
            body: ConditionalBuilder(
              condition: AppCubit
                  .get(context)
                  .shopLoginModel != false,
              builder: (BuildContext context) =>
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child:Column(
                          children: [

                            Stack(
                              children: [
                                Container(
                                  width: 130.0,
                                  height: 130.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.white,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://student.valuxapps.com/storage/assets/defaults/user.jpg"),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.pink,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit_outlined,
                                        color: Colors.white,
                                      ),

                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),

                            defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              lable: 'Name',
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'name must be not null';
                                }
                                else
                                  return null;
                              },
                              prefix: Icons.person,
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              controller: phoneController,
                              type: TextInputType.name,
                              lable: 'Phone Number',
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Phone must be not null';
                                } else
                                  return null;
                              },
                              prefix: Icons.phone,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.name,
                              lable: 'Email Address',
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Email must be not null';
                                } else
                                  return null;
                              },
                              prefix: Icons.email,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if(state is ShopUpdateUserDataLoadingState)
                              LinearProgressIndicator(),

                             Spacer(),
                            defaultButton(
                              text: 'Update Profile',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  AppCubit.get(context).updateUserData(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text
                                  );
                                }
                                else
                                  return null;
                              },
                              width: 290,
                              isUpper: false,
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            defaultButton(
                              text: 'Sign Out',
                              function: () {
                                signout(context);
                              },
                              width: 290,
                              isUpper: false,
                            ),
                          ],
                        ),
                    ),
                  ),
              fallback: (BuildContext context) =>
                  Center(child: CircularProgressIndicator()),
            ),
          );
        }
    );
  }
}