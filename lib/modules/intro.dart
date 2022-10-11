import 'package:flutter/material.dart';
import 'package:shopapp/modules/login.dart';
import 'package:shopapp/modules/registerOriginal.dart';
import 'package:shopapp/modules/registertry.dart';
import 'package:shopapp/shared/components/components.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
            child: Column(
              children: [
                        Container(
                        width: double.infinity,
                          child: Image(
                              image: AssetImage('assets/images/intro1.jpg'),
                              fit: BoxFit.cover,
                          )
                      ),
                        SizedBox(
                          height: 80,
                        ),

                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(70),)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Welcome to our market , ',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.blueAccent

                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Kamonazz Market ... ',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.blueAccent

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 150,
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      defaultButton(
                                        text: 'Login',
                                        function: (){
                                          navigateto(context, LoginScreen());
                                        },
                                        width: 290,
                                        isUpper: false,

                                      ),

                                      SizedBox(
                                        height: 20,
                                      ),
                                      defaultButton(
                                        text: 'Register',
                                        function: (){
                                          navigateto(context, RegisterOriginalScreen());
                                        },
                                        width: 290,
                                        isUpper: false,
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ]





      ),
          )

    );
  }
}
