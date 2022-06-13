import 'package:chat_app_firebase/provider/user.dart';
import 'package:chat_app_firebase/screens/chat_screen.dart';
import 'package:chat_app_firebase/widgets/my_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingInScreen extends StatelessWidget {
  static const String routeString = "sign_in_screen";
  SingInScreen({Key? key}) : super(key: key);

  String? _email;
  String? _password;

  signIn(BuildContext context, String email, String password) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    _currentUser.signInUser(email: email, password: password).then((value) {
      // Navigator.pushNamed(context, ChatScreen.routeString);
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushNamed(context, ChatScreen.routeString);
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(height: 100, child: Image.asset("assets/logo.png")),
              const Text("Message Me",
                  style: TextStyle(
                      fontSize: 40,
                      color: Color(0xff2e368b),
                      fontWeight: FontWeight.w900))
            ]),
            const SizedBox(
              height: 24,
            ),
            TextField(
              onChanged: (value) {
                _email = value;
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                hintText: "Enter your Email",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.blue, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(color: Colors.orange, width: 1)),
                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              onChanged: (value) {
                _password = value;
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: "Enter your Password",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.blue, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(color: Colors.orange, width: 1)),
                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            MyButton(
              color: Colors.yellow[900]!,
              title: "Sign In",
              onPressed: () {
                signIn(context, _email!, _password!);
              },
            )
          ],
        ),
      ),
    );
  }
}
