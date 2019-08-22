import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelfPage extends StatefulWidget{

  @override
  _SelfPage createState()=> _SelfPage();
}

class _SelfPage extends State<SelfPage>{

  String userName="";
  String background="";
  String gender = "";
  String head="";
  String phoneNumber = "";
  String address = "";
  String birthday = "";
  List<String> items = ["  Name","  Gender","  Phone Number","  Address","  Birthday","","","","","","","","","","",];

  @override
  initState(){
    getUser();
    super.initState();
  }
  ///获取信息
  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("userName");
      background = prefs.getString("background");
      head = prefs.getString("head");
      gender = prefs.getString("gender");
      phoneNumber = prefs.getString("phoneNumber");
      address = prefs.getString("address");
      birthday = prefs.getString("birthday");

    });
  }
  ///更新信息
  setUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userName", userName);
    prefs.setString("head", head);
    prefs.setString("gender", gender);
    prefs.setString("phoneNumber", phoneNumber);
    prefs.setString("address", address);
    prefs.setString("birthday", birthday);
  }
  ///编辑
  compile(int index) {

    switch(index){
      case 0:_showNameTextField();break;
      case 1:_showGenderPicker();break;
      case 2:_showNumberTextField();break;
      case 3:_showAddressTextField();break;
      case 4:_showDataPicker();break;
      default:break;
    }
  }
  ///用户名
  _showNameTextField() async{
    TextEditingController _controller =TextEditingController();
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Name"),
          content: new TextField(
            controller: _controller,
            decoration: new InputDecoration.collapsed(hintText: '输入用户名'),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('确定'),
              onPressed: () {
                userName =_controller.text;
                setUser();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  ///性别
  _showGenderPicker() async{
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            title: new Text("Gender"),
            content: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new IconButton(icon: Icon(Icons.person), onPressed: (){
                      gender = "男";
                      setUser();
                      Navigator.of(context).pop();
                    }),
                    new Text("man")
                  ],
                ),
                new SizedBox(width: 40,),
                new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new IconButton(icon: Icon(Icons.person_outline), onPressed: (){
                      gender = "女";
                      setUser();
                      Navigator.of(context).pop();
                    }),
                    new Text("woman")
                  ],
                )
              ],
            ),
          );
        }
    );
  }
  ///电话号码
  _showNumberTextField() async{
    TextEditingController _controller =TextEditingController();
    _controller.clear();
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Phone Number"),
          content: new TextField(
            controller: _controller,
            decoration: new InputDecoration.collapsed(hintText: '输入手机号'),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('确定'),
              onPressed: () {
                phoneNumber =_controller.text;
                setUser();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  ///地址
  _showAddressTextField() async{
    TextEditingController _controller =TextEditingController();
    _controller.clear();
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Address"),
          content: new TextField(
            controller: _controller,
            decoration: new InputDecoration.collapsed(hintText: '输入地址'),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('确定'),
              onPressed: () {
                address =_controller.text;
                setUser();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  ///出生年月日
  _showDataPicker() async {

    Locale myLocale = Localizations.localeOf(context);
    var picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2020),
        locale: myLocale);
    setState(() {
      birthday = picker.toString().substring(0,10);
      setUser();
    });
  }

  ///列表
  Widget entryItem(int index){

    List<String> userItems = [userName,gender,phoneNumber,address,birthday,"","","","","","","","","","",""];

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Text(
          items[index],
          style: new TextStyle(
            fontSize: 18,
          ),
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Text(
              userItems[index],
              style: new TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            new SizedBox(width: 20,),
            new IconButton(
                icon: Icon(Icons.navigate_next),
                onPressed: ()=>compile(index)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: new CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: new Text("Self Page"),
              background: Image.asset(
                head, fit: BoxFit.cover,
              ),
            ),
          ),
          new SliverFixedExtentList(
            itemExtent: 70.0,
            delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  //创建列表项
                  return entryItem(index);
                },
                childCount: 10
            ),
          ),
        ],
      ),
    );
  }
}
