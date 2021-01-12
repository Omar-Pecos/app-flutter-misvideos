import 'dart:async';
import 'package:apm_pip/models/apmModel.dart';
//import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:apm_pip/common/constants.dart';

class HttpHandler {
  final dio = Dio();
  final String _baseUrl = 
    env == 'development' ? API_URL_DEV : API_URL_PROD;
  String endpoint;
  
  HttpHandler(){
    endpoint = createEndpoint();
  }

  String createEndpoint(){
      String endpoint;
      if (env == 'development')
          endpoint = 'http://' + _baseUrl + '/api/v1/apm';
        else
          endpoint = 'https://' + _baseUrl + '/api/v1/apm';
          
      return endpoint;
  }
 
  Future<List<Apm>> getAll() async {

    try {
        Response res = await dio.get(endpoint);
        final resBody = res.data;

        if (res.statusCode == 200) {
          return resBody['data'].map<Apm>((item) => 
            Apm.fromJson(item)
          ).toList();
        } 
    }catch (e) {
      final resError = e.response.data;
      String errorMsg = resError['error'];
      
      throw errorMsg;
    }

  }

  Future<Apm> create(Apm apm) async{

    try{
      Response res = await dio.post(
            endpoint,
            data: {
              'name' : apm.name,
              'command' : apm.command,
              'desc' : apm.desc,
              'url' : apm.url
            }
          );

      final resBody = res.data;

      if (res.statusCode == 201){
        return Apm.fromJson(resBody['data']);
      }

    }catch(e){
        final resError = e.response.data;
        String errorMsg = resError['error'];
      
        throw errorMsg;
      }
    } 

    Future<Apm> delete(int id) async{
      try {
        final Response res = await dio.delete(endpoint + '/' + id.toString());
        final resBody = res.data;

        if (res.statusCode == 200){
          return Apm.fromJson(resBody['data']);
        }
      } catch (e) {
        final resError = e.response.data;
        String errorMsg = resError['error'];

        throw errorMsg;
      }
    }
  }
