import 'package:dio/dio.dart';

import '../../../../Constans.dart';


class SearchRouteApi {

  Future<String> getRoute(Map<String, dynamic> queryParameter,) async {
    BaseOptions options = BaseOptions(
      baseUrl: BASE_URL_FOR_SEARCH_ROUTE,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      queryParameters: queryParameter,
    );
    Dio dio = Dio(options);
    Response response = await dio.get('/json');
    if (response.statusCode == 200) {
      return response.toString();
    } else {
      return null;
    }
  }
}

