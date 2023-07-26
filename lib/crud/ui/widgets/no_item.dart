import 'package:flutter/material.dart';

class NoItem extends StatefulWidget {
  @override
  _NoItemState createState() => _NoItemState();
}

class _NoItemState extends State<NoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('اطلاعات تماسی وجود نداره. ',style: TextStyle(color: Colors.blue),),
          Row(
            children: [
              Text(' برای افزودن اطلاعات تماس '),
              Icon(Icons.add),
              Text(' کلیک کن. '),
            ],
          ),
        ],
      ),
    );
  }
}
