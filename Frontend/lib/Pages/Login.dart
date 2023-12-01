import 'package:flutter/material.dart';
import '/Pages/login_form.dart';
import 'login_screen_top_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Color.fromARGB(255, 254, 100, 0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'static/logo.png',
              fit: BoxFit.contain,
              height: 78,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'AGILEROUTE MANAGER',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 41, 34, 29),
        child: Row(
          children: [
            Expanded(
              child: LoginScreenTopImage(),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 500,
                    height: 350,
                    child: LoginForm(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
