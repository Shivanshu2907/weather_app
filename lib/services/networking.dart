import 'package:http/http.dart';
import 'dart:convert';




class NetworkData{

 final String url;

 NetworkData(this.url); 
 
  Future getResponse() async {
    Response response = await get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      var refData=jsonDecode(data);
      return refData;
    }
  }
}