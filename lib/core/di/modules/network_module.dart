import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:dio_retry_plus/dio_retry_plus.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// A service class that handles HTTP requests using Dio with caching and error handling
class DioService {
  late final Dio _dio;
  late final CacheOptions _cacheOptions;
  final Connectivity _connectivity = Connectivity();

  // Singleton pattern
  static final DioService _instance = DioService._internal();

  factory DioService() => _instance;

  DioService._internal() {
    init(); // Call init method here
  }

  /// Initialize the DioService
  Future<void> init() async {
    _dio = Dio(_baseOptions);
    await _initializeCache();
    _setupInterceptors();
  }

  /// Base options for Dio
  BaseOptions get _baseOptions => BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ApiConstants.apiKey}',
        },
        validateStatus: (status) => status != null && status < 500,
      );

  /// Initialize cache configuration
  Future<void> _initializeCache() async {
    final directory = await getApplicationDocumentsDirectory();
    final cacheStore = HiveCacheStore(
      directory.path,
      hiveBoxName: 'dio_cache',
    );

    _cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.refreshForceCache,
      hitCacheOnErrorExcept: [401, 403, 404],
      priority: CachePriority.high,
      maxStale: const Duration(days: 7),
      keyBuilder: (request) =>
          request.uri.toString() + (request.data?.toString() ?? ''),
    );
  }

  /// Set up all interceptors
  void _setupInterceptors() {
    // Cache interceptor
    _dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));

    // Retry interceptor
    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        logPrint: print,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
        // retryableExtraStatuses: {404},
        toNoInternetPageNavigator: () async {},
      ),
    );

    // Error handling interceptor
    _dio.interceptors.add(_createErrorInterceptor());

    // Request/Response logging interceptor (only in debug mode)
    assert(() {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: true,
      ));
      return true;
    }());
  }

  /// Create error handling interceptor
  Interceptor _createErrorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) async {
        if (!await _hasInternetConnection()) {
          handler.reject(DioException(
              requestOptions: error.requestOptions,
              error: const ServerFailure('No internet connection')));
          return;
        }

        final response = error.response;
        if (response == null) {
          handler.reject(DioException(
              requestOptions: error.requestOptions,
              error: const ServerFailure('Server connection failed')));
          return;
        }

        switch (response.statusCode) {
          case 401:
            handler.reject(DioException(
                requestOptions: error.requestOptions,
                error: const ServerFailure(
                    'Unauthorized: API key is invalid or expired')));
            break;
          case 404:
            handler.reject(DioException(
                requestOptions: error.requestOptions,
                error: const ServerFailure('Resource not found')));
            break;
          case 422:
            handler.reject(DioException(
                requestOptions: error.requestOptions,
                error: ServerFailure(
                    'Validation failed: ${response.data['message']}')));
            break;
          case 429:
            handler.reject(DioException(
                requestOptions: error.requestOptions,
                error: const ServerFailure(
                    'Rate limit exceeded. Please try again later')));
            break;
          case 500:
            handler.reject(DioException(
                requestOptions: error.requestOptions,
                error: const ServerFailure('Server error occurred')));
            break;
          default:
            handler.reject(DioException(
                requestOptions: error.requestOptions,
                error: ServerFailure(
                    'Request failed: ${response.statusMessage}')));
        }
      },
    );
  }

  /// Check for internet connectivity
  Future<bool> _hasInternetConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  /// Clear cache
  Future<void> clearCache() async {
    await _cacheOptions.store?.clean();
  }

  /// Cancel all requests
  void cancelAllRequests([String? reason]) {
    _dio.close(force: true);
  }

  /// Get request with optional caching
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    CacheOptions? cacheOptions,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: _mergeCacheOptions(options, cacheOptions),
      cancelToken: cancelToken,
    );
  }

  /// Post request with optional caching
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CacheOptions? cacheOptions,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _mergeCacheOptions(options, cacheOptions),
      cancelToken: cancelToken,
    );
  }

  Options _mergeCacheOptions(Options? options, CacheOptions? cacheOptions) {
    if (cacheOptions != null) {
      final requestOptions = cacheOptions.toOptions();
      return Options(
        method: requestOptions.method,
        sendTimeout: requestOptions.sendTimeout,
        receiveTimeout: requestOptions.receiveTimeout,
        headers: {..._dio.options.headers, ...?requestOptions.headers},
        responseType: requestOptions.responseType,
        contentType: requestOptions.contentType,
        validateStatus: requestOptions.validateStatus,
        receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
        followRedirects: requestOptions.followRedirects,
        maxRedirects: requestOptions.maxRedirects,
        extra: {..._dio.options.extra, ...?requestOptions.extra},
      );
    }
    return options ?? Options();
  }

  /// Get Dio instance
  Dio get dio => _dio;
}
