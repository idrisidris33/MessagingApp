import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messages_app/Auth/login.dart';
import 'package:messages_app/Auth/signup.dart';

class AuthMethod extends StatelessWidget {
  const AuthMethod({super.key});

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
                'Messages NOW',
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
                "Welcome",
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),

              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const Signup()));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fixedSize: const Size.fromWidth(250)),
                child: Text('Signup',
                    style: GoogleFonts.ubuntu(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const Login()));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fixedSize: const Size.fromWidth(250)),
                child: Text('Login',
                    style: GoogleFonts.ubuntu(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(
                height: 50,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
