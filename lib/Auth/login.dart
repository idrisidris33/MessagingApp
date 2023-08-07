import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _user = FirebaseAuth.instance;
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
                        'Login In',
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
                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return const Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     });
                    await _user.signInWithEmailAndPassword(
                        email: email.text, password: password.text);

                    // Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const Home()));
                  } on FirebaseAuthException catch (error) {
                    print("ERROR CODE ${error.code}");
                    print("ERROR MESSAGES ${error.message}");
                    // var erorr = getMessageFromErrorCode(e.code);
                    var snackBar = SnackBar(
                      content: Text(error.code.toString()),
                      duration: const Duration(seconds: 20),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  // on FirebaseAuthException catch (e) {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //       duration: const Duration(seconds: 6),
                  //       content: Text(e.message.toString())));
                  //   Navigator.pop(context);
                  // } catch (e) {
                  //   print(e);
                  // }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fixedSize: const Size.fromWidth(250)),
                child: Text('Login',
                    style: GoogleFonts.ubuntu(fontWeight: FontWeight.w600)),
              ),

              // test showing snakbar
              ElevatedButton(
                  onPressed: () {
                    var snackBar = SnackBar(
                      content: Text("kdfgkjs"),
                      duration: Duration(seconds: 20),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text("snakbar"))
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
String getMessageFromErrorCode(var errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      return "Email already used. Go to login page.";
      break;
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong email/password combination.";
      break;
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "No user found with this email.";
      break;
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "User disabled.";
      break;
    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
      break;
    case "ERROR_OPERATION_NOT_ALLOWED":
    case "operation-not-allowed":
      return "Server error, please try again later.";
      break;
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return "Email address is invalid.";
      break;
    default:
      return "Login failed. Please try again.";
      break;
  }
}
