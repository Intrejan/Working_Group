import 'package:flutter/material.dart';

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

  searchMessage(String key){
//    _message.clear();
//    initState();
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
          new IconButton(icon: Icon(Icons.settings,color: Colors.white,),
              onPressed: null
          )
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
                  itemBuilder: (context, index) => EachItem(_message[index]),
                )
            )
          ],
        )
    );
  }

}


class EachItem extends StatelessWidget{

  final Message message;
  const EachItem(this.message);

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child:  Row(
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
        )
    );
  }
}

