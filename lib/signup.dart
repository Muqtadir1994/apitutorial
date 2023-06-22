import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  //

  var emailcon = TextEditingController();
  var passcon = TextEditingController();
  var result = '';
//

//Sign up process through api
  void signup(String email, password) async {
    try {
      var response = await post(Uri.parse('https://reqres.in/api/register'),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);

        print('Account Created');
        result = 'Account Created';
        setState(() {});
      } else {
        print('Failed');
        result = 'Failed';
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Api')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailcon,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Email'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passcon,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Password'),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 500,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
                  onPressed: () {
                    signup(emailcon.text.toString(), passcon.text.toString());
                  },
                  child: const Text('Sign Up')),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                result,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ));
                },
                child: const Text('NEXT')),
          ],
        ),
      ),
    );
  }
}
