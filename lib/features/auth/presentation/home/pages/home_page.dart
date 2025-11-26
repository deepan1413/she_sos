import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: (){
          FirebaseAuth.instance.signOut();
        }, icon: Icon(Icons.outlet_outlined))
      ],),
      body: Column(mainAxisAlignment: .center,
        children: [

          Center(child: 
          Text('HomePage')),
        ],
      ),
    );
  }
}