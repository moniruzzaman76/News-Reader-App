import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import '../models/news_model.dart';
import '../offline_data/offline_news_data.dart';
import '../utility/urls.dart';

class ApiServices {
  Future<List<ArticlesData>> getRequest() async {
    try {
      Response response = await get(Uri.parse(Urls.getNews));
      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final List result = decodedResponse['articles'];
        final List<ArticlesData> articlesDataList =
            result.map((e) => ArticlesData.fromJson(e)).toList();
        LocalDataStorage.saveArticlesData(articlesDataList);
        return articlesDataList;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (error) {
      log('Error in getRequest: $error');
      return [];
    }
  }
}
