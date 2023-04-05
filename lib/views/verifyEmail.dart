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
          }
          , child: Text('click here to verify email '))
        ],
      ) ,
    );
}
}