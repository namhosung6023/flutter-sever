import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String password="";
  String email="";

  void loginTest() async {
    if (_formKey.currentState.validate()) {
      Scaffold.of(_formKey.currentContext).showSnackBar(
          SnackBar(content: Text('처리중')));
    }
    Dio dio = new Dio();
    String hashedPassword = sha256.convert(utf8.encode(password)).toString();
    print('hashed: $hashedPassword');
    Response response = await dio.post('http://10.0.2.2:3000/accounts/login',
        data: {"email": email, "password": hashedPassword});
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('loginpage'),
      ),
        body: Form(
            key: _formKey,
            child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (!value.contains('@')) {
                        return '이메일 형식에 맞게 쓰세요.';
                      }
                      email = value;
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'email',
                    ),
                  ),
                  TextFormField(

                    validator: (value){
                      if(value.length <= 7 ){
                        return '비밀번호를 8자 이상 쓰세요.';
                      }
                      password = value;
                      return null;
                    },
                    obscureText: true,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),

                  RaisedButton(
                    child: Text('Login '),
                    color: Colors.orange, // 배경 색상
                    onPressed: () {
                      loginTest();
                    },
                  ),

                ]
            )
        )
    );
  }
}
