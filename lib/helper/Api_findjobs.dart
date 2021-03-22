import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
class Api_findjobs {
  String api;
  Map param;
  Api_findjobs(api , param){
    this.api = api;
    this.param = param;
  }
  postMethod() async {
    String url2 = "https://find-job-app.herokuapp.com"+this.api;
    var params = this.param;
    Response response = await post(url2, body: params);
    final res = jsonDecode(response.body);
    print(res);
    return res;
  }
  getMethod() async {
    String url2 = "https://find-job-app.herokuapp.com"+this.api;
   // var params = this.param;
    Response response = await get(url2);
    final res = jsonDecode(response.body);
    print(res);
    return res;
  }
}