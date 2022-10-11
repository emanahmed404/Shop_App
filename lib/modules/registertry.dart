import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
         //
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                   color: Colors.pinkAccent,
                  // borderRadius: BorderRadius.only(
                  //   bottomLeft: Radius.circular(120),
                  // )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
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

    );
  }
}
 class CustomClipPath extends CustomClipper<Path>{
  @override
   Path getClip(Size size){
   // double w =size.width;
  //  double h =size.height;


    Path path0 = Path();
    path0.moveTo(size.width*0.0012500,size.height*0.7475000);
    path0.lineTo(size.width*0.0012500,0);
    path0.lineTo(size.width*0.9985000,size.height*0.0020000);
    path0.lineTo(size.width*0.9987500,size.height*0.7475000);
    path0.quadraticBezierTo(size.width*0.8318125,size.height*0.4740000,size.width*0.7495000,size.height*0.4975000);
    path0.cubicTo(size.width*0.6811250,size.height*0.5000000,size.width*0.5673750,size.height*0.7290000,size.width*0.5000000,size.height*0.7475000);
    path0.cubicTo(size.width*0.4396250,size.height*0.7530000,size.width*0.3198750,size.height*0.6100000,size.width*0.2505000,size.height*0.6255000);
    path0.quadraticBezierTo(size.width*0.1871875,size.height*0.6260000,size.width*0.0012500,size.height*0.7475000);
    path0.close();
    return path0 ;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
   return false ;
  }
 }












