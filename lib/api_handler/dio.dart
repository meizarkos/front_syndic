import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

final cacheOptions = CacheOptions(
    store: MemCacheStore(), // Use a suitable store like Hive or in-memory
    policy: CachePolicy.request,
    maxStale: const Duration(hours: 1),
    hitCacheOnErrorExcept: [401, 403],
);

class DioService {
    DioService._privateConstructor();

    static final DioService instance = DioService._privateConstructor();

    final Dio dio = Dio(BaseOptions(
        //baseUrl: 'https://helpother.fr/',
        baseUrl: 'http://10.0.2.2:3000/',
    ))..interceptors.add(DioCacheInterceptor(options: cacheOptions));
}