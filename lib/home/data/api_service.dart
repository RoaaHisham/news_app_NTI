import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/home/data/result_api.dart';

import 'news_model.dart';

class ApiService {


  static Future<ResultApi<NewsModel>> getNews()async{

    try{
      Uri url = Uri.https(
          "newsapi.org",
          "/v2/everything",
          {
            "q":"tesla",
            "apiKey":"c470ca3632cc4d8c8e053dbf093d6e79"
          });
      var response =await http.get(url);
      var responseBody = jsonDecode(response.body);
      var newsModel = NewsModel.fromJson(responseBody);
      return Success<NewsModel>(newsModel);
    }catch(e){
      return Error<NewsModel>(e.toString());
    }
  }



}



//https://newsapi.org/v2/everything?q=tesla&from=2026-06-15&sortBy=publishedAt&apiKey=c470ca3632cc4d8c8e053dbf093d6e79