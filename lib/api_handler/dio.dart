import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

final cacheOptions = CacheOptions(
    store: MemCacheStore(), // Use a suitable store like Hive or in-memory
    policy: CachePolicy.request,
    maxStale: const Duration(minutes: 15),
    hitCacheOnErrorExcept: [404],
);

class DioService {
    DioService._privateConstructor();

    static final DioService instance = DioService._privateConstructor();

    final Dio dio = Dio(BaseOptions(
        //baseUrl: 'https://helpother.fr/',
        //test  = 'http://10.0.2.2:3000/'
        baseUrl: 'http://192.168.1.126:3000/',
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        validateStatus: (status) {
            if(status == null){
                return false;
            }
            if(status < 1000){
                return true;
            }
            return false;
        },
    ))..interceptors.add(DioCacheInterceptor(options: cacheOptions));
}