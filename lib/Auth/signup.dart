import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messages_app/Auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../home.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Register',
                style: GoogleFonts.ubuntu(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[600]),
              ),
              const SizedBox(
                height: 30,
              ),

              // TextStyle(fontSize: 26),

              Image.asset("assets/images/signin.png"),
              Text(
                "Welcome back! Enter your login details to join the conversation",
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),

              Container(
                  margin: const EdgeInsets.only(
                      left: 0, right: 0, top: 30, bottom: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          hintText: "Email", border: InputBorder.none))),
              Container(
                  margin: const EdgeInsets.only(
                      left: 0, right: 0, top: 10, bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: TextFormField(
                      obscureText: true,
                      controller: password,
                      decoration: const InputDecoration(
                          hintText: "Password", border: InputBorder.none))),
              Container(
                  margin: const EdgeInsets.only(
                      left: 0, right: 0, top: 10, bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: TextFormField(
                      obscureText: true,
                      controller: confirmpassword,
                      decoration: const InputDecoration(
                          hintText: "Confirme Password",
                          border: InputBorder.none))),
              // i'm going to search for an awesom font . . .

              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'If you are  member ',
                      style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => const Login()));
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                  if (password.text != confirmpassword.text) {
                  if(Platform.isAndroid){
                    const snackBar = SnackBar(
                      content: Text('password dosent match together '),
                      duration: const Duration(seconds: 20),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  
                  }
                  try {
                    var user = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email.text, password: password.text);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const Home()));
                  } catch (e) {
                    print(e);
                    print(e);
                  }

                  print(email.text);
                  print(password.text);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fixedSize: const Size.fromWidth(250)),
                child: Text(
                  'Register',
                  style: GoogleFonts.ubuntu(fontWeight: FontWeight.w600),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
