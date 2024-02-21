/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-09 12:37:37
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-12 21:45:16
 * @FilePath: /weatherreader/lib/Pages/Citys/Citys.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:weatherreader/Model/city_item.dart';
import 'package:weatherreader/common/kcolors.dart';
import 'package:weatherreader/pages/citys/searchBar.dart';

class CitysPage extends StatefulWidget {
  const CitysPage({super.key});

  @override
  State<CitysPage> createState() => _CitysPageState();
}

class _CitysPageState extends State<CitysPage> {
  List<CityItem> cityList = [];
  List<CityItem> searchList = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    loadTestJson();
  }

  //读取城市列表数据
  void loadTestJson() async {
    String jsonData = await rootBundle.loadString('assets/data/citys.json');
    List<dynamic> data = jsonDecode(jsonData);
    // 按照拼音排序
    data.sort((a, b) {
      String nameA = a['Location_Name_EN'].toString().toLowerCase();
      String nameB = b['Location_Name_EN'].toString().toLowerCase();
      return nameA.compareTo(nameB);
    });
    setState(() {
      cityList = data.map((item) => CityItem.fromJson(item)).toList();
    });
  }

  void onSearchPressed(String text) {
    isSearching = false;
    if (text != null) {
      isSearching = true;
    }
    searchList = [];
    for (CityItem city in cityList) {
      if (city.locationNameZh!.contains(text)) {
        searchList.add(city);
      }
    }
    setState(() {});
  }

  void onSearchTextChanged(String text) {
    print('text = $text');
  }

  void onSearchTCancle() {
    isSearching = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('城市列表'),
      ),
      body: Column(
        children: [
          SearchBox(
            onTextChanged: onSearchTextChanged,
            onSearchPressed: onSearchPressed,
            onSearchCancle: onSearchTCancle,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: isSearching ? searchList.length : cityList.length,
                itemBuilder: (BuildContext context, int index) {
                  CityItem city =
                      isSearching ? searchList[index] : cityList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.back(result: {
                        'name': city.locationNameZh,
                        'code': city.locationId
                      });
                    },
                    child: ListTile(
                      title: Text(
                        city.locationNameZh!,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.normal),
                      ),
                      subtitle: Text(
                        city.adm1NameZh!,
                        style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black45),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
