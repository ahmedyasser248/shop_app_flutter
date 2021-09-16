import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio;
  static init(){
    dio  = Dio(
        BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,

        )
    );
  }
  static Future<Response> getData({
    required String url,
    Map<String,dynamic>? query,
    String lang ='en',
    String? token
  })async
  {
    if(token == null){
      dio!.options.headers= {
        'lang':lang,
        'Content-Type':'application/json'
      };
    }else{
      print('got here');
      print(token);
      dio!.options.headers= {
        'lang':lang,
        'token':token,
        'Content-Type':'application/json'
      };
    }

    return await dio!.get(url,queryParameters: query);
  }
  static Future<Response> postData({
  required String url,
    Map<String,dynamic>?query,
    required Map<String,dynamic>data,
    String lang ='en',
    String? token
})async{
    if(token == null){
      dio!.options.headers= {
        'lang':lang,

        'Content-Type':'application/json'
      };
    }else{
      dio!.options.headers= {
        'lang':lang,
        'Authorization':token,
        'Content-Type':'application/json'
      };
    }
    return dio!.post(url,
    queryParameters: query,
    data: data);
  }
}