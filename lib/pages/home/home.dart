/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-07 19:22:57
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-12 21:41:26
 * @FilePath: /weatherreader/lib/Pages/Home/home.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:weatherreader/Model/city_info.dart';
import 'package:weatherreader/common/HttpClient.dart';
import 'package:weatherreader/Model/weather_fore.dart';
import 'package:weatherreader/Model/weather_indice.dart';
import 'package:weatherreader/Model/weather_now.dart';
import 'package:weatherreader/common/MyData.dart';

const apiKey = '91fd099a5e844ae79f41d92b274f5ae6';
String location = '101010100';

GlobalKey<_HomePageState> homePageKey = GlobalKey();

class HomePage extends StatefulWidget {
  final String cityCode;
  final Function(String) onCityPosition;

  const HomePage(
      {super.key, required this.onCityPosition, required this.cityCode});

  @override
  _HomePageState createState() => _HomePageState();
  // @override
  // State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int month = 0;
  int day = 0;
  String weekDay = '';
  WeatherNow? nowData;
  WeatherFore? foreData;
  WeatherIndice? indiceData;
  String city = '';
  List indications = ['运动指数', '穿衣指数', '紫外线指数', '旅游指数', '舒适度指数', '感冒指数'];

  @override
  void initState() {
    super.initState();

    getDate();
    getCityData();
  }

  void getWeatherData() {
    getIndiceData();
    getForecastData();
  }

  //获取日期 周几
  void getDate() {
    DateTime now = DateTime.now(); // 创建一个DateTime对象，表示当前时间

    month = now.month; // 获取当前月份（范围为1-12）
    day = now.day; // 获取当前日期（范围为1-31）
    // 获取今天是星期几
    List<String> weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    weekDay = weekdays[now.weekday - 1];
    setState(() {});
  }

  void getPositionCity() async {
    Position? position = await _getPosition();
    print(' ---------------------- position ---------------------}');
    if (position != null) {
      getCityCodeFromLocation(position.latitude, position.longitude);
    }
  }

  void getCityCodeFromLocation(double lat, double log) async {
    String loc = '${log.toStringAsFixed(2)},${lat.toStringAsFixed(2)}';
    print('loc--- $loc');

    Response? res = await HttpClient().get('/v2/city/lookup',
        map: <String, dynamic>{'location': loc, 'key': apiKey});
    if (res != null) {
      CityInfo cityInfo = CityInfo.fromJson(res.data);
      CityLocation city = cityInfo.location![0];
      print('----city 定位 name = ${city.name}');
      widget.onCityPosition(city.name!);
      location = city.id!;
      getNowData();
      getWeatherData();
    }
  }

  //更新城市 天气数据
  void updateCityCode(String cityCode) {
    print('---updateCityCode = $cityCode');
    location = cityCode;
    getNowData();
    getWeatherData();
  }

  //获取本地city数据
  void getCityData() {
    Future<List<Map<String, dynamic>>?> data = MyData().fetchData();
    data.then((citys) {
      if (citys!.length != 0) {
        Map<String, dynamic> city = citys[0];
        print('---city = $city');
        widget.onCityPosition(city['city_name']!);
        location = city['city_code'];
        getNowData();
        getWeatherData();
      } else {
        getPositionCity();
      }
    });
  }

  //实时天气
  void getNowData() async {
    Response? res = await HttpClient().get('/v7/weather/now/',
        map: <String, dynamic>{'location': location, 'key': apiKey});
    if (res != null) {
      setState(() {
        nowData = WeatherNow.fromJson(res.data);
      });
    }
  }

  // 预报天气 7天
  void getForecastData() async {
    Response? res = await HttpClient().get('/v7/weather/7d',
        map: <String, dynamic>{'location': location, 'key': apiKey});
    if (res != null) {
      setState(() {
        foreData = WeatherFore.fromJson(res.data);
      });
    }
  }

