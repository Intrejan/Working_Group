import 'package:flutter/material.dart';

class Message {
  String text;
  bool isSender;
  Message(this.text, this.isSender,);
}

class Chatter{
  String userName;
  String imageUrl;
  Chatter(this.userName,this.imageUrl);
}

class Chat extends StatefulWidget{
  @override
  _Chat createState()=>_Chat();
}

class _Chat extends State<Chat>{
  final List<Message> _messages = <Message>[];

  ///假数据
  Message message2 = new Message("Nice to meet you !",false);

  final TextEditingController _textController = new TextEditingController();

  @override
  void initState() {
    _messages.add(message2);
    super.initState();
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    Message message = new Message(
      text,true
    );

    setState((){
      _messages.insert(0, message);

    });
  }

  Widget _buildTextComposer(){
    return new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
            children: <Widget> [
              new Flexible(
                  child: new TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    decoration: new InputDecoration.collapsed(hintText: '发送消息'),
                  )
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(Icons.send,color: Colors.blue,),
                    onPressed: () => _handleSubmitted(_textController.text)
                ),
              )
            ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    Chatter chatter = ModalRoute.of(context).settings.arguments;
    //print(chatter.userName);

    return new Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
              title: new Text("Chat with "+chatter.userName),
        centerTitle: true,
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
              child:new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (context, int index) => EntryItem(_messages[index],chatter),
                itemCount: _messages.length,
              ),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          )
        ],
      ),
    );
  }
}

class EntryItem extends StatelessWidget{
  final Chatter chatter;
  final Message message;
  const EntryItem(this.message,this.chatter);

  Widget row(){
    if(message.isSender){
      return new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(message.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16
                      ),
                    ),
                  )
                ]
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(left: 12.0,right: 12.0),
            child: new CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.png"),
              radius: 24.0,
            ) ,
          ),
        ],
      );
    }
    else{
      return new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(left: 12.0,right: 12.0),
            child: new CircleAvatar(
              backgroundImage: NetworkImage(chatter.imageUrl),
              radius: 24.0,
            ) ,
          ),
          Flexible(
            child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(message.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16
                      ),
                    ),
                  )
                ]
            ),
          ),

        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: row(),
    );
  }
}

