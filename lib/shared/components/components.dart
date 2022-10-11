import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/appcubit/appcubit.dart';

Widget defaultButton ({
  double width = double.infinity,
  Color  background =Colors.pinkAccent,
  double radious =18.0 ,
  double heigh =40.0 ,
  bool isUpper = true ,
  required String text ,
  required VoidCallback function ,})=>Container(
  width: width,
  height:heigh ,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpper? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ) ,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
        radious
    ),
    color: background,
  ),
);


Widget defaultFormField({
  required TextEditingController? controller ,
  required TextInputType type ,
  required String lable ,
  required IconData prefix,
  IconData? suffix,
  bool IsObscure = false ,
  VoidCallback? suffixPressed,
  Function(String)?  onSubmit,
  String? Function(String?)? validate ,
  VoidCallback? onPressed ,
})=> TextFormField(
  controller: controller,
  keyboardType: type ,
  obscureText: IsObscure ,
  onFieldSubmitted: onSubmit ,
  validator: validate,
  decoration: InputDecoration(
    // hintText: 'Password',
    labelText: lable,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix!=null ? IconButton(
      icon: Icon(suffix),
      onPressed: suffixPressed ,
    ) : null,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);



void showToast({
  required String msg ,
  required ToastStates state,
}){
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
}

Color chooseToastColor(ToastStates state,){
  Color color;
  switch(state){
    case ToastStates.SUCESS:
      color= Colors.green ;
      break;
    case ToastStates.ERROR:
      color= Colors.red ;
      break;
    case ToastStates.WARNING:
      color= Colors.black ;
      break;
  }
  return color;
}
enum ToastStates{SUCESS ,ERROR ,WARNING}



Future <Widget> navigateto (context,Widget) async=> await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=>Widget,
  ),
);

Future <Widget> navigateandfinish (context,Widget) async=> await Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context)=>Widget,
  ),
  (Route<dynamic> route) =>false ,
);





Widget buildListItem( model ,context ,{
  bool isOldPrice =true
})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 120,
              height: 120.0,
              // fit: BoxFit.cover,
            ),
            if(model.discount != 0 &&isOldPrice)
              Container(
                color: Colors.pink,
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.0,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 8,),
              // Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price!}',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.pinkAccent
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  if(model.discount!= 0 && isOldPrice)
                    Text(
                      '${model.oldPrice!.round()}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                        decoration :TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      AppCubit.get(context).changeFavorites(model.id);
                      print(model.id);
                    },
                    icon:AppCubit.get(context).favorites[model.id]!  ?
                    Icon(Icons.favorite , color: Colors.pink,) :  Icon(Icons.favorite_border),
                  ),

                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
