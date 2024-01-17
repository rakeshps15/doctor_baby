import 'package:doctor_baby/view/profile.dart';
import 'package:http/http.dart' as https;

class Httpdates{
  static Future<dynamic> fetchDates() async{
    var url = "http://10.0.2.2:8000/babyapp/childcreate/${ProfilePage.userId}/vaccination-dates/";
    print("URL: $url");
    // var response = await https.get(Uri.parse("http://10.0.2.2:8000/babyapp/childcreate/${ProfilePage.userId}/vaccination-dates/"));
    var response = await https.get(Uri.parse(url));
    if(response.statusCode==200){
      return response.body;
    }else{
      throw Exception();
    }
  }
}