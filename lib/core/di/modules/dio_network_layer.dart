// import 'package:dio/dio.dart';
// import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
// import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
// import 'package:movie_app/core/constants/api_constants.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class DioService {
//   late final Dio _dio;
//   late final CacheOptions _cacheOptions;

//   DioService() {
//     // Initialize Dio
//     _dio = Dio(BaseOptions(
//       baseUrl: ApiConstants.baseUrl, // Replace with your API base URL
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//       headers: {
//         'Accept': 'application/json',
//         'Content-Type': 'application/json',
//       },
//     ));

//     _initializeCache();
//   }

//   /// Initialize Hive and set up Dio cache
//   Future<void> _initializeCache() async {
//     final directory = await getApplicationDocumentsDirectory();

//     // Initialize Hive if not already initialized
//     if (!Hive.isBoxOpen('dioCache')) {
//       Hive.init(directory.path);
//       await Hive.openBox('dioCache');
//     }

//     // Setup the cache store
//     final cacheStore = HiveCacheStore(directory.path);

//     // Configure cache options
//     _cacheOptions = CacheOptions(
//       store: cacheStore,
//       policy: CachePolicy.request,
//       hitCacheOnErrorExcept: [], // Ensure network errors fall back to cache
//       priority: CachePriority.normal,
//       maxStale: const Duration(days: 7), // Cache validity duration
//     );

//     // Add cache interceptor to Dio
//     _dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));

//     // Optionally add logging for debugging
//     _dio.interceptors.add(LogInterceptor(
//       requestBody: true,
//       responseBody: true,
//       request: true,
//     ));
//   }

//   /// Get Dio instance
//   Dio get dio => _dio;

//   /// Clear the cache
//   Future<void> clearCache() async {
//     await _cacheOptions.store!.clean();
//   }

//   /// Remove a specific cached response
//   Future<void> removeCache(String key) async {
//     await _cacheOptions.store!.delete(key);
//   }
// }
