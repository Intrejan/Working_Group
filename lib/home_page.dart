import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:working_group/screen/groupScreen/joined_group.dart';
import 'package:working_group/screen/groupScreen/owned_group.dart';
import 'package:working_group/screen/groupScreen/passed_group.dart';
import 'package:working_group/screen/home_screen.dart';
import 'package:working_group/screen/news_screen.dart';
import 'package:working_group/user/user_drawer.dart';

import 'message.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
  }) :
        item = BottomNavigationBarItem(
          icon: icon,
          activeIcon: activeIcon,
          title: Text(title),
        ),
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        );

  final BottomNavigationBarItem item;
  final AnimationController controller;
}

class Homepage extends StatefulWidget{

  @override
  _HomePageState createState()=>_HomePageState();
}

class _HomePageState extends State<Homepage> with TickerProviderStateMixin {


  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;
  List<Widget> _tabList = List();
  List<String> tilTes = ["Home","Group","News"];
  TabController _tabController; //需要定义一个Controller
  List<String> tabs = ["Owned Group", "Joined Group","Passed Group"];
  String userEmail;

  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState(){
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));

    _tabList
      ..add(HomeScreen())
      ..add(OwnedGroupScreen())
      ..add(NewsScreen());

    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        icon: const Icon(Icons.home,color: Colors.blue),
        title: 'Home',
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.group_work,color: Colors.blue),
        title: 'Group',
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.message,color: Colors.blue),
        title: 'News',
        vsync: this,
      ),
    ];
    _navigationViews[_currentIndex].controller.value = 1.0;

    _tabController = TabController(length: tabs.length, vsync:this);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (NavigationIconView view in _navigationViews)
      view.controller.dispose();
    super.dispose();
  }

  Widget join() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn1",
        onPressed: null,
        tooltip: 'Join',
        child: Icon(Icons.arrow_upward,),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget create() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn2",
        onPressed: null,
        tooltip: 'Create',
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget drop() {
    return Container(
      child:FloatingActionButton(
        heroTag: "btn3",
        onPressed:null,
        tooltip: 'Drop',
        child: Icon(Icons.power_settings_new),
        backgroundColor: Colors.yellow,
      ),
    );
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return Container(
      child:new FloatingActionButton(
        heroTag: "btn4",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  Widget animatedFab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: join(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: create(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: drop(),
        ),
        toggle(),
      ],
    );
  }

  @override
   Widget build(BuildContext context) {

    userEmail=ModalRoute.of(context).settings.arguments;
    //print(userEmail);

    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews
          .map<BottomNavigationBarItem>((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      fixedColor: Colors.blue,
      type: _type,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );

    if(_currentIndex==1) {
      return Scaffold(
        appBar: AppBar(
          leading: new Container(
            margin: EdgeInsets.only(top: 3, left: 3,right: 3,bottom: 3),//容器补白
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: new ExactAssetImage('assets/images/user.png'),
                  fit: BoxFit.cover
              ),
            ),
          ),
          centerTitle: true,
          title: Text("Group"),
          bottom: TabBar(
              controller: _tabController,
              tabs: tabs.map((e) => Tab(text: e)).toList()
          ),
          actions: <Widget>[ //导航栏右侧菜单
            IconButton(icon: Icon(Icons.mail_outline),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder:(context)=> new MessagePage()));
                }),
          ],
        ),

        body:TabBarView(
          controller: _tabController,
          children: [
            OwnedGroupScreen(),
            JoinedGroupScreen(),
            PassedGroupScreen()
          ]
        ) ,
        bottomNavigationBar: botNavBar,
        drawer: UserDrawerPage(userEmail),
        floatingActionButton:animatedFab(),
      );
    }
    else{
      return Scaffold(
        appBar: new AppBar(
          leading: new Container(
            margin: EdgeInsets.only(top: 3, left: 3,right: 3,bottom: 3),//容器补白
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: new ExactAssetImage('assets/images/user.png'),
                  fit: BoxFit.cover
              ),
            ),
          ),
          centerTitle: true,
          title: Text(tilTes[_currentIndex]),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.mail_outline),
                onPressed: () {
                  Navigator.pushNamed(context,"MessagePage");
                })
          ],
        ),
        body: _tabList[_currentIndex],
        bottomNavigationBar: botNavBar,
        drawer: UserDrawerPage(userEmail),
        floatingActionButton:animatedFab(),
      );
    }
  }
}



