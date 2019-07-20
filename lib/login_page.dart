
import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:working_group/register_page.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isMatch =false;
  bool _isObscure = true;
  Color _eyeColor;
  List _loginMethod = [
    {
      "title": "facebook",
      "icon": GroovinMaterialIcons.facebook,
    },
    {
      "title": "google",
      "icon": GroovinMaterialIcons.google,
    },
    {
      "title": "twitter",
      "icon": GroovinMaterialIcons.twitter,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 22.0),
              children: <Widget>[
                SizedBox(
                  height: kToolbarHeight,
                ),
                buildTitle(),
                buildTitleLine(),
                SizedBox(height: 40.0),
                buildEmailTextField(),
                SizedBox(height: 25.0),

                buildPasswordTextField(context),
                buildForgetPasswordText(context),
                SizedBox(height: 25.0),
                buildLoginButton(context),
                SizedBox(height: 20.0),
                buildOtherLoginText(),
                buildOtherMethod(context),
                buildRegisterText(context),
                SizedBox(height: 20.0,)
              ],
            )));
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('没有账号？'),
            GestureDetector(
              child: Text(
                '点击注册',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new RegisterPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  ButtonBar buildOtherMethod(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: _loginMethod
          .map((item) => Builder(
        builder: (context) {
          return IconButton(
              icon: Icon(item['icon'],
                  color: Theme.of(context).iconTheme.color),
              onPressed: () {
               //TODO Other Ways
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text("${item['title']}登录"),
                  action: new SnackBarAction(
                    label: "取消",
                    onPressed: () {},
                  ),
                ));
              });
        },
      ))
          .toList(),
    );
  }

  Align buildOtherLoginText() {
    return Align(
        alignment: Alignment.center,
        child: Text(
          '其他账号登录',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ));
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            'Login',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () {
            get(_email);
            _formKey.currentState.save();
            if (_formKey.currentState.validate()&&_isMatch) {
              print("yes");
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => new Homepage()));
            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            '忘记密码？',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () {
            //Navigator.pop(context);
          },
        ),
      ),
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password = value,
      obscureText: _isObscure,
      decoration: InputDecoration(
          labelText: 'Password',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入密码';
        }else if(!_isMatch){
          return "密码错误！";
        }else{
          return null;
        }
      },


    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Emall Address',
      ),
      validator: (String value) {
        var emailReg = RegExp(
            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
        if (!emailReg.hasMatch(value)) {
          return '请输入正确的邮箱地址';
        }else{
          return null;
        }
      },
      onSaved: (String value) => _email = value,
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Login',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }

  get(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _pwd = prefs.get(userEmail);
    print('input:$_password,password:$_pwd');
    if (_password == prefs.get(userEmail)){
      _isMatch = true;
    }else{
      _isMatch = false;
    }
  }
}

