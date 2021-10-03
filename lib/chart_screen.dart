import 'package:flutter/material.dart';
import 'package:flutter_chat_app_socket_io/controller/chat_controller.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'messageitem.dart';
import 'model/message.dart';


class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
   TextEditingController magInputController=TextEditingController();
   late IO.Socket socket;
    ChatController chatController=ChatController();
   @override
  void initState() {
    socket=IO.io("http://localhost:4000", IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .build());
    socket.connect();
    setUpSocketListiner();
    super.initState();
  }
  void setUpSocketListiner(){
        socket.on('message-receive', (data){
          print(data);
          chatController.chatmessage.add(Message.fromMap(data));
        });
   }
   void sendMessage(String text) {
     var messageJson={
       "message":text,
       "sendByMe":socket.id
     };
     socket.emit('message',messageJson);
     chatController.chatmessage.add(Message.fromMap(messageJson));
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 12,
                child: Obx(
                  ()=> ListView.builder(
                    itemCount: chatController.chatmessage.length,
                      itemBuilder: (context,index){
                      var currentItem=chatController.chatmessage[index];
                      print(currentItem.sendByMe==socket.id);
                        return MessageItem(sentByme:currentItem.sendByMe==socket.id,mssage:currentItem.message,time: "1:22",);
                      }
                  ),
                )
            ),
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    controller: magInputController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      suffixIcon: Container(
                        margin: EdgeInsets.all(8),
                        color: Colors.green,
                        child: IconButton(
                          onPressed: (){
                              sendMessage(magInputController.text);
                              magInputController.text="";
                          },
                          icon: Icon(Icons.send,color: Colors.white,),
                        ),
                      )
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }


}
