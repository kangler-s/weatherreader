/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-08 21:36:06
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-12 15:01:01
 * @FilePath: /weatherreader/lib/Common/MyData.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
// 将 sqflite 包添加到 pubspec.yaml 文件中。
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyData {
  // 初始化数据库
  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'my_data.db');
    return openDatabase(path, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE IF NOT EXISTS my_citys (id INTEGER PRIMARY KEY, city_name TEXT, city_code TEXT)');
    }, version: 1);
  }

  Future<void> deleteDatabaseFile() async {
    final path = join(await getDatabasesPath(), 'my_data.db');
    await deleteDatabase(path); // 删除数据库文件
  }

// 将数据插入数据库
  Future<void> insertData(String name, String code) async {
    final db = await initDatabase();
    await db.insert('my_citys', {'city_name': name, 'city_code': code});
  }

// 从数据库中查询数据
  Future<List<Map<String, dynamic>>?> fetchData() async {
    final db = await initDatabase();
    return db.query('my_citys');
  }

  Future<bool> searchCityIsHave(String name) async {
    final db = await initDatabase();
    List<Map> result =
        await db.rawQuery('SELECT * FROM my_citys WHERE city_name = ?', [name]);

    bool isHave = false;
    if (result.isNotEmpty) {
      isHave = true;
      print("数据库中存在该条数据");
    } else {
      print("数据库中不存在该条数据");
    }
    return isHave;
  }

  // 删除数据
  Future<void> deleteData(String columnName, String columnValue) async {
    final db = await initDatabase();
    await db.delete(
      'my_citys',
      where: '$columnName = ?',
      whereArgs: [columnValue],
    );
  }

  Future<void> updateData(String columnName, String columnValue,
      Map<String, dynamic> newData) async {
    final db = await initDatabase();
    await db.update(
      'my_citys',
      newData,
      where: '$columnName = ?',
      whereArgs: [columnValue],
    );
    // 例子
    // await updateData('city_name', 'New York', {'city_code': 'NY'});
  }
}
