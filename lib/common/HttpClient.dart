/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-07 18:35:30
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-12 09:16:56
 * @FilePath: /weatherreader/lib/Common/HttpClient.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:dio/dio.dart';

class HttpClient {
  late Dio dio;
  static HttpClient instance = HttpClient._internal();

  ///工厂构造函数与普通构造函数的区别在于，
  ///工厂构造函数可以自定义实例的创建过程，并根据需要返回一个新的对象或现有的对象。
  factory HttpClient() {
    return instance;
  }

  HttpClient._internal() {
    print('构造函数。。。。。。。。。。。。。。');
    dio = Dio();
    // dio.options.baseUrl = 'https://devapi.qweather.com';
    dio.options.connectTimeout = const Duration(milliseconds: 5000);
    dio.options.sendTimeout = const Duration(milliseconds: 10000);
    dio.interceptors.add(LogInterceptor(responseBody: true)); // 输出响应内容体
  }

  String getUrl(String url) {
    if (url.contains('/v2/')) {
      url = 'https://geoapi.qweather.com' + url;
    } else {
      url = 'https://devapi.qweather.com' + url;
    }
    return url;
  }

  /// get请求
  Future<Response?> get(String url, {Map<String, dynamic>? map}) async {
    try {
      var result = await dio.get(getUrl(url), queryParameters: map);
      return result;
    } catch (e) {
      print('HttManager get e $e }');
      return null;
    }
  }

  ///post请求
  Future<Response?> post(String url, Map<String, dynamic>? map) async {
    try {
      var result = await dio.post(getUrl(url), queryParameters: map);
      return result;
    } catch (e) {
      print('HttManager post e $e }');
      return null;
    }
  }

  ///上传文件 fileName 文件名字 fileDir 文件路径  formData 自定义参数
  Future<Response?> uploadFile(String url, String? fileName, String fileDir,
      Map<String, dynamic> formData) async {
    try {
      formData['file'] =
          await MultipartFile.fromFile(fileDir, filename: fileName);
      var response = await dio.post(getUrl(url), data: formData);
      print(response.data);
      return response;
    } catch (e) {
      return null;
    }
  }
}
