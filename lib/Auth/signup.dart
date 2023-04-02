import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messages_app/Auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                      decoration: const InputDecoration(
                          hintText: "Password", border: InputBorder.none))),
              // i'm going to search for an awesom font . . .

              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'If you are not member ',
                      style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => const Login()));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: () {},
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
