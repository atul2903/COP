import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/views/login_page.dart';
import 'package:flutter_application_1/views/register_view.dart';
import '../firebase_options.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const LoginView() ,
      routes: {
        '/register' : (context)=>RegisterView(),
        '/login/':(context) => (LoginView()),
      },
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Home page')),
      ),
      body: FutureBuilder(
        
        future: Firebase.initializeApp(
         options: DefaultFirebaseOptions.currentPlatform,
       ),

        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            
            case ConnectionState.done:
             final user=FirebaseAuth.instance.currentUser;
             if(user?.emailVerified??false){
              print('your email is verified');
             }
             else{
              print("your email isn't verified");
             }
             return Text('done');
              
        default:
         return const Text('Loading....');
          }
         
        },
        
      ),
    );
  }
}

