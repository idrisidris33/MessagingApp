// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:messages_app/authmethod.dart';

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

  void streamMessages() async {
    await for (var snapshot in _send.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  // void getmesseges() async {
  //   var messages = await _send.collection("messages").get();
  //   for (var message in messages.docs) {
  //     print(
  //         "messagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessage");
  //     print(message.data());
  //     print(
  //         "messagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessage");
  //   }
  // }
  void messagesStream() async {
    await for (var snapshot in _send.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        print(message.data());
      }
      ;
    }
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
              // drawer: const Drawer(),
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
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StreamMessages(),
                        // Container(),

                        // ElevatedButton.icon(
                        //     onPressed: () {
                        //       messagesStream();
                        //       // getmesseges();
                        //     },
                        //     icon: const Icon(Icons.download_rounded),
                        //     label: const Text('dowenload ')),
                        Container(
                            // color: Colors.amberAccent,
                            child: Row(
                          // mainAxisAlignment: MainAxisAlignment. center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
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
                                    messagesCnt.clear();
                                  },
                                  child: const Text('Sent')),
                            )
                          ],
                        )),
                        // Container(),
                      ]),
                ),
              ),
            );
          } else {
            return const AuthMethod();
          }
        }));
  }
}

class StreamMessages extends StatelessWidget {
  StreamMessages({super.key});
  final _send = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _send.collection('messages').snapshots(),
        builder: (context, snapshot) {
          List<MessageStyle> messagesWidgets = [];
          if (!snapshot.hasData) {
            //add loading
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.grey,
            ));
          }

          final messages = snapshot.data!.docs;
          for (var message in messages) {
            final text = message.get('text');
            final sender = message.get('sender');
            final messagewidget = MessageStyle(
              sender: "$sender",
              text: "$text",
            );
            messagesWidgets.add(messagewidget);
          }

          return Expanded(
            child: ListView(
              children: messagesWidgets,
              // shrinkWrap:false ,
              // physics: const BouncingScrollPhysics(),
              // keyboardDismissBehavior:
              //     ScrollViewKeyboardDismissBehavior.manual,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.center,
            ),
          );
        });
  }
}

class MessageStyle extends StatelessWidget {
  String sender;
  String text;
  MessageStyle({
    Key? key,
    required this.sender,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("$sender"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Material(
            borderRadius: BorderRadius.circular(15),
            color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text("$text"),
            ),
          ),
        ),
      ],
    );
  }
}
