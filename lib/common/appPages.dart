import 'package:get/get.dart';
import 'package:weatherreader/Pages/Citys/Citys.dart';
import './appRouters.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.CITYS,
      page: () => CitysPage(),
    ),
  ];
}
