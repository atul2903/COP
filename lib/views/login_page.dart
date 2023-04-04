import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../firebase_options.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override

   late final TextEditingController _email;
  late final TextEditingController _password;
  
  @override
  void initState() {
    _email=TextEditingController();
    _password=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
        super.dispose();
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login page')),
      ),
      body: FutureBuilder(
        
        future: Firebase.initializeApp(
         options: DefaultFirebaseOptions.currentPlatform,
       ),

        builder: (context, snapshot) {
          switch(snapshot.connectionState){

            case ConnectionState.done:
              // TODO: Handle this case.

               return  Column(
          children: [
            TextField(controller: _email,decoration: InputDecoration(hintText: 'Enter your email'),),
            TextField(controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(hintText: 'Enter password'),),
            TextButton(onPressed: () async{
              try
              { 
              final  email=_email.text;
              final password=_password.text;
            final usercredential=await  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      
            print(usercredential); }
            on FirebaseAuthException catch (e){
              if(e.code=='user-not-found')
              print('user not found');
              else{
                print(e.code);
              }
            } 
            },child: Center(child: const Text('Login')),),
            TextButton(onPressed:
            () {
              Navigator.of(context).pushNamedAndRemoveUntil('/register', (route) => false);
            }, child: const Text('Not registered yet? Register'))
          ],
        );
              
        default:
         return const Text('Loading....');
          }
         
        },
        
      ),
    );
  }
}
