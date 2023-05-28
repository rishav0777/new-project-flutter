import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:untitled2/QuizeHome.dart';
import 'package:firebase_auth/firebase_auth.dart';


class myOtp extends StatefulWidget{
  String otp;
  myOtp(this.otp);//:super(key:key);

  @override
  myOtpState createState() => myOtpState(otp);


}
class myOtpState extends State<myOtp> {
  String useOtp="";
  @override
  OtpFieldController otpController = OtpFieldController();
  String otp;
  myOtpState(this.otp);
  FirebaseAuth auth=FirebaseAuth.instance;

  void matchingOtp() async{
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: otp, smsCode: useOtp);
      await auth.signInWithCredential(credential);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>quizeHome()));
    }
    catch(e){
      print("wrong otp");
      print(e);
    }
    finally{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>quizeHome()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("my_app")),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OTPTextField(
              controller: otpController,
              length: 6,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.center,
              spaceBetween: 5,
              fieldWidth: 45,
              fieldStyle: FieldStyle.box,
              outlineBorderRadius: 15,
              style: TextStyle(fontSize: 17),
              onCompleted: (String VerificationCode){

              },
            ),
            Container(height: 40,),
            Container(
              margin: EdgeInsets.only(left: 30,right: 30),
              child: ElevatedButton(onPressed: (){
                matchingOtp();
              },
                  child: Center(
                    child: Text("Login",
                      style: TextStyle(fontSize: 24,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),),
                  )),
            ),
          ],
        ),
      ),
    );

  }

}