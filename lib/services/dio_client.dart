import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:kids_app/ui/router/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:kids_app/ui/router/app_router.gr.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:6000/api',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 10),
    ));

    dio.interceptors.add(AuthInterceptor(dio));
  }
}

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      bool tokenRefreshed = await _refreshToken();

      if (tokenRefreshed) {
        final requestOptions = err.requestOptions;
        final prefs = await SharedPreferences.getInstance();
        final newAccessToken = prefs.getString('access_token');

        requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final retryResponse = await dio.fetch(requestOptions);
        return handler.resolve(retryResponse);
      } else {
        _redirectToLogin();
      }
    }
    return handler.next(err);
  }

  Future<bool> _refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');

    if (refreshToken == null) {
      return false;
    }

    try {
      final response = await dio.post('/refresh-token', data: {
        'refresh_token': refreshToken,
      });

      final newAccessToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];

      await prefs.setString('access_token', newAccessToken);
      await prefs.setString('refresh_token', newRefreshToken);

      return true;
    } catch (e) {
      return false;
    }
  }

  void _redirectToLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');

    WidgetsBinding.instance.addPostFrameCallback((_) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      context.router.replaceAll([const Login()]);
    } else {
      debugPrint("Navigator context is still null!");
    }
  });
  }
}

final dioClient = DioClient();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