  // 生活指数 1天
  void getIndiceData() async {
    Response? res = await HttpClient().get('/v7/indices/1d',
        map: <String, dynamic>{
          'location': location,
          'key': apiKey,
          'type': '1,3,5,6,8,9'
        });
    if (res != null) {
      setState(() {
        indiceData = WeatherIndice.fromJson(res.data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(238, 255, 252, 1),
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.bottom, // 忽略底部安全区

        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  child: Container(
                      height: 240,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/icon_card.png'),
                          fit: BoxFit.fill,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(62, 124, 120, .1),
                              offset: Offset(0, 1),
                              blurRadius: 40),
                          BoxShadow(
                              color: Color.fromRGBO(62, 124, 120, .4),
                              offset: Offset(0, 20),
                              blurRadius: 40),
                        ],
                      ),
                      child: nowData?.now != null
                          ? Stack(
                              children: <Widget>[
                                Positioned(
                                    left: 55,
                                    width: 135,
                                    height: 135,
                                    child: SvgPicture.asset(
                                      'assets/QWeather/${nowData!.now!.icon}.svg',
                                      colorFilter: const ColorFilter.mode(
                                          Color.fromRGBO(255, 195, 73, 1),
                                          BlendMode.srcIn),
                                    )),
                                Positioned(
                                  top: 65,
                                  right: 20,
                                  child: Text(
                                    '${nowData?.now!.temp}°',
                                    style: const TextStyle(
                                        fontSize: 85,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Positioned(
                                  left: 30,
                                  top: 145,
                                  child: Text(
                                    '${nowData?.now!.text}',
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Positioned(
                                  left: 30,
                                  top: 178,
                                  child: Text(
                                    '$weekDay  $month月$day日',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          : const Text('')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
                child: Container(
                  height: 185,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(33)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(191, 230, 222, 1),
                            offset: Offset(0, 30),
                            blurRadius: 40),
                      ]),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: const Center(
                          child: Text(
                            '生活指数',
                            style: TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 18),
                          ),
                        ),
                      ),
                      Container(
                          height: 120,
                          child: indiceData?.daily != null
                              ? AlignedGridView.count(
                                  physics:
                                      const NeverScrollableScrollPhysics(), // 禁止滚动
                                  padding: const EdgeInsets.only(top: 0),
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 22,
                                  crossAxisSpacing: 4,
                                  itemCount: indiceData?.daily!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    IDaily daily = indiceData!.daily![index];
                                    return Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            '${daily.name}',
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    155, 167, 199, 1)),
                                          ),
                                          Text(
                                            '${daily.category}',
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    51, 51, 51, 1)),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : const Text('')),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
                child: Container(
                    child: foreData?.daily != null
                        ? Row(
                            children: [
                              _ForeViewItem(daily: foreData!.daily![0]),
                              const Spacer(),
                              _ForeViewItem(daily: foreData!.daily![1]),
                              const Spacer(),
                              _ForeViewItem(daily: foreData!.daily![2]),
                              const Spacer(),
                              _ForeViewItem(daily: foreData!.daily![3]),
                            ],
                          )
                        : const Text('')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ForeViewItem extends StatelessWidget {
  final Daily daily;
  const _ForeViewItem({Key? key, required this.daily}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 160,
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(102, 224, 209, 1),
              Color.fromRGBO(245, 245, 245, 1)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Text(
              '${daily?.textDay}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Text(
              '${daily.fxDate!.substring(5)}',
              style: const TextStyle(
                color: Color.fromRGBO(208, 243, 255, 1),
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/QWeather/${daily.iconDay}.svg',
              width: 35,
              height: 35,
              colorFilter: const ColorFilter.mode(
                Color.fromRGBO(255, 195, 73, 1),
                BlendMode.srcIn,
              ),
            ),
            const Spacer(),
            Container(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 195, 73, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('${daily.uvIndex}'),
            ),
          ],
        ),
      ),
    );
  }
}

// 定义一个Map，将英文星期几转换成数字形式
final Map<String, int> weekDays = <String, int>{
  "Mon": 1,
  "Tue": 2,
  "Wed": 3,
  "Thu": 4,
  "Fri": 5,
  "Sat": 6,
  "Sun": 7,
};

/// 位置服务
Future<Position?> _getPosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  double longitude = 0;
  double latitude = 0;
  try {
    /// 手机GPS服务是否已启用。
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //定位服务未启用，要求用户启用定位服务
      var res = await Geolocator.openLocationSettings();
      if (!res) {
        /// 被拒绝
        print('定位服务未启用---被拒绝');
        return null;
      }
    }

    /// 是否允许app访问地理位置
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      /// 之前访问设备位置的权限被拒绝，重新申请权限
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        /// 再次被拒绝。根据Android指南，你的应用现在应该显示一个解释性UI。
        print('定位服务未启用---再次被拒绝');
        return null;
      }
    } else if (permission == LocationPermission.deniedForever) {
      /// 之前权限被永久拒绝，打开app权限设置页面
      await Geolocator.openAppSettings();
      print('定位服务未启用---永久拒绝');
      return null;
    }

    /// 允许访问地理位置，获取地理位置
    Position position = await Geolocator.getCurrentPosition();
    longitude = position.longitude;
    latitude = position.latitude;
    print('position = $position');
    return position;
  } catch (e) {
    print('position error-------$e');
  }
}
