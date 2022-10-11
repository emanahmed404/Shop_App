class ShopLoginModel{
   bool ?status;
  String ?message;
 UserData ?data ;

 ShopLoginModel.fromJason(Map<String , dynamic> jason ){
   status =jason['status'];
   message=jason['message'];
  // data= jason['data']! !=null ? UserData.fromJason(jason['data']) : null ;
   //data=UserData.fromJason([data]);
   data = jason['data'] != null ? new UserData.fromJason(jason['data']) : null;


 }

}

class UserData {
   int ?id ;
   String ?name ;
   String ?email ;
    String ?phone ;
   String ?image ;
   int ?points ;
   int ?credits ;
   String? token ;

  //named constructor
UserData.fromJason(Map<String , dynamic>? jason){
  id =jason!['id'];
  name=jason!['name'];
  email=jason['email'];
  phone=jason['phone'];
  image=jason['photo'];
  points=jason['points'];
  credits=jason['credits'];
  token=jason['token'];

}
}