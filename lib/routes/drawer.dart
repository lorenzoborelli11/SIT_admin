import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:sit_lb_2021/routes/firebase_segnalaz.dart';
import 'package:sit_lb_2021/routes/homepage.dart';
import 'package:sit_lb_2021/routes/map.dart';
import 'package:sit_lb_2021/service/authenticationservice.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/download-removebg-preview.png',
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Maps(),
                    ),
                  ); },
                leading: Icon(Icons.home),
                title: Text('Map'),
              ),
              ListTile(
                onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Segnalazioni(),
                ),
              ); },
                leading: Icon(Icons.map),
                title: Text('Segnalazioni'),
              ),
              ListTile(
                onTap: () {
                  context.read<AuthenticationService>().signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage(),
                    ),
                  );
                },


                leading: Icon(Icons.account_circle_rounded),
                title: Text('Logout'),
              ),

              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('Terms of Service | Borelli SIT Hydrography'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
