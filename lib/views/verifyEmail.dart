import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class verifyEmail extends StatefulWidget {
  const verifyEmail({super.key});

  @override
  State<verifyEmail> createState() => _verifyEmailState();
}

class _verifyEmailState extends State<verifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify email')),
      body:Column(
        children: [
          Text('verify your email address'),
          TextButton(onPressed: 
          () async{ final user=FirebaseAuth.instance.currentUser;
          await user?.sendEmailVerification();
          AlertDialog alert= AlertDialog(  
    title: Text("Notice"),  
    content: Text("An Email Has Been Sent to Your Account !"),  
     
      
  );  
 showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  


          }
          , child: Text('click here to verify email '))
        ],
      ) ,
    );
}
}