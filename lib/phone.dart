import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp.dart';

class Home5 extends StatefulWidget{
  @override
  Homestate5 createState() => Homestate5();

}
class Homestate5 extends State<Home5>{
  late File imagefile;






  Future openCamera(BuildContext context) async{
    final file=await ImagePicker().pickImage(source: ImageSource.camera,);
    setState(() {
      imagefile=File(file!.path);
    });
  }
  Widget setimage(){
    if(imagefile!=null){
      return Image.asset('assets/images/photo.png');
    }else{
      return Image.file(imagefile);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNo=TextEditingController();
    var phone='';
    String verificationid="";

    void verifying_otp() async{
      print("hello");
      try{
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91'+phone,
          verificationCompleted: (PhoneAuthCredential credential) {
            print("verification completed");
           // Navigator.push(context,MaterialPageRoute(builder: (context)=>myOtp(verificationid)));
          },
          verificationFailed: (FirebaseAuthException e) {print("verification failed");},
          codeSent: (String verificationId, int? resendToken) {
            verificationid=verificationId;
            print("code sent: "+verificationId);
            Navigator.push(context,MaterialPageRoute(builder: (context)=>myOtp(verificationid)));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
      finally{
        //Navigator.push(context,MaterialPageRoute(builder: (context)=>myOtp()));
      }

    }


    return Scaffold(
      appBar: AppBar(title: Text("my app"),),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 70,
              child: GestureDetector(
                onTap: (){openCamera(context);setimage();},

              ),
            ) ,
            Container(height: 10,),
            Text("${DateFormat('yMEd').format(DateTime.now())}",style: TextStyle(fontSize: 24,color: Colors.orange),),
            Container(height: 40,),
            Card(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
              elevation: 10,
              child: TextField(
                onChanged: (value){
                  phone=value;
                },
                keyboardType: TextInputType.phone,
                controller: phoneNo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Mobile Number',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ),
            // Container(height: 10,),
            //  Card(
            //    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
            //    elevation: 10,
            //    child: TextField(
            //      decoration: InputDecoration(
            //        border: OutlineInputBorder(),
            //        labelText: 'OTP',
            //        prefixIcon: Icon(Icons.password),
            //      ),
            //    ),
            //  ),
            Container(height: 30,),
            Container(
              height: 40,
              margin: EdgeInsets.only(left: 30,right: 30),
              child: ElevatedButton(

                onPressed: (){
                  verifying_otp();
                },
                child: Center(
                  child: Text("Login",
                    style: TextStyle(fontSize: 24),),
                ), ),
            ),
          ],
        ),
      ),

    );
  }

}