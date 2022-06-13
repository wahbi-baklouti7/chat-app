import 'package:cloud_firestore/cloud_firestore.dart';



class MyDatabase{
  final _fireStore=FirebaseFirestore.instance;
  addMessage(String message,String email)async{
    await _fireStore.collection("messages").add({
      "message":message,
      "email":email,
      "time":FieldValue.serverTimestamp()
    });
  }
}