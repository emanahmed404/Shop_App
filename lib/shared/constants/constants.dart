import '../../modules/login.dart';
import '../components/components.dart';
import '../network/remote/cachehelper.dart';

void signout(context)
{
  CacheHelper.removeData(key: 'token').then((value){
    if(value){
      navigateandfinish(context, LoginScreen());
    }
  });

}
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String? token;