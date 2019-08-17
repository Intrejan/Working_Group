import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:working_group/user/login_page.dart';

class UserDrawerPage extends StatefulWidget{
  UserDrawerPage(this.userEmail);
  final String userEmail;
  @override
  _UserPageState createState()=>_UserPageState(userEmail);
  }

  class _UserPageState extends State<UserDrawerPage>{

  _UserPageState(this.userEmail);
  final String userEmail;
  String userName="New user";
  @override
  Widget build(BuildContext context) {
    //print(userEmail);
    Widget selfHeader = new DrawerHeader(
        child: new Stack(
          children: <Widget>[
            new Align(
              alignment: FractionalOffset.bottomLeft,
                child: Container(
                  height: 140.0,
                  margin: EdgeInsets.only(left: 15.0, bottom: 0),
                  child: new Column(
                    mainAxisSize: MainAxisSize.max, /* 宽度只用包住子组件即可 */
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user.png'),
                        radius: 35.0,
                      ),
                      new Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.0),
                        child: SizedBox(height: 10),
                      ),
                      new Container(
                        margin: EdgeInsets.only(left:5.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // 水平方向左对齐
                          mainAxisAlignment: MainAxisAlignment.center, // 竖直方向居中
                          children: <Widget>[
                            new Text(userName, style: new TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),),
                            new SizedBox(height: 4),
                            new Text(userEmail, style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.white),),
                          ],
                        ),
                      ),
                    ],),
                ),
            )
          ],
        ),
        padding: EdgeInsets.zero,
        decoration: new BoxDecoration(
//          gradient: LinearGradient(
//              colors: [Colors.blue, Colors.indigo],
//              begin: FractionalOffset(1, 1),
//              end: FractionalOffset(0, 0)
//          ),
          image: new DecorationImage(
            image: AssetImage("assets/images/userbg.png"),
            fit: BoxFit.fitHeight,
        )
      ),
    );

    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //在这里使用自定义的header
          selfHeader,
          ListTile(title: Text('Homepage'),
            leading: new CircleAvatar(
              child: new Icon(Icons.home),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              radius: 18,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(title: Text('Partners'),
            leading: new CircleAvatar(
              child: new Icon(Icons.people),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              radius: 18,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "Partners");
            },
          ),
          ListTile(title: Text('History'),
            leading: new CircleAvatar(
              child: new Icon(Icons.history),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              radius: 18,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(title: Text('Schedule'),
            leading: new CircleAvatar(
              child: new Icon(Icons.schedule),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              radius: 18,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(title: Text('Switch'),
            leading: new CircleAvatar(
              child: new Icon(Icons.cached),
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              radius: 18,
            ),
            onTap: () {
              _showSwitchDialog(context);
            },
          ),
        ],
      ),
    );
  }
  void _showSwitchDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
              content: Text(
              " Are you sure?",
            ),
            title: Text("Switch Accout"),
            actions: <Widget>[
              new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start, // 竖直方向居中
                children: <Widget>[
                  FlatButton(
                    textColor: Colors.red,
                    child: Text(
                      "  CANCEL",
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      },
                  ),
                  SizedBox(width: 70),
                  FlatButton(
                    child: Text(
                        "OK"
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder:(context)=> LoginPage()));
                      },
                  ),
                  SizedBox(width: 25)
                ],
              ),
            ],
          );
        });
  }
}

