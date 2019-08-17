import 'package:flutter/material.dart';
import 'package:working_group/chat.dart';

class Message {
  String userName;
  String imageUrl;
  String firstMessage;
  Message(this.userName,this.imageUrl,this.firstMessage);
}

class MessagePage extends StatefulWidget{
  @override
  _MessagePage createState()=>_MessagePage();

}

class _MessagePage extends State<MessagePage>{

  List<Message> _message=[];

  String _model = "0";

  @override
  void initState(){
    ///假数据
    _message.add(Message("ycj","https://static.event.mihoyo.com/bh3_homepage/images/pic/picture/36.jpg","Hi, Nice to Meet you !"));
    _message.add(Message("wlc","https://static.event.mihoyo.com/bh3_homepage/images/pic/picture_src/24.jpg", "Good morning!"));
    _message.add(Message("syl","https://static.event.mihoyo.com/bh3_homepage/images/pic/picture/27.jpg", "Thank you very much!"));
    _message.add(Message("hsl","https://static.event.mihoyo.com/bh3_homepage/images/pic/picture/26.jpg", "I have bougth a very beautiful computer."));
    _message.add(Message("zzh","https://static.event.mihoyo.com/bh3_homepage/images/pic/picture/33.jpg", "Yesterday, I forgot to finish my homework so that I can't go with you."));
    super.initState();
  }

  ///查找的方法
  searchMessage(String key){
    List<Message> _sMessage=[];
      for(Message m in _message){
        if(m.userName.contains(key) || m.firstMessage.contains(key)){
          _sMessage.add(m);
        }
      }
      _message=_sMessage;
      if(key.length==0){
        _message.clear();
        initState();
      }
  }

  @override
  Widget build(BuildContext context) {
    ///分割线
    Widget divider = Divider(color: Colors.black12, height: 1.0, indent: 18,);

    return Scaffold(
      appBar: AppBar(
        title: Text("Message"),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.people,color: Colors.white,),
              onPressed:(){
            Navigator.pushNamed(context, "Partners");
            }
          ),
          new PopupMenuButton(
            icon: Icon(Icons.settings),

            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                value: "2",child: new Text("全部已读",style: new TextStyle(fontSize: 14)),
              ),
              new PopupMenuItem(
                  value:"1",child: new Text("接受但不提醒",style: new TextStyle(fontSize: 14))
              ),
              new PopupMenuItem(
                  value:"0",child: new Text("接受并提醒",style: new TextStyle(fontSize: 14),)
              ),
            ],
            onSelected: (String value){
              setState(() {
                _model = value;
              });
            },
          ),
        ],

      ),
        body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.grey[100]),
              child: Padding(
                padding: EdgeInsets.only(left: 14.0, right: 14.0),
                child: Center(
                  child: TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: 'Search'),
                    onChanged: (str) {
                      searchMessage(str);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView.separated(
                  itemCount: _message.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return divider;
                  },
                  itemBuilder: (context, index) => EachItem(_message[index],_message,index),
                )
            )
          ],
        )
    );
  }
}

///构造每一个Item的类
class EachItem extends StatelessWidget{

  final Message message;
  final List<Message> _message;
  final int index;
  const EachItem(this.message, this._message, this.index);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      //key是必须的，而且是String类型
      key: new Key(message.userName),
      onDismissed: (direction){
        _message.removeAt(index);
      },
      child:Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child:  GestureDetector(
            child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 14.0,right: 14.0),
                    child: new CircleAvatar(
                      backgroundImage: NetworkImage(message.imageUrl),
                    ),
                  ),
                  Flexible(
                    child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(message.userName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 17.0
                              )
                          ),
                          new Container(
                            margin: const EdgeInsets.only(top: 5.0),
                            child: new Text(message.firstMessage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ]
                    ),
                  ),
                ]
            ) ,
            onTap: (){
              //跳转到聊天界面
              Navigator.pushNamed(context,
                  "Chat",
                  arguments: new Chatter(message.userName,message.imageUrl)
              );
            },
          )
      ) ,
    );
  }
}


