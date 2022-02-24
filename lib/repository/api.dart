// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import '../common/app_constant.dart';
import '../service/locator.dart';
import 'api_exception.dart';
import 'error_model.dart';

class ApiRepository {
  String? get token => locator<EnvironmentModel>().token;

  final _dio = Dio(
    BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 20000,
        receiveTimeout: 10000,
        sendTimeout: 10000,
        queryParameters: {
          //"apiVersion": "v1",
        }),
  );

  // ignore: missing_return
  postRequest({
    body,
    Map<String, dynamic>? queryParams,
    required String url,
    bool hasErrorData = false,
    bool auth = false,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        queryParameters: queryParams,
        data: body,
        options: Options(
          headers: _setHeaders(
            auth: auth,
          ),
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.json,
        ),
      );
      return _responseCodeSerializer(response);
    } on DioError catch (e) {
      throw hasErrorData ? e : AppApiException.fromDioError(e);
    } catch (e) {
      throw Exception("Unknown Error occured. Please try again.");
    }
  }

  getRequest({
    Map<String, dynamic>? queryParams,
    required String url,
    bool auth = true,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: _setHeaders(
            auth: auth,
          ),
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.json,
        ),
      );
      return _responseCodeSerializer(response);
    } on DioError catch (e) {
      throw AppApiException.fromDioError(e);
    } catch (e) {
      throw Exception("Unknown Error occured. Please try again.");
    }
  }

  _responseCodeSerializer(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      return response;
    } else {
      try {
        return ErrorModel.fromRawJson(response.data);
      } catch (e) {
        throw Exception("Unknown error occured. Please try again.");
      }
    }
  }

  Map<String, dynamic> _setHeaders({
    required bool auth,
  }) {
    Map<String, dynamic> header = {};
    header['Accept'] = 'application/json';

    if (auth) {
      header["Authorization"] = "Bearer $token";
    }
    return header;
  }
}
