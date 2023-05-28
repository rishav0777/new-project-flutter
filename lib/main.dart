import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/phone.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  //try{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    print("wel");
  //}
 // finally{
    runApp(
        MaterialApp( home: Home5())
    );
  //}


}