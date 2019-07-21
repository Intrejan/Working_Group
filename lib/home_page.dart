import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'group_screen.dart';
import 'home_screen.dart';
import 'news_screen.dart';
class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
  }) : _icon = icon,
        _color = color,
        _title = title,
        item = BottomNavigationBarItem(
          icon: icon,
          activeIcon: activeIcon,
          title: Text(title),
        ),
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = controller.drive(CurveTween(
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;

  FadeTransition transition(BuildContext context) {
    Color iconColor;
    iconColor = _color;

    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(
          Tween<Offset>(
            begin: const Offset(0.0, 0.02), // Slightly down.
            end: Offset.zero,
          ),
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          ),
        ),
      ),
    );
  }
}

class Homepage extends StatefulWidget{

  @override
  _HomePageState createState()=>_HomePageState();
}

class _HomePageState extends State<Homepage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;
  List<Widget> list = List();
  @override
  void initState(){
    super.initState();
    list
      ..add(HomeScreen())
      ..add(GroupScreen())
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
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews)
      view.controller.dispose();
    super.dispose();
  }

  @override
   Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews
          .map<BottomNavigationBarItem>((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      fixedColor: Colors.blue,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );
    return Scaffold(
      body: list[_currentIndex],

      bottomNavigationBar: botNavBar,
    );

  }
}



