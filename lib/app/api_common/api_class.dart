import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import '../commons/all.dart';
import '../commons/constants.dart';
import '../commons/get_storage_data.dart';
import '../commons/utils.dart';
import '../routes/app_pages.dart';
import 'loading.dart';

class HttpUtil {
  factory HttpUtil(String token, bool isLoading, BuildContext context) =>
      _instance(token, isLoading, context);

  static HttpUtil _instance(token, isLoading, context) =>
      HttpUtil._internal(token: token, isLoading: isLoading, context: context);

  late Dio dio;
  CancelToken cancelToken = CancelToken();
  String apiUrl = Constants.baseUrl;
  Utils utils = Utils();
  BuildContext? context;
  static bool _isSessionExpiredHandled = false;

  HttpUtil._internal(
      {String? token, bool? isLoading, required BuildContext context}) {
    BaseOptions options = BaseOptions(
      baseUrl: apiUrl,
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      // connectTimeout: const Duration(milliseconds: 50000),
      // receiveTimeout: const Duration(milliseconds: 50000),
      headers: {
        'accept': "*/*",
        'Authorization': "Bearer ${token}",
      },
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );

    dio = Dio(options);
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (isLoading!) {
          Loading.show();
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (isLoading!) {
          Loading.dismiss();
        }
        return handler.next(response);
      },
      onError: (DioError e, handler) async {
        if (isLoading!) {
          Loading.dismiss();
        }

        if (e.response?.statusCode == 401&& !_isSessionExpiredHandled) {
          _isSessionExpiredHandled = true; // mark as handled
          GetStorageData.removeData(GetStorageData.token);
          await GetStorageData.removeData(GetStorageData.token);
          await GetStorageData.removeData(GetStorageData.role);

          await GetStorageData.saveBoolean(GetStorageData.isCustomer, false);
          await GetStorageData.saveBoolean(GetStorageData.isEmployee, false);
          await GetStorageData.saveBoolean(GetStorageData.isAdmin, false);
          await GetStorageData.saveBoolean(GetStorageData.demoCustomer, false);

          utils.showSnackBar(
            message: "Session expired, please login again!",
            context: context!,
          );
          Future.delayed(Duration(milliseconds: 500), () {
            Get.offAllNamed(Routes.LOGIN);
            _isSessionExpiredHandled = false;
          });
        }

        onError(createErrorEntity(e), context);
        return handler.next(e);
      },
    ));
  }

  ///  On Error....
  void onError(ErrorEntity eInfo, BuildContext context) {
    printError(
        "error.code -> ${eInfo.code}, error.message -> ${eInfo.message}");
    if (eInfo.message.isNotEmpty) {
      utils.showSnackBar(message: eInfo.message, context: context);
    }
  }

  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return ErrorEntity(
            code: -1, message: "Request to server was cancelled");
      case DioErrorType.connectionTimeout:
        return ErrorEntity(code: -2, message: "Connection timeout with server");
      case DioErrorType.sendTimeout:
        return ErrorEntity(
            code: -3, message: "Send timeout in connection with server");
      case DioErrorType.receiveTimeout:
        return ErrorEntity(
            code: -4, message: "Receive timeout in connection with server");
      case DioErrorType.badResponse:
        {
          try {
            int errCode =
                error.response != null ? error.response!.statusCode! : 00;
            switch (errCode) {
              case 400:
                return ErrorEntity(
                    code: errCode, message: "Request syntax error");
              case 401:
                // utils.showSnackBar(
                //     context: Get.context!, message: "${error.response!.data}");
                return ErrorEntity(
                    code: errCode, message: "${error.response!.data}");
              case 403:
                return ErrorEntity(
                    code: errCode, message: "Server refuses to execute");
              case 404:
                return ErrorEntity(
                    code: errCode, message: "Can not reach server");
              case 405:
                return ErrorEntity(
                    code: errCode, message: "Request method is forbidden");
              case 500:
                return ErrorEntity(
                    code: errCode, message: "Internal server error");
              case 502:
                return ErrorEntity(code: errCode, message: "Invalid request");
              case 503:
                return ErrorEntity(code: errCode, message: "Server hangs");
              case 505:
                return ErrorEntity(
                    code: errCode,
                    message: "HTTP protocol requests are not supported");
              default:
                return ErrorEntity(
                    code: errCode,
                    message:
                        error.response != null ? error.response!.data! : "");
            }
          } on Exception catch (_) {
            return ErrorEntity(code: 00, message: "Unknown mistake");
          }
        }
      case DioErrorType.unknown:
        if (error.message!.contains("SocketException")) {
          return ErrorEntity(
              code: -5,
              message:
                  "Your internet is not available, please try again later");
        } else if (error.message!
            .contains("Software caused connection abort")) {
          return ErrorEntity(
              code: -6,
              message:
                  "Your internet is not available, please try again later");
        }
        return ErrorEntity(code: -7, message: "Oops something went wrong");
      default:
        return ErrorEntity(code: -8, message: "Oops something went wrong");
    }
  }

  void cancelRequests() {
    cancelToken.cancel("cancelled");
  }

  /// restful get
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool refresh = false,
    bool noCache = true,
    bool list = false,
    String cacheKey = '',
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra!.addAll({
      "refresh": refresh,
      "noCache": noCache,
      "list": list,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });

    var response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post
  Future post(
    String path, {
    String? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post Raw
  Future postRaw(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.post(
      path,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful put
  Future put(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful delete
  Future delete(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful patch
  Future patch(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post form
  Future postForm(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post Stream
  Future postStream(
    String path, {
    dynamic data,
    int dataLength = 0,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    requestOptions.headers!.addAll({
      Headers.contentLengthHeader: dataLength.toString(),
    });
    var response = await dio.post(
      path,
      data: Stream.fromIterable(data.map((e) => [e])),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") return "Exception";
    return "Exception: code $code, $message";
  }
}
