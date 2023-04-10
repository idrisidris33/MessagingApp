import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../home.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Login',
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
                "Access your account and start exploring our platform",
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
                      controller: password,
                      decoration: const InputDecoration(
                          hintText: "Password", border: InputBorder.none))),
              // i'm going to search for an awesom font . . .

              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'If you are alredy member ',
                      style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                  try {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                    var user = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: password.text);

                    if (user != null) {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => const Home()));
                    }
                    //  else {
                    //   // ignore: use_build_context_synchronously
                    //   showDialog(
                    //       context: context,
                    //       builder: ((context) => const Text('fjfjfjfj')));
                    // }
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 6),
                        content: Text(e.message.toString())));
                    Navigator.pop(context);
                  } catch (e) {
                    print(e);
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fixedSize: const Size.fromWidth(250)),
                child: Text('Signin',
                    style: GoogleFonts.ubuntu(fontWeight: FontWeight.w600)),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

// Access your account and start exploring our platform   Signin
// Connect with friends and start chatting in real-time   Login
// Welcome back! Enter your login details to join the conversation
