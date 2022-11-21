import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
// 로그인 화면

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

final _formKey = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  bool _isLoading = false;

  signIn(String email, String pass) async {
    String url = "https://movill-api.two4.de/auth/login";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"email": email, "password": pass};
    var jsonResponse;
    var res = await http.post(Uri.parse(url), body: body);

    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);

      print("Response status: ${res.statusCode}");

      print("Response status: ${res.body}");

      if (jsonResponse != null) {
        setState(() {
          _isLoading == false;
        });

        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => App()),
            (Route<dynamic> route) => false);
      } else {
        setState(() {
          _isLoading = false;
        });

        print("Response status: ${res.body}");
      }
    }
  }

  bool _visibility = true;
  void _show() {
    setState(() {
      _visibility = true;
    });
  }

  void _hide() {
    setState(() {
      _visibility = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              //shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 200, 16.0, 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: '아이디',
                      hintText: 'Enter your Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: '패스워드',
                      hintText: 'Enter your Password',
                      //focusedBorder: OutlineInputBorder(
                      //  borderSide: BorderSide(width: 1, color: Colors.redAccent),
                      //),
                      //enabledBorder: OutlineInputBorder(
                      //),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  //세번째 padding
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 24.0, 24.0),
                  child: Material(
                    elevation: 5.0, //그림자효과
                    borderRadius: BorderRadius.circular(30.0), //둥근효과
                    color: Colors.grey,
                    child: SizedBox(
                      width: double.maxFinite,
                      child: MaterialButton(
                        //child - 버튼을 생성
                        onPressed: () {},
                        child: Text(
                          "Email 로그인",
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                      //InkWell을 사용 -- onTap이 가능한 이유임.
                      child: Text(
                        '처음이신가요? 이메일 계정 만들기',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () {
                        print('test');
                      }
                      //onTap: () => {_visibility? _hide():_show()},
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 24.0, 24.0),
                  child: Visibility(
                    visible: _visibility,
                    child: Material(
                      elevation: 5.0, //그림자효과
                      borderRadius: BorderRadius.circular(30.0),

                      child: Container(
                        width: double.maxFinite,
                        height: 150,
                        padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                        child: Text(
                          "Email 로그인",
                          style: TextStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
