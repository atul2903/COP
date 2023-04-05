import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/views/login_page.dart';
import 'package:flutter_application_1/views/register_view.dart';
import 'package:flutter_application_1/views/verifyEmail.dart';
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
        actions: [
          PopupMenuButton(onSelected: (value) async{
            switch(value){
              
              case menuaction.logout:
               final logout=await showLogOutDialog(context);
               if(logout){
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
               }
                break;
            }
          },itemBuilder: (context) {
            return const [PopupMenuItem<menuaction>(value: menuaction.logout,child: Text('Log Out'))];
          },)
        ],
      ),
      body: FutureBuilder(
        
        future: Firebase.initializeApp(
         options: DefaultFirebaseOptions.currentPlatform,
       ),

        builder: (context, snapshot) {

          switch(snapshot.connectionState){
            
            case ConnectionState.done:
             final user=FirebaseAuth.instance.currentUser;
             print(user);
             if(user?.emailVerified??false){
              print('your email is verified');
             }
             else{
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => verifyEmail(),));
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

enum menuaction{
  logout
}


Future<bool> showLogOutDialog(BuildContext context){
  return showDialog<bool>(context: context, builder: (context) {
    return AlertDialog(
      title: const Text('Sign out'),
      content: const Text('Are You Sure You Want to Sign Out'),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(context).pop(false);
        }, child: Text('Cancel')),
        TextButton(onPressed: () {
          Navigator.of(context).pop(true);
        }, child: Text('Log Out'))
      ],
    );
  },).then((value) => value??false);
}