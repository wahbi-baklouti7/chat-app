import 'package:chat_app_firebase/provider/user.dart';
import 'package:chat_app_firebase/screens/chat_screen.dart';
import 'package:chat_app_firebase/screens/sigin_in_screen.dart';
import 'package:chat_app_firebase/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_firebase/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth=FirebaseAuth.instance;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: ChatScreen(),
        initialRoute:_auth.currentUser==null? WelcomeScreen.routeString:ChatScreen.routeString,
        routes: {
          WelcomeScreen.routeString: (context) => const WelcomeScreen(),
          SingInScreen.routeString: (context) =>  SingInScreen(),
          SignUpScreen.routeString: (context) => SignUpScreen(),
          ChatScreen.routeString: (context) => const ChatScreen(),
        },
      ),
    );
  }
}
