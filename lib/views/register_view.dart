import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: Center(child: Text('Register page')),
        backgroundColor: Colors.yellow,
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
               try{

               
              final  email=_email.text;
              final password=_password.text;
            final usercredential=await  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
             print(usercredential);
               }
                on FirebaseAuthException  catch(e){
                  if(e.code=='weak-password'){
                    print('Weak password');
                                    AlertDialog alert= AlertDialog(  
    title: Text("Alert"),  
    content: Text("Enter A Strong Password."),  
     
      
  );  
 showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  ); 
                  }
                  else if(e.code=='invalid-email'){
                    print('Invalid email');
                                    AlertDialog alert= AlertDialog(  
    title: Text("Error"),  
    content: Text("Please Enter A Valid Email."),  
     
      
  );  
 showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  ); 

                  }
                  
                  else{
                    print(e);
                  }

                }
              
            },child: Center(child: const Text('Register')),),
            TextButton(onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
            }, child: const Text('Back to login'))
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