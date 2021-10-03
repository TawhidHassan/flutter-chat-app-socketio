import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final bool sentByme;
  final String mssage;
  final String time;

  const MessageItem({Key? key, required this.sentByme, required this.mssage, required this.time}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      color: sentByme? Colors.lightBlue:Colors.orangeAccent,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(mssage,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 24),),
          Text(time,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14),),
        ],
      )
    );
  }
}
