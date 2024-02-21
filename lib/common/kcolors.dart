/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-12 10:56:07
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-12 10:56:31
 * @FilePath: /weatherreader/lib/common/kcolors.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:math';
import 'dart:ui';

Color getRandomColor() {
  Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256), // 生成0到255之间的随机红色值
    random.nextInt(256), // 生成0到255之间的随机绿色值
    random.nextInt(256), // 生成0到255之间的随机蓝色值
    1.0, // 不透明度为1
  );
}
