import 'package:flutter/material.dart';
import 'package:socialapp/widgets/header.dart';
import 'package:socialapp/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    createUser();
    super.initState();
  }

  createUser()async{
   final doc = await firestoreInstance.collection('userss').doc('5jxR8nO7en8jMAxMxXyM').get();
   if(doc.exists){
     doc.reference.update({"name": "jessa"});
   }else{
     print('not availible');
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, isAppTitle: true),
        body: StreamBuilder<QuerySnapshot>(
          stream: firestoreInstance.collection("userss").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            final List<Text> children =
                snapshot.data.docs.map((user) => Text(user['name'])).toList();
            return Container(
              child: ListView(
                children: children,
              ),
            );
          },
        ));
  }
}
