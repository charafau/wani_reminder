import 'package:dio/dio.dart';
import 'package:wani_reminder/core/header_provider.dart';
import 'package:wani_reminder/models/wk_response_data.dart';
import 'package:wani_reminder/models/wk_user_data.dart';

const String _baseUrl = 'https://api.wanikani.com/v2';

class RestClient {
  final HeaderProvider headerProvider;
  final Dio dio;

  RestClient(this.headerProvider, this.dio);

  Future<WkResponseData?> summary() async {
    final headers = await headerProvider.headers;

    if (headers != null) {
      final result = await dio.get(
        '$_baseUrl/summary',
        options: Options(
          headers: headers,
        ),
      );

      if (result.data != null) {
        if (result.data['data'] != null) {
          return WkResponseData.fromMap(result.data['data']);
        }
      }
    }

    return null;
  }

  Future<WkUserData?> user() async {
    final headers = await headerProvider.headers;

    if (headers != null) {
      final result = await dio.get(
        '$_baseUrl/user',
        options: Options(
          headers: headers,
        ),
      );

      if (result.data != null) {
        if (result.data['data'] != null) {
          return WkUserData.fromMap(result.data['data']);
        }
      }
    }
    return null;
  }
}
