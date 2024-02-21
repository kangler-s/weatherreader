/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-12 15:38:59
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-12 21:46:17
 * @FilePath: /weatherreader/lib/pages/citys/searchBar.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final Function(String) onTextChanged;
  final Function(String) onSearchPressed;
  final Function() onSearchCancle;
  SearchBox(
      {required this.onTextChanged,
      required this.onSearchPressed,
      required this.onSearchCancle});

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  bool showCancelButton = false;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[200],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText: '请输入搜索的城市名',
                        border: InputBorder.none,
                      ),
                      onChanged: widget.onTextChanged,
                      onSubmitted: (String value) {
                        widget.onSearchPressed(value);
                      },
                      onTap: () {
                        setState(() {
                          showCancelButton = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          showCancelButton
              ? IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    _textEditingController.clear(); // 清空输入框内容
                    FocusScope.of(context).unfocus(); // 隐藏键盘
                    widget.onSearchCancle;
                    setState(() {
                      showCancelButton = false;
                    });
                  },
                )
              : const SizedBox(width: 0),
        ],
      ),
    );
  }
}
