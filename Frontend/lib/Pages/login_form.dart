import 'package:flutter/material.dart';
import 'package:hackathon_frontend/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Map userData = {};
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 79, 59, 51),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Text(
                "LOGIN",
                maxLines: 2,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontFamily: "serif",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (email) {},
                controller: _emailController,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  hintText: "Your email",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 254, 100, 0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
                  controller: _passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    hintText: "Your password",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 254, 100, 0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              const SizedBox(height: defaultPadding),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 254, 100, 0)),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      print(_emailController.text);
                      Uri uri = Uri.parse(
                          'https://hackathon.aldoiris.online/api/token/');
                      http.Response response = await http.post(uri, body: {
                        "username": _emailController.text,
                        "password": _passwordController.text
                      });

                      // 401 andre wrong credentials anta

                      if (response.statusCode == 200) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString(
                            'access', jsonDecode(response.body)["access"]);
                        prefs.setString(
                            'refresh', jsonDecode(response.body)["refresh"]);
                        Navigator.pushNamed(context, '/');
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Login".toUpperCase(),style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return const SignUpScreen();
              //     },
              //   ),
              // );
            ],
          ),
        ),
      ),
    );
  }
}
