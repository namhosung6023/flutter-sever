import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fitwith',
      theme: ThemeData(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  void joinTest() async {
    if (_formKey.currentState.validate()) {
      Scaffold.of(_formKey.currentContext).showSnackBar(
          SnackBar(content: Text('처리중')));
    }
    Dio dio = new Dio();
    Response response = await dio.post('http://10.0.2.2:3000/accounts/join',
        data: {"name": "hosung", "email": "asdfsdf", "password": "123456"});
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('fitwith'),
            centerTitle: true
        ),
        body: Form(
            key: _formKey,
            child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return '공백은 허용되지 않습니다';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'id',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (!value.contains('@')) {
                        return '이메일 형식에 맞게 쓰세요';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'email',
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value){
                        if(value.length <= 7 ){
                        return '비밀번호를 8자 이상 쓰세요';
                      }
                        return null;
                    },
                    obscureText: true,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  TextFormField(

                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (String value){
                      print('value: $value');
                      print('passcon: ${_passwordController.text}');

                      if(value != _passwordController.text){
                        return '비밀번호가 일치하지 않습니다 ';
                      }

                      return null;
                    },
                  ),
                  RaisedButton(
                    child: Text('Join in'),
                    color: Colors.orange, // 배경 색상
                    onPressed: () {
                      joinTest();
                    },
                  ),
                ]
            )
        )
    );
  }
}


