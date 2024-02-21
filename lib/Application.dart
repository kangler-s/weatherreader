/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-07 19:12:59
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-12 21:24:58
 * @FilePath: /weatherreader/lib/Application.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:weatherreader/common/appPages.dart';
import 'package:weatherreader/common/appRouters.dart';
import 'package:weatherreader/pages/Drawer.dart';
import 'package:weatherreader/pages/home/home.dart';
import 'package:get/get.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  String title = '';
  String cityCode = '';

  @override
  void initState() {
    super.initState();
  }

  void updateCityCode(String newCityCode) {
    setState(() {
      cityCode = newCityCode;
    });
    // 在更新 cityCode 后直接调用 HomePage 中的 getWeatherData 方法
    // 这里假设 HomePage 是通过 GlobalKey 获取的
    final homePageState = homePageKey.currentState;
    homePageState?.updateCityCode(newCityCode);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.INITIAL,
      getPages: AppPages.pages,
      home: Scaffold(
        body: SliderDrawer(
          appBar: SliderAppBar(
            appBarPadding: const EdgeInsets.only(top: 50),
            appBarHeight: 115,
            appBarColor: const Color.fromRGBO(238, 255, 252, 1),
            title: Text('$title',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          ),
          key: _sliderDrawerKey,
          sliderOpenSize: 179,
          slider: DrawerPage(
            onItemClick: (Map<String, dynamic> city) {
              _sliderDrawerKey.currentState!.closeSlider();
              if (city['city_code'] != 0) {
                print('-------city_code ${city['city_code']}');
                updateCityCode(city['city_code']);
                setState(() {
                  title = city['city_name'];
                  cityCode = city['city_code'];
                });
              }
            },
          ),
          child: HomePage(
            key: homePageKey,
            cityCode: cityCode,
            onCityPosition: (cityName) {
              setState(() {
                title = cityName;
              });
            },
          ),
        ),
      ),
    );
  }
}
