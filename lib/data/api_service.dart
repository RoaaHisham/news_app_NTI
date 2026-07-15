import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/data/article.dart';

class ApiService {


  static Future<List<Article>> getNews()async{
    Uri url = Uri.https(
        "newsapi.org",
        "/v2/everything",
        {
          "q":"tesla",
          "from":"2026-06-15",
          "sortBy":"publishedAt",
          "apiKey":"c470ca3632cc4d8c8e053dbf093d6e79"
        });
    var response =await http.get(url);
    var responseBody = jsonDecode(response.body);
    List<dynamic> articlesJson = responseBody['articles'];
    List<Article> article = articlesJson.map((a){
     return Article.fromJson(a);
    }).toList();
    return article;
  }



}



//https://newsapi.org
// /v2/everything
// ?q=tesla
// &from=2026-06-15&
// sortBy=publishedAt
// &apiKey=c470ca3632cc4d8c8e053dbf093d6e79