/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-08 20:01:41
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-13 10:31:09
 * @FilePath: /weatherreader/lib/Pages/Drawer.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/route_manager.dart';
import 'package:weatherreader/common/MyData.dart';
import 'package:get/get.dart';
import 'package:weatherreader/common/appRouters.dart';
import 'package:weatherreader/common/kcolors.dart';
import 'package:weatherreader/pages/citys/citys.dart';

class DrawerPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onItemClick;
  const DrawerPage({super.key, required this.onItemClick});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool showAdd = true;
  List<Map<String, dynamic>>? citys;

  @override
  void initState() {
    super.initState();
    getCityData();
  }

  // 保存本地 city数据
  void saveCity(city) async {
    if (city != null) {
      MyData myData = MyData();
      //查询城市 重复不添加
      bool isHave = await MyData().searchCityIsHave(city['name']);
      if (!isHave) {
        myData.insertData(city['name'], city['code']);
        getCityData();
      }
      print('-------city_code save = $city');
      widget.onItemClick
          .call({'city_name': city['name'], 'city_code': city['code']});
    }
  }

  //获取本地city数据
  void getCityData() async {
    List<Map<String, dynamic>>? data = await MyData().fetchData();
    if (data!.isNotEmpty) {
      print('citys = $citys');
      setState(() {
        citys = data;
      });
    }
  }

  //删除城市
  void deleteCity(String cityName) async {
    await MyData().deleteData('city_name', cityName);
    getCityData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(224, 240, 254, 1),
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 65,
                backgroundColor: const Color.fromRGBO(69, 179, 219, 0.4),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: Image.network(
                          'https://img0.baidu.com/it/u=2677252617,1682860485&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500')
                      .image,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 46,
                width: 120,
                child: MaterialButton(
                  onPressed: () {
                    widget.onItemClick
                        .call({'city_name': 'close', 'city_code': 0});
                    Get.toNamed(Routes.CITYS)!.then((value) {
                      saveCity(value);
                    });
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // 设置圆角半径
                  ),
                  child: const Text(
                    '添加城市',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: citys != null && citys!.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        itemCount: citys!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map city = citys![index];
                          return GestureDetector(
                            onTap: () {
                              widget.onItemClick.call({
                                'city_name': city['city_name'],
                                'city_code': city['city_code']
                              });
                            },
                            child: Container(
                              child: Slidable(
                                endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        flex: 2,
                                        onPressed: (context) {
                                          deleteCity(city['city_name']);
                                        },
                                        backgroundColor: const Color.fromARGB(
                                            255, 234, 78, 78),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: '删除',
                                      )
                                    ]),
                                child: ListTile(
                                  title: Text(
                                    city['city_name'],
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Text(''),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  // padding: EdgeInsets.only(bottom: 25),
                  child: const Text(
                    '天气服务由和风天气驱动',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
