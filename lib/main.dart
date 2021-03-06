import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sit_lb_2021/routes/homepage.dart';
import 'package:sit_lb_2021/routes/map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sit_lb_2021/service/authenticationservice.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService> (
      create: (_) => AuthenticationService(FirebaseAuth.instance),
    ),
    StreamProvider(
      create: (context) => context.read<AuthenticationService>().authStateChanges,
      ),
        ],

      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIT Hydropgraphy',
      home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget{

  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final firebaseUser = context.watch<User>();

    if(firebaseUser != null) {
      return Maps();
    }
    return Homepage();

  }
}

