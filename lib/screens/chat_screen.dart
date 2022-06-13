import 'package:chat_app_firebase/provider/user.dart';
import 'package:chat_app_firebase/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

User? _userSign;

class ChatScreen extends StatefulWidget {
  static const String routeString = "chat_screen";

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController = TextEditingController();

  String? _message;

  void getUserInfo() {
    User? _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _userSign = _user;
      print(_userSign!.email);
    }
  }

  void getStreamMessage() async {
    FirebaseFirestore.instance
        .collection("messages")
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        print(doc.data());
      }
    });
  }

  void sendMessage(String message, String email) {
    MyDatabase().addMessage(message, email);
  }

  signOut(BuildContext context) {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    _currentUser.signOutUser().then((value) {
      Navigator.pop(context);
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: Row(
          children: [
            Image.asset(
              "assets/logo.png",
              height: 30,
            ),
            const SizedBox(
              width: 16,
            ),
            const Text("Chat",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                signOut(context);
                // getStreamMessage();
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MessageStreamBuilder(),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.yellow[800]!, width: 2))),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      onChanged: (value) {
                        _message = value;
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 24),
                          hintText: "Write your message"),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        _textEditingController.clear();
                        sendMessage(_message!, _userSign!.email!);
                      },
                      child: const Text("Send",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("messages")
          .orderBy("time")
          .snapshots(),
      builder: (context, snapshot) {
        List<MessageWidget> messages = [];

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List messageList = snapshot.data!.docs;
        for (var element in messageList) {
          String messageText = element["message"];
          String emailMessage = element["email"];

          messages.add(MessageWidget(
              isCurrentUser: _userSign!.email == emailMessage,
              messageText: messageText,
              sender: emailMessage));
        }

        return Expanded(
            child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(physics: BouncingScrollPhysics(), children: messages),
        ));
      },
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String? messageText;
  final String? sender;
  final bool isCurrentUser;

  const MessageWidget(
      {Key? key, required this.isCurrentUser, this.sender, this.messageText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender!,
              style: TextStyle(fontSize: 12, color: Colors.yellow[800])),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Material(
                elevation: 4,
                borderRadius: isCurrentUser
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                color: isCurrentUser ? Colors.blue[800] : Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                  child: Text(
                    "$messageText",
                    style: TextStyle(
                        fontSize: 16,
                        color: isCurrentUser ? Colors.white : Colors.black),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
