import 'package:flutter/material.dart';

class Chat extends StatefulWidget{
  @override
  _Chat createState()=>_Chat();
}
class _Chat extends State<Chat>{
  String userName;

  @override
  Widget build(BuildContext context) {
    userName = ModalRoute.of(context).settings.arguments;
    print(userName);

    return new Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
              title: new Text("Chat with "+userName),
        centerTitle: true,
      ),
    );
  }

}