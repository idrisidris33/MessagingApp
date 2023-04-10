import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messages_app/authmethod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController messagesCnt = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _send = FirebaseFirestore.instance;
  String? messages;
  User? userSigned;

  String? emailUser;
  void sender() async {
    await _send
        .collection(
      "messages",
    )
        .add({
      "sender": userSigned!.email,
      "text": messages,
    });
  }

  void getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      userSigned = user;
      emailUser = userSigned!.email;
      print(userSigned!.email);
      print("-----------------------------------------------------------");
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              drawer: const Drawer(),
              appBar: AppBar(
                leading: null,

                title: Text('$emailUser'),
                actions: [
                  IconButton(
                      onPressed: () async {
                        try {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              });
                          var signOut = await FirebaseAuth.instance.signOut();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } catch (e) {
                          print(e);
                        }
                      },
                      icon: const Icon(Icons.exit_to_app_outlined)),
                ],
                // leading: null
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 10,
                        width: 200,
                        color: Colors.black38,
                      ),
                      Container(
                          // color: Colors.amberAccent,
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                                // width: 200,
                                margin: const EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                  top: 30,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: TextFormField(
                                    onChanged: (value) {
                                      messages = value;
                                    },
                                    controller: messagesCnt,
                                    decoration: const InputDecoration(
                                        hintText: "Messages ...",
                                        border: InputBorder.none))),
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                onPressed: () {
                                  sender();
                                },
                                child: const Text('Sent')),
                          )
                        ],
                      )),
                      // Container(),
                    ]),
              ),
            );
          } else {
            return AuthMethod();
          }
        }));
  }
}
