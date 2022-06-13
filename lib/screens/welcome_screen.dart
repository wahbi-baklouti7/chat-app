import 'package:chat_app_firebase/screens/sigin_in_screen.dart';
import 'package:chat_app_firebase/widgets/my_buttons.dart';
import 'package:chat_app_firebase/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeString = "welcome_screen";
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 150,
                  child: Image.asset("assets/logo.png"),
                ),
                const Text("Message Me",
                    style: TextStyle(
                        fontSize: 40,
                        color: Color(0xff2e368b),
                        fontWeight: FontWeight.w900))
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            MyButton(
              color: Colors.yellow[900]!,
              title: "Sign In",
              onPressed: () {
                Navigator.pushNamed(context, SingInScreen.routeString);
              },
            ),
            // SizedBox(height: 16,),
            MyButton(
              color: Colors.blue[800]!,
              title: "Sign Up",
              onPressed: () {
                Navigator.pushNamed(context, SignUpScreen.routeString);
              },
            ),
          ]),
    ));
  }
}
