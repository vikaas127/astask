import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/State_model.dart';
import '../model/city_model.dart';
import '../model/country_model.dart';
import 'package:http/http.dart' as http;
class Api{
  

  String? baseUrl ="https://beta.srdv.in/interview/dashboard/";
  //country api

  Future<country_model> CountryRequest() async {



    var url = Uri.parse('https://beta.srdv.in/interview/dashboard/CountryList');
    http.Response response = await http.post(url,headers: {
      'Api-Token':'sr7It@y+2lcView'
    });

    print('Response body: ${country_model.fromJson(jsonDecode(response.body))}');



    /*const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Api-Token':'sr7It@y+2lcView'

    };
    final _data ;
    final _result = await Dio().fetch<Map<String, dynamic>>(

            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(Dio().options, 'CountryList',
                queryParameters: queryParameters, )
                .copyWith(baseUrl: "https://beta.srdv.in/interview/dashboard/CountryList" ?? Dio().options.baseUrl));
    final value = country_model.fromJson(_result.data!);*/
    return country_model.fromJson(jsonDecode(response.body));
  }
   //state api
   Future<state_model> StateRequest(body) async {
     var url = Uri.parse('https://beta.srdv.in/interview/dashboard/StateList');
     http.Response response = await http.post(url,body:json.encode (body), headers: {
       'Api-Token': 'sr7It@y+2lcView'
     });

     print('Response body: ${state_model.fromJson(jsonDecode(response.body))}');

print(response.body.toString());
     /*const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Api-Token':'sr7It@y+2lcView'

    };
    final _data ;
    final _result = await Dio().fetch<Map<String, dynamic>>(

            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(Dio().options, 'CountryList',
                queryParameters: queryParameters, )
                .copyWith(baseUrl: "https://beta.srdv.in/interview/dashboard/CountryList" ?? Dio().options.baseUrl));
    final value = country_model.fromJson(_result.data!);*/
     return state_model.fromJson(jsonDecode(response.body));
   }
   //city api
   Future<city_model> CityRequest(body) async {
     var url = Uri.parse('https://beta.srdv.in/interview/dashboard/CityList');
     http.Response response = await http.post(url,body:json.encode(body), headers: {
       'Api-Token': 'sr7It@y+2lcView'
     });

     print('Response body: ${city_model.fromJson(jsonDecode(response.body))}');


     /*const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Api-Token':'sr7It@y+2lcView'

    };
    final _data ;
    final _result = await Dio().fetch<Map<String, dynamic>>(

            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(Dio().options, 'CountryList',
                queryParameters: queryParameters, )
                .copyWith(baseUrl: "https://beta.srdv.in/interview/dashboard/CountryList" ?? Dio().options.baseUrl));
    final value = country_model.fromJson(_result.data!);*/
     return city_model.fromJson(jsonDecode(response.body));

     }
}