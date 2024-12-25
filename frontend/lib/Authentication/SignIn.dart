import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mapsnap_fe/NewFeed/newFeedScreen.dart';
import '../Model/Token_2.dart';
import '../Model/User_2.dart';
import '../Widget/UpdateUser.dart';
import '../Widget/accountModel.dart';
import 'ForgotPassword.dart';
import 'SignUp.dart';
import '../Widget/passwordForm.dart';
import '../Widget/normalForm.dart';
import '../Widget/outline_IconButton.dart';
import '../Services/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';




class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _authService = AuthService();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool isEmailInvalid = false;
  bool isPasswordInvalid = false;

  String isComplete = 'Missing info';
  String errorMess = '';

  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  void post_login() async {

    final response = await _authService.Login(_emailController.text, _passwordController.text);

    final mess = response['mess'];

    if(mess == 'Login success'){
      final data = response['data'];

      final prefs = await SharedPreferences.getInstance();

      Token token = Token(
        token_access: data['tokens']['access']['token'] ?? 'NoTokenAccess',
        token_access_expires: DateTime.parse(data['tokens']['access']['expires']),
        token_refresh: data['tokens']['refresh']['token'] ?? 'NoTokenRefresh',
        token_refresh_expires: DateTime.parse(data['tokens']['refresh']['expires']),
        idUser: data['user']['id'] ?? 'NoID',
      );

      await prefs.setString('token', jsonEncode(token.toJson()));

      var accountModel = Provider.of<AccountModel>(context, listen: false);
      accountModel.setToken(token);
      User? user = await fetchData(token.idUser,token.token_access);
      accountModel.setUser(user!);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => newFeedScreen()),
      );
    }
  
    else if(mess == 'Login failed'){
      final data = response['data'];

      isComplete = 'Invalid info';
      setState(() {
        errorMess = data == null ? 'Unknown information error!' : data['message'];
      });
    }

    else{
      isComplete = 'Connection error';
      setState(() {
        errorMess = 'Connection error!';
      });
    }
  }

  void login(){

    setState((){
      isComplete = 'true';
      isEmailInvalid = false;
      isPasswordInvalid = false;

      if(_emailController.text == ''){
        isEmailInvalid = true;
        isComplete = 'Missing info';
      }
      if(_passwordController.text == ''){
        isPasswordInvalid = true;
        isComplete = 'Missing info';
      }

      if(isComplete != 'true'){
        errorMess = 'Please fill out all infomation';
        return;
      }

      post_login();

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Login/Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 70,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    image: AssetImage("assets/Login/SignIn.png"),
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                if(isComplete != 'true')
                  Container(
                    height: 40,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        errorMess,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20
                        ),
                      ),
                    ),
                  )
                else
                  SizedBox(height: 40),

                // Các ô nhập liệu
                normalForm(label:'Email', controller: _emailController,),
                if(isEmailInvalid)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Please fill this infomation!',
                      style: TextStyle(
                          color: Colors.red
                      ),
                    ),
                  )
                else
                  SizedBox(height: 12),
                passwordForm(label:'Password', controller: _passwordController,),
                if(isPasswordInvalid)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Please fill this infomation!',
                      style: TextStyle(
                          color: Colors.red
                      ),
                    ),
                  )
                else
                  SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPassword()),
                        );
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Nút Register
                ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.lightBlueAccent
                  ),
                  child: Text('Sign In'),
                ),
                SizedBox(height: 20),

                // Hoặc Login với
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Or Login with'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 20),

                // Nút đăng ký với Google
                outline_IconButton(label: "Google", color: Colors.red,),
                SizedBox(height: 12),

                // Nút đăng ký với Facebook
                outline_IconButton(label: "Facebook", color: Colors.lightBlueAccent,),
                SizedBox(height: 20),

                // Đăng nhập nếu đã có tài khoản
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Doesnt have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


