import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  bool _isLoading = false;

  siginIn(String email, String pass) async{
    String url = "https://movill-api.two4.de/auth/login";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"email":email,"password":pass};
    var jsonResponse;
    var res = await http.post(Uri.parse(url),body: body);

    if(res.statusCode==200){
      jsonResponse = json.decode(res.body);

      print("Response status: ${res.statusCode}");

      print("Response status: ${res.body}");

      if(jsonResponse != null){
        setState(() {
          _isLoading == false;
        });

        sharedPreferences.setString("token", jsonResponse['token']);
        //Navigator.of(context).pushNamedAndRemoveUntil
          //(MaterialPageRoute(builder: (BuildContext context) => Homepage()),
                //(Route<dynamic> route) => false)
      }else{
        setState(() {
          _isLoading = false;
        });

        print("Response status: ${res.body}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}